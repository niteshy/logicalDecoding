-- run as following
-- $ psql --host=${PGHOST} --port=5432 --username ${PGUSER} --password --dbname=${PGDATABASE} -v slot="'test_slot1'" -f 2_createreplicationslot.sql

-- create logical replication slot
SELECT * FROM pg_create_logical_replication_slot(:slot, 'test_decoding');

-- check replication_slots
SELECT * FROM pg_replication_slots;

-- check wal records
SELECT * FROM pg_logical_slot_peek_changes(:slot, NULL, NULL);