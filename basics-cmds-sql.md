# Useful commands for database manipulation

## Our table 'users_user'

password | last_login | is_superuser | username | first_name | last_name | is_staff | is_active |
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
date_joined | id | email | avatar | wins | losses | draws | games_played |
tfa | is_online | last_seen | idiom | otp | otp_expiration | intra42_id | intra42_url |         

## Using PostgreSQL from the Command Line
- Access the container:  
  `$ docker exec -it postgres /bin/bash` or `make sh-postgres`
- Access PostgreSQL:  
  `$ psql -U pguser -d pgdb`
- List the databases:  
  `\l`
- List the tables:  
  `\dt`
- Exit PostgreSQL:  
  `\q`
- Create a database:  
  `CREATE DATABASE <database_name>;`
- Connect to a database:  
  `\c <database_name>;`

[↑ Index ↑](#index)

---

## Of the four SQL sublanguages ​​we will use two: DDL and DML.
*SQL is generally divided into four main sublanguages:*

1. **DDL (Data Definition Language):**  
   Responsible for defining or modifying the database structures such as creating, altering, or dropping tables and other objects (e.g.: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`).

2. **DML (Data Manipulation Language):**  
   Used to manipulate the actual data, allowing the insertion, updating, deletion, and querying of records (e.g.: `INSERT`, `UPDATE`, `DELETE`, `SELECT`).  
   **DQL (Data Query Language):**  
   A subset of DML that refers only to data querying through the `SELECT` command.


## DDL and DML Commands

- `SELECT` - Query records from one or more tables.
```sql
-- Selecting all columns from the "users_user" table.
SELECT * FROM users_user;
```
```sql
-- List specific fields from "users_user".
SELECT intra42_id, username, email FROM users_user;
```
```sql
-- Queries using a WHERE filter.
SELECT intra42_id, username, email FROM users_user WHERE intra42_id > 0;
```
- `UPDATE` - Updates records in a table.
```sql
-- Update the username of a users_user.
UPDATE users_user
SET username = 'faleite'
WHERE intra42_id = 146558;
```
```sql
-- Increase the games_played of all users_user.
UPDATE users_user
SET games_played = games_played + 1;
```
```sql
-- Increase the games_played of a specific users_user.
UPDATE users_user
SET games_played = games_played + 1;
WHERE intra42_id = 146558;
```
- `DELETE FROM` - Remove records from a table.
```sql
-- Delete a users_user by its intra42_id.
DELETE FROM users_user
WHERE intra42_id = 146558;
```

### Advanced Data Queries

```sql
-- Show users_user whose username contains "min".
SELECT intra42_id, username, email
FROM users_user
WHERE username LIKE '%min%';
```
```sql
-- Show users_user ordered by stock in ascending order.
SELECT *
FROM users_user
ORDER BY intra42_id ASC;
```
```sql
-- Show users_user ordered by stock in descending order, limiting to 2 records.
SELECT *
FROM users_user
ORDER BY intra42_id DESC
LIMIT 2;
```

### Other Commands

- `CREATE DATABASE` - Creates a new database.
```sql
CREATE TABLE wins (
	id SERIAL PRIMARY KEY,             -- Primary key; SERIAL auto-increments
	name VARCHAR(100) NOT NULL UNIQUE,  -- Name with unique constraint
); -- Semicolon to end the query
```
- `INSERT INTO` - Inserts records into a table.
```sql
-- Inserting a new record into the "wins" table.
INSERT INTO wins (name) VALUES ('faaraujo');
```
```sql
-- Inserting a product without specifying the field list.
-- (Note: In PostgreSQL, it is generally recommended not to supply values for serial columns.)
INSERT INTO wins
VALUES (2, 'faleite');
```
- `TRUNCATE TABLE` - Remove all records from a table.
```sql
-- Truncating the "wins" table.
TRUNCATE TABLE users_user;
```
- `DROP TABLE` - Remove a table.
```sql
-- Dropping the "wins" table.
DROP TABLE IF EXISTS wins;
-- or
DROP TABLE wins;
```

[read more](https://github.com/faleite/sql)

[↑ Index ↑](#index)