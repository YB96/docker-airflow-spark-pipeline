
\c sql_book_o_reilly;


DROP TABLE IF EXISTS legislators;

CREATE TABLE legislators (
    full_name VARCHAR, -- name_official_full
    first_name VARCHAR, -- name_first
    last_name VARCHAR, -- name_last
    middle_name VARCHAR, -- name_middle
    nickname VARCHAR, -- name_nickname
    suffix VARCHAR, -- name_suffix
    other_names_end DATE, -- other_names_0_end
    other_names_middle VARCHAR, -- other_names_0_middle
    other_names_last VARCHAR, -- other_names_0_last
    birthday DATE, -- bio_birthday
    gender VARCHAR, -- bio_gender
    id_bioguide VARCHAR PRIMARY KEY,
    id_bioguide_previous_0 VARCHAR,
    id_govtrack INT,
    id_icpsr INT,
    id_wikipedia VARCHAR,
    id_wikidata VARCHAR,
    id_google_entity_id VARCHAR,
    id_house_history BIGINT,
    id_house_history_alternate INT,
    id_thomas INT,
    id_cspan INT,
    id_votesmart INT,
    id_lis VARCHAR,
    id_ballotpedia VARCHAR,
    id_opensecrets VARCHAR,
    id_fec_0 VARCHAR,
    id_fec_1 VARCHAR,
    id_fec_2 VARCHAR
);

COPY legislators
FROM '/datafiles/sql_book_o_reilly/raw/legislators/legislators.csv' 
DELIMITER ','
CSV HEADER;
