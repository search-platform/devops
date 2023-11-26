#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE "search-platform";
    GRANT ALL PRIVILEGES ON DATABASE "search-platform" TO postgres;

    \c "search-platform"

    CREATE TABLE "user" (
        "id" SERIAL PRIMARY KEY,
        "login" varchar,
        "password" varchar
    );

    CREATE TABLE "country" (
                            "id" SERIAL PRIMARY KEY,
                            "name" varchar
    );

    CREATE TABLE "organization" (
                                    "id" SERIAL PRIMARY KEY,
                                    "type" varchar,
                                    "name" varchar,
                                    "address" varchar,
                                    "logo_url" varchar,
                                    "name_vector_eng" tsvector GENERATED ALWAYS AS (to_tsvector('english', name)) STORED,
                                    "address_vector_eng" tsvector GENERATED ALWAYS AS (to_tsvector('english', address)) STORED,
                                    "county_id" bigint
    );
    ALTER TABLE "organization" ADD FOREIGN KEY ("county_id") REFERENCES "country" ("id");

    CREATE TABLE "contact" (
                            "id" SERIAL PRIMARY KEY,
                            "type" varchar,
                            "description" varchar,
                            "value" varchar,
                            "organization_id" bigint,
                            "value_vector_eng" tsvector GENERATED ALWAYS AS (to_tsvector('english', "value")) STORED
    );
    ALTER TABLE "contact" ADD FOREIGN KEY ("organization_id") REFERENCES "organization" ("id");

    CREATE TABLE "organization_common_vector" (
                                                "organization_id" bigint,
                                                "search_vector" tsvector
    );

    ALTER TABLE "organization_common_vector" ADD FOREIGN KEY ("organization_id") REFERENCES "organization" ("id");

    INSERT INTO "country" ("name") VALUES ('Afghanistan');
    INSERT INTO "country" ("name") VALUES ('Albania');
    INSERT INTO "country" ("name") VALUES ('Algeria');
    INSERT INTO "country" ("name") VALUES ('Andorra');
    INSERT INTO "country" ("name") VALUES ('Angola');
    INSERT INTO "country" ("name") VALUES ('Antigua and Barbuda');
    INSERT INTO "country" ("name") VALUES ('Argentina');
    INSERT INTO "country" ("name") VALUES ('Armenia');
    INSERT INTO "country" ("name") VALUES ('Australia');
    INSERT INTO "country" ("name") VALUES ('Austria');
    INSERT INTO "country" ("name") VALUES ('Azerbaijan');
    INSERT INTO "country" ("name") VALUES ('Bahamas');
    INSERT INTO "country" ("name") VALUES ('Bahrain');
    INSERT INTO "country" ("name") VALUES ('Bangladesh');
    INSERT INTO "country" ("name") VALUES ('Barbados');
    INSERT INTO "country" ("name") VALUES ('Belarus');
    INSERT INTO "country" ("name") VALUES ('Belgium');
    INSERT INTO "country" ("name") VALUES ('Belize');
    INSERT INTO "country" ("name") VALUES ('Benin');
    INSERT INTO "country" ("name") VALUES ('Bhutan');
    INSERT INTO "country" ("name") VALUES ('Bolivia');
    INSERT INTO "country" ("name") VALUES ('Bosnia and Herzegovina');
    INSERT INTO "country" ("name") VALUES ('Botswana');
    INSERT INTO "country" ("name") VALUES ('Brazil');
    INSERT INTO "country" ("name") VALUES ('Brunei');
    INSERT INTO "country" ("name") VALUES ('Bulgaria');
    INSERT INTO "country" ("name") VALUES ('Burkina Faso');
    INSERT INTO "country" ("name") VALUES ('Burundi');
    INSERT INTO "country" ("name") VALUES ('Cambodia');
    INSERT INTO "country" ("name") VALUES ('Cameroon');
    INSERT INTO "country" ("name") VALUES ('Canada');
    INSERT INTO "country" ("name") VALUES ('Cape Verde');
    INSERT INTO "country" ("name") VALUES ('Central African Republic');
    INSERT INTO "country" ("name") VALUES ('Chad');
    INSERT INTO "country" ("name") VALUES ('Chile');
    INSERT INTO "country" ("name") VALUES ('China');
    INSERT INTO "country" ("name") VALUES ('Colombia');
    INSERT INTO "country" ("name") VALUES ('Comoros');
    INSERT INTO "country" ("name") VALUES ('Congo, Democratic Republic of the');
    INSERT INTO "country" ("name") VALUES ('Congo, Republic of the');
    INSERT INTO "country" ("name") VALUES ('Costa Rica');
    INSERT INTO "country" ("name") VALUES ('Côte d’Ivoire');
    INSERT INTO "country" ("name") VALUES ('Croatia');
    INSERT INTO "country" ("name") VALUES ('Cuba');
    INSERT INTO "country" ("name") VALUES ('Cyprus');
    INSERT INTO "country" ("name") VALUES ('Czech Republic');
    INSERT INTO "country" ("name") VALUES ('Denmark');
    INSERT INTO "country" ("name") VALUES ('Djibouti');
    INSERT INTO "country" ("name") VALUES ('Dominica');
    INSERT INTO "country" ("name") VALUES ('Dominican Republic');
    INSERT INTO "country" ("name") VALUES ('East Timor');
    INSERT INTO "country" ("name") VALUES ('Ecuador');
    INSERT INTO "country" ("name") VALUES ('Egypt');
    INSERT INTO "country" ("name") VALUES ('El Salvador');
    INSERT INTO "country" ("name") VALUES ('Equatorial Guinea');
    INSERT INTO "country" ("name") VALUES ('Eritrea');
    INSERT INTO "country" ("name") VALUES ('Estonia');
    INSERT INTO "country" ("name") VALUES ('Eswatini');
    INSERT INTO "country" ("name") VALUES ('Ethiopia');
    -- ... continue with the rest of the countries
    INSERT INTO "country" ("name") VALUES ('Fiji');
    INSERT INTO "country" ("name") VALUES ('Finland');
    INSERT INTO "country" ("name") VALUES ('France');
    INSERT INTO "country" ("name") VALUES ('Gabon');
    INSERT INTO "country" ("name") VALUES ('Gambia');
    INSERT INTO "country" ("name") VALUES ('Georgia');
    INSERT INTO "country" ("name") VALUES ('Germany');
    INSERT INTO "country" ("name") VALUES ('Ghana');
    INSERT INTO "country" ("name") VALUES ('Greece');
    INSERT INTO "country" ("name") VALUES ('Grenada');
    INSERT INTO "country" ("name") VALUES ('Guatemala');
    INSERT INTO "country" ("name") VALUES ('Guinea');
    INSERT INTO "country" ("name") VALUES ('Guinea-Bissau');
    INSERT INTO "country" ("name") VALUES ('Guyana');
    INSERT INTO "country" ("name") VALUES ('Haiti');
    INSERT INTO "country" ("name") VALUES ('Honduras');
    INSERT INTO "country" ("name") VALUES ('Hungary');
    INSERT INTO "country" ("name") VALUES ('Iceland');
    INSERT INTO "country" ("name") VALUES ('India');
    INSERT INTO "country" ("name") VALUES ('Indonesia');
    INSERT INTO "country" ("name") VALUES ('Iran');
    INSERT INTO "country" ("name") VALUES ('Iraq');
    INSERT INTO "country" ("name") VALUES ('Ireland');
    INSERT INTO "country" ("name") VALUES ('Israel');
    INSERT INTO "country" ("name") VALUES ('Italy');
    INSERT INTO "country" ("name") VALUES ('Jamaica');
    INSERT INTO "country" ("name") VALUES ('Japan');
    INSERT INTO "country" ("name") VALUES ('Jordan');
    INSERT INTO "country" ("name") VALUES ('Kazakhstan');
    INSERT INTO "country" ("name") VALUES ('Kenya');
    INSERT INTO "country" ("name") VALUES ('Kiribati');
    INSERT INTO "country" ("name") VALUES ('Korea, North');
    INSERT INTO "country" ("name") VALUES ('Korea, South');
    INSERT INTO "country" ("name") VALUES ('Kuwait');
    INSERT INTO "country" ("name") VALUES ('Kyrgyzstan');
    -- ... continue for the rest of the countries
    INSERT INTO "country" ("name") VALUES ('Laos');
    INSERT INTO "country" ("name") VALUES ('Latvia');
    INSERT INTO "country" ("name") VALUES ('Lebanon');
    INSERT INTO "country" ("name") VALUES ('Lesotho');
    INSERT INTO "country" ("name") VALUES ('Liberia');
    INSERT INTO "country" ("name") VALUES ('Libya');
    INSERT INTO "country" ("name") VALUES ('Liechtenstein');
    INSERT INTO "country" ("name") VALUES ('Lithuania');
    INSERT INTO "country" ("name") VALUES ('Luxembourg');
    INSERT INTO "country" ("name") VALUES ('Macedonia');
    INSERT INTO "country" ("name") VALUES ('Madagascar');
    INSERT INTO "country" ("name") VALUES ('Malawi');
    INSERT INTO "country" ("name") VALUES ('Malaysia');
    INSERT INTO "country" ("name") VALUES ('Maldives');
    INSERT INTO "country" ("name") VALUES ('Mali');
    INSERT INTO "country" ("name") VALUES ('Malta');
    INSERT INTO "country" ("name") VALUES ('Marshall Islands');
    INSERT INTO "country" ("name") VALUES ('Mauritania');
    INSERT INTO "country" ("name") VALUES ('Mauritius');
    INSERT INTO "country" ("name") VALUES ('Mexico');
    INSERT INTO "country" ("name") VALUES ('Micronesia');
    INSERT INTO "country" ("name") VALUES ('Moldova');
    INSERT INTO "country" ("name") VALUES ('Monaco');
    INSERT INTO "country" ("name") VALUES ('Mongolia');
    INSERT INTO "country" ("name") VALUES ('Montenegro');
    INSERT INTO "country" ("name") VALUES ('Morocco');
    INSERT INTO "country" ("name") VALUES ('Mozambique');
    INSERT INTO "country" ("name") VALUES ('Myanmar');
    INSERT INTO "country" ("name") VALUES ('Namibia');
    INSERT INTO "country" ("name") VALUES ('Nauru');
    INSERT INTO "country" ("name") VALUES ('Nepal');
    INSERT INTO "country" ("name") VALUES ('Netherlands');
    INSERT INTO "country" ("name") VALUES ('New Zealand');
    INSERT INTO "country" ("name") VALUES ('Nicaragua');
    INSERT INTO "country" ("name") VALUES ('Niger');
    INSERT INTO "country" ("name") VALUES ('Nigeria');
    INSERT INTO "country" ("name") VALUES ('Norway');
    INSERT INTO "country" ("name") VALUES ('Oman');
    INSERT INTO "country" ("name") VALUES ('Pakistan');
    INSERT INTO "country" ("name") VALUES ('Palau');
    INSERT INTO "country" ("name") VALUES ('Palestine');
    INSERT INTO "country" ("name") VALUES ('Panama');
    INSERT INTO "country" ("name") VALUES ('Papua New Guinea');
    INSERT INTO "country" ("name") VALUES ('Paraguay');
    INSERT INTO "country" ("name") VALUES ('Peru');
    INSERT INTO "country" ("name") VALUES ('Philippines');
    INSERT INTO "country" ("name") VALUES ('Poland');
    INSERT INTO "country" ("name") VALUES ('Portugal');
    INSERT INTO "country" ("name") VALUES ('Qatar');
    INSERT INTO "country" ("name") VALUES ('Romania');
    INSERT INTO "country" ("name") VALUES ('Russia');
    INSERT INTO "country" ("name") VALUES ('Rwanda');
    -- ... continue for the rest of the countries
    INSERT INTO "country" ("name") VALUES ('Saint Kitts and Nevis');
    INSERT INTO "country" ("name") VALUES ('Saint Lucia');
    INSERT INTO "country" ("name") VALUES ('Saint Vincent and the Grenadines');
    INSERT INTO "country" ("name") VALUES ('Samoa');
    INSERT INTO "country" ("name") VALUES ('San Marino');
    INSERT INTO "country" ("name") VALUES ('Sao Tome and Principe');
    INSERT INTO "country" ("name") VALUES ('Saudi Arabia');
    INSERT INTO "country" ("name") VALUES ('Senegal');
    INSERT INTO "country" ("name") VALUES ('Serbia');
    INSERT INTO "country" ("name") VALUES ('Seychelles');
    INSERT INTO "country" ("name") VALUES ('Sierra Leone');
    INSERT INTO "country" ("name") VALUES ('Singapore');
    INSERT INTO "country" ("name") VALUES ('Slovakia');
    INSERT INTO "country" ("name") VALUES ('Slovenia');
    INSERT INTO "country" ("name") VALUES ('Solomon Islands');
    INSERT INTO "country" ("name") VALUES ('Somalia');
    INSERT INTO "country" ("name") VALUES ('South Africa');
    INSERT INTO "country" ("name") VALUES ('South Sudan');
    INSERT INTO "country" ("name") VALUES ('Spain');
    INSERT INTO "country" ("name") VALUES ('Sri Lanka');
    INSERT INTO "country" ("name") VALUES ('Sudan');
    INSERT INTO "country" ("name") VALUES ('Suriname');
    INSERT INTO "country" ("name") VALUES ('Sweden');
    INSERT INTO "country" ("name") VALUES ('Switzerland');
    INSERT INTO "country" ("name") VALUES ('Syria');
    INSERT INTO "country" ("name") VALUES ('Taiwan');
    INSERT INTO "country" ("name") VALUES ('Tajikistan');
    INSERT INTO "country" ("name") VALUES ('Tanzania');
    INSERT INTO "country" ("name") VALUES ('Thailand');
    INSERT INTO "country" ("name") VALUES ('Togo');
    INSERT INTO "country" ("name") VALUES ('Tonga');
    INSERT INTO "country" ("name") VALUES ('Trinidad and Tobago');
    INSERT INTO "country" ("name") VALUES ('Tunisia');
    INSERT INTO "country" ("name") VALUES ('Turkey');
    INSERT INTO "country" ("name") VALUES ('Turkmenistan');
    INSERT INTO "country" ("name") VALUES ('Tuvalu');
    INSERT INTO "country" ("name") VALUES ('Uganda');
    INSERT INTO "country" ("name") VALUES ('Ukraine');
    INSERT INTO "country" ("name") VALUES ('United Arab Emirates');
    INSERT INTO "country" ("name") VALUES ('United Kingdom');
    INSERT INTO "country" ("name") VALUES ('United States');
    INSERT INTO "country" ("name") VALUES ('Uruguay');
    INSERT INTO "country" ("name") VALUES ('Uzbekistan');
    INSERT INTO "country" ("name") VALUES ('Vanuatu');
    INSERT INTO "country" ("name") VALUES ('Vatican City');
    INSERT INTO "country" ("name") VALUES ('Venezuela');
    INSERT INTO "country" ("name") VALUES ('Vietnam');
    INSERT INTO "country" ("name") VALUES ('Yemen');
    INSERT INTO "country" ("name") VALUES ('Zambia');
    INSERT INTO "country" ("name") VALUES ('Zimbabwe');


    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'JPMorgan Chase', 'New York City', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'Bank of America', 'Charlotte', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'Citigroup', 'New York City', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'Wells Fargo', 'San Francisco', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'Goldman Sachs', 'New York City', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'Morgan Stanley', 'New York City', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'U.S. Bancorp', 'Minneapolis', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'PNC Financial Services', 'Pittsburgh', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'Truist Financial', 'Charlotte', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'TD Bank, N.A.', 'Cherry Hill, New Jersey', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'Charles Schwab Corporation', 'Westlake, Texas', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'Capital One', 'McLean, Virginia', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'The Bank of New York Mellon', 'New York City', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'State Street Corporation', 'Boston', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'BMO USA', 'Chicago', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'American Express', 'New York City', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'HSBC Bank USA', 'New York City', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'Citizens Financial Group', 'Providence, Rhode Island', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'First Citizens BancShares', 'Raleigh, North Carolina', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "logo_url", "county_id") VALUES ('BANK', 'M&T Bank', 'Buffalo, New York', 'http://example.com/logo.png', 2);

    -- Inserts for organization_id = 2
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales2@example.com', 1);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support2@example.com', 1);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-0200', 1);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-0201', 1);

    -- Inserts for organization_id = 3
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales3@example.com', 2);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support3@example.com', 2);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-0300', 2);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-0301', 2);

    -- Inserts for organization_id = 4
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales4@example.com', 3);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support4@example.com', 3);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-0400', 3);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-0401', 3);

    -- Inserts for organization_id = 5
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales5@example.com', 4);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support5@example.com', 4);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-0500', 4);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-0501', 4);

    -- Inserts for organization_id = 6
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales6@example.com', 5);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support6@example.com', 5);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-0600', 5);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-0601', 5);

    -- Inserts for organization_id = 7
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales7@example.com', 6);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support7@example.com', 6);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-0700', 6);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-0701', 6);

    -- Inserts for organization_id = 8
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales8@example.com', 7);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support8@example.com', 7);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-0800', 7);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-0801', 7);

    -- Inserts for organization_id = 9
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales9@example.com', 8);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support9@example.com', 8);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-0900', 8);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-0901', 8);

    -- Inserts for organization_id = 10
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales10@example.com', 9);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support10@example.com', 9);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1000', 9);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1001', 9);

    -- Inserts for organization_id = 11
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales11@example.com', 10);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support11@example.com', 10);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1100', 10);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1101', 10);

    -- Inserts for organization_id = 12
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales12@example.com', 11);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support12@example.com', 11);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1200', 11);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1201', 11);

    -- Inserts for organization_id = 13
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales13@example.com', 12);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support13@example.com', 12);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1300', 12);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1301', 12);

    -- Inserts for organization_id = 14
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales14@example.com', 13);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support14@example.com', 13);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1400', 13);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1401', 13);

    -- Inserts for organization_id = 15
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales15@example.com', 14);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support15@example.com', 14);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1500', 14);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1501', 14);

    -- Inserts for organization_id = 16
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales16@example.com', 15);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support16@example.com', 15);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1600', 15);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1601', 15);

    -- Inserts for organization_id = 17
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales17@example.com', 16);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support17@example.com', 16);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1700', 16);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1701', 16);

    -- Inserts for organization_id = 18
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales18@example.com', 17);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support18@example.com', 17);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1800', 17);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1801', 17);

    -- Inserts for organization_id = 19
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales19@example.com', 18);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support19@example.com', 18);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-1900', 18);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-1901', 18);

    -- Inserts for organization_id = 20
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales20@example.com', 19);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support20@example.com', 19);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-2000', 19);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-2001', 19);

    -- Inserts for organization_id = 21
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Sales Department', 'sales21@example.com', 20);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('EMAIL', 'Support Department', 'support21@example.com', 20);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Sales Department', '555-2100', 20);
    INSERT INTO "contact" ("type", "description", "value", "organization_id") VALUES ('PHONE', 'Support Department', '555-2101', 20);

EOSQL
