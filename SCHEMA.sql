-- Autogenerated SCHEMA.sql

CREATE TABLE IF NOT EXISTS habits (
    date    DATE DEFAULT ( date('now','locatime') ) UNIQUE,
    weight DECIMAL (5,2) DEFAULT '',
    medicine TEXT DEFAULT 'Y',
    exercise TEXT DEFAULT 'N',
    water INT DEFAULT '0',
    notes TEXT
);
