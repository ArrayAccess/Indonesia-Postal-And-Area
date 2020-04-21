-- -----------------------------------------
-- SQLITE DATABASE STRUCTURES
-- -----------------------------------------
--
-- column `xxxx_postal_codes` comma
-- separated values
-- references of `postal_codes`
-- RUN COMMAND 'vacuum' after delete data
-- to cleanup garbage data
-- -----------------------------------------

-- -----------------------------------------
-- `postal_codes`
-- -----------------------------------------
CREATE TABLE postal_codes
(
    postal_code VARCHAR(10) NOT NULL,
    postal_name VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (postal_code)
);
-- DROP INDEX
DROP INDEX IF EXISTS index_postal_codes;
DROP INDEX IF EXISTS index_postal_codes_postal_name;
-- ADD INDEX
CREATE UNIQUE INDEX index_postal_codes ON postal_codes (postal_code);
CREATE INDEX index_postal_codes_postal_name ON postal_codes (postal_name);
-- END
-- -----------------------------------------

-- -----------------------------------------
-- `countries`
-- -----------------------------------------
CREATE TABLE countries
(
    country_code      INTEGER(2)   NOT NULL,
    country_name      VARCHAR(255) NOT NULL,
    country_geometry  TEXT        DEFAULT NULL,
    country_latitude  VARCHAR(40) DEFAULT NULL,
    country_longitude VARCHAR(40) DEFAULT NULL,
    PRIMARY KEY (country_code)
);
-- DROP INDEX
DROP INDEX IF EXISTS unique_index_countries_country_codes;
DROP INDEX IF EXISTS index_countries_country_name;
DROP INDEX IF EXISTS index_countries_position;
-- ADD INDEX
CREATE UNIQUE INDEX unique_index_countries_country_codes ON countries (country_code);
CREATE INDEX index_countries_country_name ON countries (country_name);
CREATE INDEX index_countries_position ON countries (country_latitude, country_longitude);
-- END
-- -----------------------------------------

-- -----------------------------------------
-- `provinces`
-- -----------------------------------------
CREATE TABLE provinces
(
    province_code         INTEGER(2) NOT NULL,
    province_name         VARCHAR(255),
    province_postal_codes TEXT,
    province_country_code INTEGER(2),
    province_geometry     TEXT        DEFAULT NULL,
    province_latitude     VARCHAR(40) DEFAULT NULL,
    province_longitude    VARCHAR(40) DEFAULT NULL,
    PRIMARY KEY (province_code),
    FOREIGN KEY (province_country_code) REFERENCES countries (country_code)
);
-- DROP INDEX
DROP INDEX IF EXISTS unique_index_provinces_province_code;
DROP INDEX IF EXISTS index_provinces_province_name;
DROP INDEX IF EXISTS index_provinces_province_postal_codes;
DROP INDEX IF EXISTS index_provinces_position;
-- ADD INDEX
CREATE UNIQUE INDEX unique_index_provinces_province_code ON provinces (province_code);
CREATE INDEX index_provinces_province_name ON provinces (province_name);
CREATE INDEX index_provinces_province_postal_codes ON provinces (province_postal_codes);
CREATE INDEX index_provinces_position ON provinces (province_latitude, province_longitude);
-- END
-- -----------------------------------------

-- -----------------------------------------
-- `cities`
-- -----------------------------------------
CREATE TABLE cities
(
    city_code          INTEGER(4) NOT NULL,
    city_name          VARCHAR(255),
    city_postal_codes  TEXT,
    city_province_code INTEGER(2),
    city_geometry      TEXT        DEFAULT NULL,
    city_latitude      VARCHAR(40) DEFAULT NULL,
    city_longitude     VARCHAR(40) DEFAULT NULL,
    PRIMARY KEY (city_code),
    FOREIGN KEY (city_province_code) REFERENCES provinces (province_code)
);
-- DROP INDEX
DROP INDEX IF EXISTS unique_index_cities_city_code;
DROP INDEX IF EXISTS index_cities_city_name;
DROP INDEX IF EXISTS index_cities_city_postal_codes;
DROP INDEX IF EXISTS index_cities_position;
-- ADD INDEX
CREATE UNIQUE INDEX unique_index_cities_city_code ON cities (city_code);
CREATE INDEX index_cities_city_name ON cities (city_name);
CREATE INDEX index_cities_city_postal_codes ON cities (city_postal_codes);
CREATE INDEX index_cities_position ON cities (city_latitude, city_longitude);
-- END
-- -----------------------------------------

