-- run as following
-- $ psql --host=pocgreenhouse.c8ny4vsbt3vl.eu-west-1.rds.amazonaws.com --port=5432 --username root --password --dbname=testdb1 -v slot="'test_slot1'" -f 3_peekrecords.sql

-- check wal records
SELECT * FROM pg_logical_slot_peek_changes(:slot, NULL, NULL);

-- to get records, it will update the index
-- SELECT * FROM pg_logical_slot_get_changes(:slot, NULL, NULL);