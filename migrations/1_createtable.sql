CREATE USER datacoral WITH PASSWORD 'Datacoral#23';
ALTER USER datacoral WITH PASSWORD 'Datacoral#23';
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO datacoral;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON SEQUENCES TO datacoral;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO datacoral;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO datacoral;
GRANT rds_replication to datacoral;

CREATE TABLE table1(
 id serial PRIMARY KEY,
 username VARCHAR (50) UNIQUE NOT NULL,
 password VARCHAR (50) NOT NULL,
 email VARCHAR (355) UNIQUE NOT NULL,
 created_on TIMESTAMP NOT NULL,
 last_login TIMESTAMP,
 mybool BOOLEAN NOT NULL,
 mynumeric NUMERIC (5, 2),
 mysmall SMALLINT NOT NULL,
 myint INT NOT NULL,
 mybigint BIGINT NOT NULL,
 mydate DATE NOT NULL DEFAULT CURRENT_DATE,
 myts TIMESTAMP,
 mytsz TIMESTAMPTZ,
 col1 VARCHAR(355),
 col2 VARCHAR(355),
 col3 VARCHAR(355),
 col4 VARCHAR(355),
 col5 VARCHAR(355),
 col6 VARCHAR(355),
 col7 VARCHAR(355),
 col8 VARCHAR(355),
 col9 VARCHAR(355),
 col10 VARCHAR(355),
 col11 VARCHAR(355),
 col12 VARCHAR(355),
 col13 VARCHAR(355),
 col14 VARCHAR(355),
 col15 VARCHAR(355),
 col16 VARCHAR(355),
 col17 VARCHAR(355),
 col18 VARCHAR(355),
 col19 VARCHAR(355),
 col20 VARCHAR(355),
 col21 VARCHAR(355),
 col22 VARCHAR(355),
 col23 VARCHAR(355),
 col24 VARCHAR(355),
 col25 VARCHAR(355),
 col26 VARCHAR(355),
 col27 VARCHAR(355),
 col28 VARCHAR(355),
 col29 VARCHAR(355),
 col30 VARCHAR(355),
 col31 VARCHAR(355),
 col32 VARCHAR(355),
 col33 VARCHAR(355),
 col34 VARCHAR(355),
 col35 VARCHAR(355),
 col36 VARCHAR(355),
 col37 VARCHAR(355),
 col38 VARCHAR(355),
 col39 VARCHAR(355),
 col40 VARCHAR(355),
 col41 VARCHAR(355),
 col42 VARCHAR(355),
 col43 VARCHAR(355),
 col44 VARCHAR(355),
 col45 VARCHAR(355),
 col46 VARCHAR(355),
 col47 VARCHAR(355),
 col48 VARCHAR(355),
 col49 VARCHAR(355),
 col50 VARCHAR(355),
 col51 VARCHAR(355),
 col52 VARCHAR(355),
 col53 VARCHAR(355),
 col54 VARCHAR(355),
 col55 VARCHAR(355),
 col56 VARCHAR(355),
 col57 VARCHAR(355),
 col58 VARCHAR(355),
 col59 VARCHAR(355),
 col60 VARCHAR(355),
 col61 VARCHAR(355),
 col62 VARCHAR(355),
 col63 VARCHAR(355),
 col64 VARCHAR(355),
 col65 VARCHAR(355),
 col66 VARCHAR(355),
 col67 VARCHAR(355),
 col68 VARCHAR(355),
 col69 VARCHAR(355),
 col70 VARCHAR(355),
 col71 VARCHAR(355),
 col72 VARCHAR(355),
 col73 VARCHAR(355),
 col74 VARCHAR(355),
 col75 VARCHAR(355),
 col76 VARCHAR(355),
 col77 VARCHAR(355),
 col78 VARCHAR(355),
 col79 VARCHAR(355),
 col80 VARCHAR(355),
 col81 VARCHAR(355),
 col82 VARCHAR(355),
 col83 VARCHAR(355),
 col84 VARCHAR(355),
 col85 VARCHAR(355),
 col86 VARCHAR(355),
 col87 VARCHAR(355),
 col88 VARCHAR(355),
 col89 VARCHAR(355),
 col90 VARCHAR(355),
 col91 VARCHAR(355),
 col92 VARCHAR(355),
 col93 VARCHAR(355),
 col94 VARCHAR(355),
 col95 VARCHAR(355),
 col96 VARCHAR(355),
 col97 VARCHAR(355),
 col98 VARCHAR(355),
 col99 VARCHAR(355),
 col100 VARCHAR(355)
);

CREATE TABLE  table2 (
 id serial PRIMARY KEY,
 name VARCHAR (50) UNIQUE NOT NULL,
 age INT NOT NULL,
 address VARCHAR (50) NOT NULL,
 salary  VARCHAR(355),
 join_date TIMESTAMP NOT NULL
);