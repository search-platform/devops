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
                                    "url" varchar,
                                    "logo_url" varchar,
                                    "fav_icon" varchar,
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

    INSERT INTO "country" ("name") VALUES ('USA');
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



    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'JPMorgan Chase', 'New York City', 'https://www.jpmorganchase.com/', 'data:image/jpeg;base64,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1VtNbdDF0mnvyzS50xCbD85uFL/MClc1sDW7Nja0Aiw+1e58b+C02N4XBnjCo8RpS2Fze7WAfqsYLucB1cG8vrAjwVXi+ZMMzTC2TH4Z6eoa0Avp9DmvA6d7p1FxccrlcOCZzblyttgsH0c/0jZSDLN4FzwLMtvZrRbc3ve458s3FZVUl6evPXx1OjNHM8zuL9fT28DPYziTsYxSSefYvdcDnpaNmtHkGgD2Xdkiubh2baaWc2aJLE9AHgsufIarrvxOpwfiumw2KpLjciB+hsLXEdXNJdpB30g+VwFlbbbrdVKOWmlsYO4yu09bN52y0joM1tkcO7JC2x82Egj/ACn3WDWvhzgzEcFbSZqifUMZ/RzRkCeOwsPm2fttud+tzuqhzMPhfdr6mcdGFkcPs6TU/wDJqrh5oRyyW3Tn73l8RKcsye/X7/o+M2EmHLkdU+44kz42joWsaO9/eLh7LY9oJ42SMLfB8gi0m3R3DjFvXuPCzGMZkfi2ER080bGNikLo9GzWMLQ0MA5mxBOokk3U4bmDh4O6jxRhnpy7W0NOmSF/1o3EEdTdpFjc8rm8ZZOpNapvTuaClFXFbNL1RRL0LHCIex6iZP8AO6YuZfnp1TG/ppcPxWRibQxzXmfUSt+oI44y7yMnEdpHmGn2XZiGZP0tjUEmIxN+HhLGtp2fK2JpF2i/MkAAk87dApmnJquNf4iIVFO3vp/WZ9SrvOOIUuJ4yZMCg+Hi0NGnS1t3C93aW3Ddi0beF+qpFrF2k2qMpKnSdhERSQEREBCKUQBERAQilEAREQBQpRAQpREAREQEIpRAQpREBClEQBQpRAQpREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAEREAREQBERAf/Z', 'https://www.favicon.cc/logo3d/650946.png', 1);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'Bank of America', 'Charlotte', 'https://www.bankofamerica.com/', 'https://w7.pngwing.com/pngs/312/908/png-transparent-united-states-bank-of-america-small-business-united-states-flag-text-logo.png', 'https://icons8.com/icon/QxCQEYp6HT8Z/bank-of-america', 1);

    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'Intesa Sanpaolo', 'Turin', 'https://group.intesasanpaolo.com/en/', 'https://www.paolocrespi.eu/wp-content/uploads/2022/11/intesa-sanpaolo-squarelogo.png', 'https://asset.brandfetch.io/idUdLcZYDO/idFjvLZAva.jpeg?updated=1667836726367', 85);

    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'Wells Fargo', 'San Francisco', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'Goldman Sachs', 'New York City', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'Morgan Stanley', 'New York City', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'U.S. Bancorp', 'Minneapolis', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'PNC Financial Services', 'Pittsburgh', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'Truist Financial', 'Charlotte', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 1);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'TD Bank, N.A.', 'Cherry Hill, New Jersey', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'Charles Schwab Corporation', 'Westlake, Texas', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'Capital One', 'McLean, Virginia', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'The Bank of New York Mellon', 'New York City', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'State Street Corporation', 'Boston', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'BMO USA', 'Chicago', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'American Express', 'New York City', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'HSBC Bank USA', 'New York City', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'Citizens Financial Group', 'Providence, Rhode Island', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'First Citizens BancShares', 'Raleigh, North Carolina', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);
    INSERT INTO organization ("type", "name", "address", "url", "logo_url", "fav_icon", "county_id") VALUES ('BANK', 'M&T Bank', 'Buffalo, New York', 'http://example.com/logo.png', 'http://example.com/logo.png', 'http://example.com/logo.png', 2);

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

   INSERT INTO "user" ("login", "password") VALUES ('admin@gmail.com', '17a52eb47cfc741a02c0fb8841b0a7794973df3a06a53cf5d9f73b486e06945e');
EOSQL
