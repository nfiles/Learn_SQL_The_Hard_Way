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


-- Exercise 12: Destroying And Altering Tables
-- http://sql.learncodethehardway.org/book/ex12.html

DROP TABLE IF EXISTS person;
CREATE TABLE person (
    id         INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name  TEXT,
    age        INTEGER
);

ALTER TABLE person RENAME TO peoples;

ALTER TABLE peoples ADD COLUMN hatred INTEGER;
ALTER TABLE peoples ADD COLUMN height NUMBER;
ALTER TABLE peoples ADD COLUMN weight NUMBER;

ALTER TABLE peoples RENAME TO person;

.schema person

-- DROP TABLE person;
