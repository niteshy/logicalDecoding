-- run as following
-- $ psql --host=${PGHOST} --port=5432 --username ${PGUSER} --password --dbname=${PGDATABASE} -v slot="'test_slot1'" -f 3_peekrecords.sql

-- check wal records
SELECT * FROM pg_logical_slot_peek_changes(:slot, NULL, NULL);

-- to get records, it will update the index
-- SELECT * FROM pg_logical_slot_get_changes(:slot, NULL, NULL);