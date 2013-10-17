-- Exercise 2: Creating a Multi-Table Database
-- http://sql.learncodethehardway.org/book/ex2.html

CREATE TABLE person (
	id         INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name  TEXT,
	age        INTEGER
);

CREATE TABLE pet (
	id          INTEGER PRIMARY KEY,
	name        TEXT,
	breed       TEXT,
	age         INTEGER,
	dead        INTEGER,
	disposition TEXT
);

CREATE TABLE person_pet (
	person_id INTEGER,
	pet_id    INTEGER
);
