-- Exercise 2: Creating a Multi-Table Database
-- http://sql.learncodethehardway.org/book/ex3.html

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


-- Exercise 3: Inserting Data
-- http://sql.learncodethehardway.org/book/ex3.html

INSERT INTO person (id, first_name, last_name, age)
	VALUES (0, "Priscilla", "Files", 22);

INSERT INTO pet (id, name, breed, age, dead, disposition)
	VALUES (0, "Beans", "rabbit", 4, 0, "Hungry, but social");

INSERT INTO pet (id, name, breed, age, dead, disposition)
	VALUES (1, "Foofs", "rabbit", 10, 1, "Cute. Puts up with Josiah. :)");


-- Exercise 4: Insert Referential Data
-- http://sql.learncodethehardway.org/book/ex4.html

INSERT INTO person_pet (person_id, pet_id)
	VALUES (0, 0);

INSERT INTO person_pet (person_id, pet_id)
	VALUES (0, 1);


-- Exercise 8: Deleting Using Other Tables
-- http://sql.learncodethehardway.org/book/ex8.html

DELETE FROM pet WHERE id IN (
	SELECT pet.id
	FROM pet, person_pet, person
	WHERE
		person.id = person_pet.person_id AND
		person_pet.pet_id = pet.id AND
		person.first_name = "Priscilla"
);

SELECT * FROM pet;
SELECT * FROM person_pet;

DELETE FROM person_pet
	WHERE pet_id NOT IN (
		SELECT id from pet
	);

SELECT * FROM person_pet;
