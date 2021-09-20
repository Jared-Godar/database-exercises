-- Use the albums database
USE albums_db;

-- Explore the structure
SHOW TABLES;
DESCRIBE albums;

-- 3a. How many rows in the table = 31
SELECT * FROM albums;

-- 3b. How many unique artist names? 23 (including "Various")
SELECT DISTINCT artist
FROM albums;

-- 3c. Primary Key for albums table? id
SHOW CREATE TABLE albums;

-- 3d Oldest & Newest? 1967, 2011
SELECT * FROM albums
ORDER BY release_date ASC;

-- 4a Name of all albums by Pink Floyd- The Dark Side of the Moon, The Wall
SELECT DISTINCT name
FROM albums
WHERE artist = 'Pink Floyd';

-- 4b The year Sgt. Pepper - 1967
SELECT * from albums
WHERE name LIKE "%Sgt. Pepper%";

-- 4c. Genre for nevermind - Grunge, Alternative rock
SELECT genre FROM albums
WHERE name ="Nevermind";

-- 4d. WHich albums were released in the 1990s?
SELECT name
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

-- 4e. WHich albums had less than 20 million certified sales?
SELECT name, sales
FROM albums
WHERE sales < 20;

-- 4f. Find all rock. Hard / prog
SELECT *
FROM albums
WHERE genre = 'Rock';

SELECT *
FROM albums
WHERE genre LIKE '%Rock%';
