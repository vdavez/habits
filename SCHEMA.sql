CREATE TABLE IF NOT EXISTS weight (
  date    DATE DEFAULT CURRENT_DATE UNIQUE,
  weight  DECIMAL (5,2),
  notes   TEXT
);

CREATE TABLE IF NOT EXISTS medicine (
  date      DATE DEFAULT CURRENT_DATE UNIQUE,
  taken     TEXT DEFAULT "Y",
  notes     TEXT
);

CREATE VIEW IF NOT EXISTS today AS
  SELECT 
    w.weight AS weight, 
    m.taken AS "medicine_taken"
  FROM weight w
  JOIN medicine m
  ON w.date = m.date
  WHERE w.date = CURRENT_DATE
;