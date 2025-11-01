

\c sql_book_o_reilly;


DROP TABLE IF EXISTS legislators_terms;

CREATE TABLE legislators_terms (
    id_bioguide VARCHAR,
    term_number INT,
    term_id VARCHAR PRIMARY KEY,
    term_type VARCHAR,
    term_start DATE,
    term_end DATE,
    state VARCHAR,
    district INT,
    class INT,
    party VARCHAR,
    how VARCHAR,
    url VARCHAR, -- terms_1_url
    address VARCHAR, -- terms_1_address
    phone VARCHAR, -- terms_1_phone
    fax VARCHAR, -- terms_1_fax
    contact_form VARCHAR, -- terms_1_contact_form
    office VARCHAR, -- terms_1_office
    state_rank VARCHAR, -- terms_1_state_rank
    rss_url VARCHAR, -- terms_1_rss_url
    caucus VARCHAR -- terms_1_caucus
);


COPY legislators_terms
FROM '/datafiles/sql_book_o_reilly/raw/legislators/legislators_terms.csv'
DELIMITER ','
CSV HEADER;
