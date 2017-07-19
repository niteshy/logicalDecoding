-- run as following
-- $ psql --host=${PGHOST} --port=5432 --username ${PGUSER} --password --dbname=${PGDATABASE} -v slot="'test_slot1'" -f 4_removeslot.sql

-- to remove the slot
-- SELECT pg_drop_replication_slot(:slot);