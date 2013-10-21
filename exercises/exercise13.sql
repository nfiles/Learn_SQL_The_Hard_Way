-- Exercise 2: Creating a Multi-Table Database
-- http://sql.learncodethehardway.org/book/ex3.html

DROP TABLE IF EXISTS person;
CREATE TABLE person (
    id         INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name  TEXT,
    age        INTEGER
);

DROP TABLE IF EXISTS pet;
CREATE TABLE pet (
    id          INTEGER PRIMARY KEY,
    name        TEXT,
    breed       TEXT,
    age         INTEGER,
    dead        INTEGER,
    disposition TEXT
);

DROP TABLE IF EXISTS person_pet;
CREATE TABLE person_pet (
    person_id INTEGER,
    pet_id    INTEGER
);


-- Exercise 3: Inserting Data
-- http://sql.learncodethehardway.org/book/ex3.html

INSERT INTO person (id, first_name, last_name, age)
    VALUES
        (0, "Priscilla", "Files", 18),
        (1, "Nathan", "Files", 22);

INSERT INTO pet (id, name, breed, age, dead, disposition)
    VALUES
        (0, "Beans", "rabbit", 4, 0, "Hungry, but social"),
        (1, "Foofs", "rabbit", 10, 1, "Cute. Puts up with Josiah. :)"),
        (2, "Kronk", "hoo-man", 27, 0, "<strong>Strong, but dumb...</strong>");


-- Exercise 4: Insert Referential Data
-- http://sql.learncodethehardway.org/book/ex4.html

INSERT INTO person_pet (person_id, pet_id)
    VALUES
        (0, 0),
        (0, 1),
        (1, 2);


-- Exercise 13: Migrating and Evolving Data
-- http://sql.learncodethehardway.org/book/ex13.html

-- add columns to tables
ALTER TABLE person ADD COLUMN
    dead INTEGER;

ALTER TABLE person ADD COLUMN
    phone_number NUMBER;

ALTER TABLE person ADD COLUMN
    salary FLOAT;

ALTER TABLE person ADD COLUMN
    dob DATETIME;

ALTER TABLE pet ADD COLUMN
    dob DATETIME;

ALTER TABLE pet ADD COLUMN
    parent INTEGER;

ALTER TABLE person_pet ADD COLUMN
    purchased_on DATETIME;

--------------------------------------------------------
-- update new columns in tables
-- person
UPDATE OR REPLACE person
    SET
        dead = 0,
        phone_number = 12223334444,
        salary = 10024.32,
        dob = datetime('1990-04-06 04:00:05')
    WHERE
        id = 0;

UPDATE OR REPLACE person
    SET
        dead = 0,
        phone_number = 23334445555,
        salary = 1024.32,
        dob = datetime('1980-05-07 13:40:01')
    WHERE
        id = 1;

UPDATE OR REPLACE person
    SET
        dead = 0,
        phone_number = 12223334444,
        salary = 10024.32
    WHERE
        id = 0;

SELECT * FROM person;

-- pet
UPDATE OR REPLACE pet
    SET
        dob = datetime('2005-04-25 15:07:33'),
        parent = NULL
    WHERE
        id = 0;

UPDATE OR REPLACE pet
    SET
        dob = datetime('2001-05-15 13:37:22'),
        parent = NULL
    WHERE
        id = 1;

UPDATE OR REPLACE pet
    SET
        dob = datetime('1500-11-24 21:53:24'),
        parent = NULL
    WHERE
        id = 2;

SELECT * FROM pet;

-- person_pet
UPDATE OR REPLACE person_pet
    SET
        purchased_on = datetime('2010-11-30 18:33:24')
    WHERE
        person_id = 0 AND
        pet_id = 0;

UPDATE OR REPLACE person_pet
    SET
        purchased_on = '2008-06-30 18:33:24'
    WHERE
        person_id = 0 AND
        pet_id = 1;

UPDATE OR REPLACE person_pet
    SET
        purchased_on = datetime('1525-11-30 18:33:24')
    WHERE
        person_id = 1 AND
        pet_id = 2;

SELECT * FROM person_pet;

--------------------------------------------------------
-- add new tuples in tables

-- person
INSERT OR REPLACE INTO person (id, first_name, last_name, age, dead, phone_number, salary, dob)
    VALUES
        (2, 'Jimmy', 'John', 30, 0, 34445556666, 3451.25, '1983-01-01 00:00:00'),
        (3, 'Five', 'Guys', 27, 0, 45556667777, 123556.34, '1986-01-01 00:00:00'),
        (4, 'Chick', 'Fil-A', 46, 0, 56667778888, 877583.56, '1967-01-01 00:00:00'),
        (5, 'Sub', 'way', 48, 0, 67778889999, 55136.35, '1965-08-28 00:00:00');
SELECT * FROM person;

-- pet
INSERT OR REPLACE INTO pet (id, name, breed, age, dead, disposition, dob, parent)
    VALUES
        (3, 'jimmy sub',            'sub',      25, 0, 'Fast service. Not as good as DiBellas.',    '1988-01-01 00:00:00',  0),
        (4, 'little cheeseburger',  'burger',   27, 0, 'Delicious burger with natural ingredients', '1986-01-01 00:00:00',  1),
        (5, 'original chicken',     'sandwich', 46, 0, 'Chicken sandwich made fast and yummy',      '1967-01-01 00:00:00',  1),
        (6, 'spicy chicken deluxe', 'sandwich', 33, 0, 'Spicy chicken sandwich with cheese',        '1980-01-01 00:00:00',  5),
        (7, 'subway sub',           'sub',      48, 0, 'Cheap-ish sub that is pretty okay',         '1965-01-01 00:00:00',  0);
SELECT * FROM pet;

-- person_pet
INSERT OR REPLACE INTO person_pet (person_id, pet_id, purchased_on)
    VALUES
        (2, 3, '1983-02-01 00:00:00'),
        (3, 4, '1986-02-01 00:00:00'),
        (4, 5, '1967-02-01 00:00:00'),
        (4, 6, '1975-02-01 00:00:00'),
        (5, 7, '1967-02-01 00:00:00');
SELECT * FROM person_pet;

--------------------------------------------------------
-- Write a query that can find all the names of pets and their owners bought after 2004.
-- Key to this is to map the person_pet based on the purchased_on column to the pet and parent.

SELECT first_name AS [First], last_name AS [Last], name AS [Pet], purchased_on AS [Purchased]
FROM person
JOIN (
    SELECT *
    FROM pet
    JOIN person_pet
    ON pet.id = person_pet.pet_id
)
ON person.id = person_id
WHERE purchased_on > date('2004-01-01');

--------------------------------------------------------
-- Write a query that can find the pets that are children of a given pet.
-- Again look at the pet.parent to do this. It's actually easy so don't over think it.

SELECT *
FROM pet
WHERE parent IN (
    SELECT id
    FROM pet
    WHERE name = "Foofs");
