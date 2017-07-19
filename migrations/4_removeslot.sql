-- run as following
-- $ psql --host=pocgreenhouse.c8ny4vsbt3vl.eu-west-1.rds.amazonaws.com --port=5432 --username root --password --dbname=testdb1 -v slot="'test_slot1'" -f 4_removeslot.sql

-- to remove the slot
-- SELECT pg_drop_replication_slot(:slot);