-- -----------------------------------------
-- `sub_districts`
-- -----------------------------------------
CREATE TABLE sub_districts
(
    sub_district_code         INTEGER(7) NOT NULL,
    sub_district_name         VARCHAR(255),
    sub_district_postal_codes TEXT,
    sub_district_city_code    INTEGER(4),
    sub_district_geometry     TEXT        DEFAULT NULL,
    sub_district_latitude     VARCHAR(40) DEFAULT NULL,
    sub_district_longitude    VARCHAR(40) DEFAULT NULL,
    PRIMARY KEY (sub_district_code),
    FOREIGN KEY (sub_district_city_code) REFERENCES cities (city_code)
);
-- DROP INDEX
DROP INDEX IF EXISTS unique_index_sub_districts;
DROP INDEX IF EXISTS index_sub_districts_sub_district_name;
DROP INDEX IF EXISTS index_sub_districts_sub_district_postal_codes;
DROP INDEX IF EXISTS index_sub_districts_position;
-- ADD INDEX
CREATE UNIQUE INDEX unique_index_sub_districts ON sub_districts (sub_district_code);
CREATE INDEX index_sub_districts_sub_district_name ON sub_districts (sub_district_name);
CREATE INDEX index_sub_districts_sub_district_postal_codes ON sub_districts (sub_district_postal_codes);
CREATE INDEX index_sub_districts_position ON sub_districts (sub_district_latitude, sub_district_longitude);
-- END
-- -----------------------------------------

-- -----------------------------------------
-- `villages`
-- -----------------------------------------
CREATE TABLE villages
(
    village_code         INTEGER(11) NOT NULL,
    village_name         VARCHAR(255),
    village_postal_codes TEXT,
    village_sub_district_code    INTEGER(7),
    village_geometry     TEXT        DEFAULT NULL,
    village_latitude     VARCHAR(40) DEFAULT NULL,
    village_longitude    VARCHAR(40) DEFAULT NULL,
    PRIMARY KEY (village_code),
    FOREIGN KEY (village_sub_district_code) REFERENCES sub_districts (sub_district_city_code)
);

-- DROP INDEX
DROP INDEX IF EXISTS unique_index_villages;
DROP INDEX IF EXISTS index_villages_village_name;
DROP INDEX IF EXISTS index_villages_village_postal_codes;
DROP INDEX IF EXISTS index_villages_position;
-- ADD INDEX
CREATE UNIQUE INDEX unique_index_villages ON villages (village_code);
CREATE INDEX index_villages_village_name ON villages (village_name);
CREATE INDEX index_villages_village_postal_codes ON villages (village_postal_codes);
CREATE INDEX index_villages_position ON villages (village_latitude, village_longitude);
-- END
-- -----------------------------------------

-- -----------------------------------------
-- `translations`
-- -----------------------------------------
CREATE TABLE translations
(
    translation_id    INTEGER PRIMARY KEY AUTOINCREMENT,
    translation_code  VARCHAR(2) NOT NULL,
    translation_name  TEXT       NOT NULL,
    translation_value TEXT,
    UNIQUE (`translation_name`, `translation_code`)
);
-- DROP INDEX
DROP INDEX IF EXISTS index_translations_translation_code;
DROP INDEX IF EXISTS index_translations_translation_name;
-- ADD INDEX
CREATE INDEX `index_translations_translation_code` ON translations (translation_code);
CREATE INDEX `index_translations_translation_name` ON translations (translation_name);
-- END
-- -----------------------------------------
