-- run as following
-- $ psql --host=pocgreenhouse.c8ny4vsbt3vl.eu-west-1.rds.amazonaws.com --port=5432 --username root --password --dbname=testdb1 -v slot="'test_slot1'" -f 2_createreplicationslot.sql

-- create logical replication slot
SELECT * FROM pg_create_logical_replication_slot(:slot, 'test_decoding');

-- check replication_slots
SELECT * FROM pg_replication_slots;

-- check wal records
SELECT * FROM pg_logical_slot_peek_changes(:slot, NULL, NULL);