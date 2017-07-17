# Logical-Decoding POC

This explain the setup and a sample code for POC of logical decoding of pg data source.

## Configurations

For setting the logical decoding, we need to enable some of system level parameters.

```
wal_level = logical
max_wal_senders = 10
max_replication_slots = 10
```

### Optional Configuration (plugin)

If you need to do custom plugins like [JSONCDC](https://github.com/posix4e/jsoncdc), then please follow steps:

**To install the [JSONCDC](https://github.com/posix4e/jsoncdc) logical decoding plugin using pgxn:**

1) Install easy_install
```shell
sudo easy_install pgxnclient
```
2) Install jsoncdc using pgxn
```shell
pgxn install jsoncdc --unstable
```
3) jsoncdc might have rust dependencies, so you may need to install rust and development python modules.
4) Set shared_preload_libraries to 'jsoncdc' in postgresql.conf
```shell
ps aux | grep postgres
```
Output will have the location of postgresql.conf file after `-D` option.
```
Nitesh           11126   0.0  0.0  2621312    560   ??  S    Fri06PM   1:15.19 /Applications/Postgres.app/Contents/Versions/9.6/bin/postgres -D /Users/Nitesh/Library/Application Support/Postgres/var-9.6 -p 5432
```
Set shared_preload_libraries
```
shared_preload_libraries = 'jsoncdc'
```
5) Reboot postgres server, after this you should be able to create slots with `jsoncdc`

#### AWS RDS Configuration

For enabling logical decoding on AWS RDS. You need to set `rds.logical_replication` to 1.

You need to edit the parameter group to modify parameters (such as rds.logical_replication) directly from the RDS Console,. The default parameter group cannot be modified. So you need to create a new parameter group for your Postgres version, and then edit the rds.logical_replication to 1. You then need to modify the Postgres instance to use this new parameter group, and check the apply immediately tab.  Reboot the instance to have the parameter take effect.

As part of applying this rds.logical_replication parameter, RDS sets the wal_level, max_wal_senders, max_replication_slots and max_connections parameters. Note that these parameter changes can increase WAL generation so you should only set the rds.logical_replication parameter when you are using logical slots [1].


## How logical decoding works !

Logical decoding works on replication_slot, you creates a replication_slot and then the database will start recording each DML (insert/update/delete) operation into disk. Now it consumer responsibility to fetch the records independently. Postgres only provides only two operation symantics over replication_slot ie (peek and get). Peek operation basically let you fetch the records without modifying the wal indexes. Get operation will update the wal index, hence all the entries before that index can be removed.

Following operations can be executed from pg command prompt:

1) First you need to create a logical_replication_slot:
```
testdb1=> -- Create a slot named 'test_slot' using the default output plugin 'test_decoding'
testdb1=> SELECT * FROM pg_create_logical_replication_slot('test_slot', 'test_decoding');

```
2) After this, all the changes will get recorded into above created slot (ie `test_slot`)
3) You can peek the changes using following command.
```
testdb1=> -- You can also peek ahead in the change stream without consuming changes
testdb1=> SELECT * FROM pg_logical_slot_peek_changes('test_slot', NULL, NULL);
```
5) To peek the records till specific xid & location, you can specific those xid, location into a params as following. This will read the records from the start till last transaction before the specified value. You need to specify either the combination of both xid & location or just location in the query, just xid won't work. Because each xid correspond to a transactions and location correspond to a query statement.
```
testdb1=> SELECT * FROM pg_logical_slot_peek_changes('test_slot', '3/34000C08', 6113);
```
4) You can consume the records using get command
```
testdb1=> -- Once changes are read, they're consumed and will not emitted in a subsequent call:
testdb1=> SELECT * FROM pg_logical_slot_get_changes('test_slot', NULL, NULL);
```

## How to consume the replication data ?

I have written a simple script (logicalDecoding.js) to demonstrate how to consume the replication records in a realiable manner.

It first peek the current replication_slot, to find out all the records available to consume. Then split them into a chunk of size `CHUNKSIZE` (ie 1000) and fetch them separately to process them (here I am only printing them, we can parse them and upload to different database like solr). After each chunk, we need to do `get` operation on the same chunk so that these records will NOT be fetched in the subsequent calls.

## Benchmarking

I have created a test_slot and then inserted 'x' (insert/update) entries into a database. After that, everytime run this script it take approx 'y' sec to fetch all the records. If the server and client reside at different location that will introduce a latency factor.


### Scenario 1

- Database = AWS RDS
- Server location = eu-west-1
- Client location = India (Bangalore)

I have created a test_slot and then inserted approx 10K (insert/update) entries into a database. After that, everytime run this script it take approx 25sec to fetch all the records. This cluster is in eu-west-1 region whereas I am running queries from my latop.

Total records = 10,000
Time taken = 25 sec

Throughput = 10000 / 25 = 400 records per sec.

### Scenario 2

- Database = Postgres
- Server location = Local laptop
- Client location = Local laptop



