# SQL Commands Introduction

In this workshop we will be learning SQL by running commands in our terminal.

## Getting Started

Make sure you have [installed and setup PostgreSQL](https://github.com/macintoshhelper/learn-sql/blob/master/postgresql/setup.md).

We'll be using `psql`, the Postgres command-line interface. This lets you run SQL queries and also provides some extra commands for working with the databse. These extras start with a backslash character (e.g. `\c`) whereas SQL is usually uppercase (e.g. `CREATE DATABASE`).

**Important**: SQL commands need a semicolon at the end of the line. This is not optional and stuff will break if you forget it.

### Setting up the workshop database

Clone this repo and `cd` into it. Type `psql` in your terminal to enter the Postgres command-line interface. You can type `ctrl-d` to exit this at any time.

To create a database we use the `CREATE DATABASE` command and give it whatever name you like:

```sql
CREATE DATABASE blog_workshop;
```

You should now be able to use the `\list` (or `\l` for short) `psql` command to list all the databases on your machine. Hopefully the new `blog_workshop` is there. You can type `q` to exit this view.

You can then connect to our new database using the `\connect` (or `\c`) command:

```sh
\connect blog_workshop
```

Now you need to populate the database with some data. There's a bunch of pre-written SQL commands in the `init.sql` file. If you run this it will create some fake blog data in our new database.

You can use the `\include` (or `\i`) command to run some SQL from a file (which saves a lot of typing):

```sh
\include init.sql
```

If you run the `\dt` command you should see all the **d**atabase **t**ables we just created (`blog_posts`, `blog_comments` and `users`).

## Schema Info

This database represents the data for a blog. It has users who can write blog posts, and blog posts that can contain comments.

A blog post has to have an author, so each entry in `blog_posts` has a `user_id`, which `REFERENCES` an `id` in the `users` table. This links the two together, so for any given post we can always find the author.

Comments are linked to both a `user` and a `blog_post`, so they have two `REFERENCES`: `post_id` and `user_id`.

### `users`

| Column     | Type                                              | Constraints |
| ---------- | ------------------------------------------------- | ----------- |
| id         | SERIAL (translates to integer and AUTO_INCREMENT) | PRIMARY KEY |
| username   | VARCHAR(255)                                      | NOT NULL    |
| age        | INTEGER                                           |
| first_name | VARCHAR(255)                                      |
| last_name  | VARCHAR(255)                                      |
| location   | VARCHAR(255)                                      |

### `blog_posts`

| Column       | Type    | Constraints          |
| ------------ | ------- | -------------------- |
| id           | SERIAL  | PRIMARY KEY          |
| user_id      | INTEGER | REFERENCES users(id) |
| text_content | TEXT    |

### `post_comments`

| Column       | Type    | Constraints               |
| ------------ | ------- | ------------------------- |
| id           | SERIAL  | PRIMARY KEY               |
| post_id      | INTEGER | REFERENCES blog_posts(id) |
| user_id      | INTEGER | REFERENCES users(id)      |
| text_content | TEXT    |

### Data types

SQL requires us to specify what type of data we're going to use for each entry in advance.

#### `SERIAL`

An auto-incrementing number. Useful for IDs where each new entry needs a unique value.

#### `VARCHAR(255)`

This is a variable-length string. The number in brackets specifies the maximum number of characters.

#### `TEXT`

A string of any length.

#### `INTEGER`

A whole number (like `20`). No fractions allowed.

### Constraints

A way to provide additional fine-tuning of a data type. Think of it like input validation.

#### `NOT NULL`

This value is required and must always be set.

#### `PRIMARY KEY`

Indicates that this value is the unique identifier for this entry into the table (called a "row").

#### `REFERENCES`

Specifies that this value must match one in another table. The value it must match is specified after like this: `other_table_name(primary_key)`.

## SQL Overview

Here's a quick overview of some SQL commands. Don't forget every line must end with a semicolon.

### Retrieving data

#### [`SELECT`](https://www.w3schools.com/sql/sql_select.asp)

Retrieves data from a table. You need to combine it with `FROM` to specify which table. For example:

```sql
SELECT first_name FROM users;
```

would retrieve the `first_name` column for every row in the `users` table.

| first_name |
| ---------- |
| Alisha     |
| Chelsea    |
| ...        |

Note you can provide comma-separated lists of column names and table names if you want to select multiple things. You can also use the `*` character to select all columns.

#### [`WHERE`](https://www.w3schools.com/sql/sql_where.asp)

This is a clause that qualifies a `SELECT`. It lets you filter which rows are retrieved based on the values in that row. For example:

```sql
SELECT first_name FROM users WHERE id = 1;
```

would retrive the first name column for any users with an ID of `1`.

| first_name |
| ---------- |
| Alisha     |

#### [`AND`, `OR` and `NOT`](https://www.w3schools.com/sql/sql_and_or.asp)

These are operators for expressing logic in your `WHERE` clauses. They let you apply multiple conditions. For example:

```sql
SELECT first_name FROM users WHERE id = 1 OR id = 2;
```

would retrieve the first name column for any users with an ID of `1` _or_ `2`.

| first_name |
| ---------- |
| Alisha     |
| Chelsea    |

#### [`LIKE`](https://www.w3schools.com/sql/sql_like.asp)

This operator is used within a `WHERE` clause to specify a pattern the column value must match. There is a special pattern syntax: `%` represents zero or more characters, `_` represents a single character and a literal character (like `'a'`) represents itself. For example:

```sql
select text_content from blog_posts where text_content like 'F%';
```

would select the text content of any blog post where the text content started with the letter "F" and have any other characters afterwards.

| text_content                                                                                                                                       |
| -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Far stairs now coming bed oppose hunted become his. You zealously departure had procuring suspicion. Books whose front would purse if be do decay. |

#### [`IN`](https://www.w3schools.com/sql/sql_in.asp)

This operator lets you match against a list of values in your `WHERE` clause. For example:

```sql
SELECT first_name FROM users WHERE id IN (1, 2);
```

would select the first name column for any users with an ID of `1` or `2`.

| first_name |
| ---------- |
| Alisha     |
| Chelsea    |

This is similar to the `OR` operator we saw above.

#### `CASE`

This expression lets you create a temporary column whose value is determined by some conditional logic (like an if/else in JS). The `CASE` expression goes in the list of column names, and finishes when you type `END`.

```sql
SELECT
  username,
  CASE
    WHEN location = 'Saxilby, UK' THEN 'yeah, they do'
    ELSE 'nah, they do not'
  END
FROM users;
```

would select the username column and show a new temporary column showing whether or not that user lives in Saxilby.

| username  | case             |
| --------- | ---------------- |
| Sery1976  | nah, they do not |
| Notne1991 | nah, they do not |
| Moull1990 | nah, they do not |
| Spont1935 | yeah, they do    |
| Precand   | nah, they do not |
| Ovion1948 | nah, they do not |
| Thresuall | nah, they do not |
| Brity1971 | yeah, they do    |

#### `AS`

This lets you create aliases, which are temporary columns with a specified name. This is useful combined with `CASE`, as we can give the `CASE` column a more descriptive name.

```sql
SELECT
  username,
  CASE
    WHEN location = 'Saxilby, UK' THEN 'yeah, they do'
    ELSE 'nah, they do not'
  END AS lives_in_saxilby
FROM users;
```

| username  | lives_in_saxilby |
| --------- | ---------------- |
| Sery1976  | nah, they do not |
| Notne1991 | nah, they do not |
| Moull1990 | nah, they do not |
| Spont1935 | yeah, they do    |
| Precand   | nah, they do not |
| Ovion1948 | nah, they do not |
| Thresuall | nah, they do not |
| Brity1971 | yeah, they do    |

### Creating and updating data

#### [`INSERT INTO`](https://www.w3schools.com/sql/sql_insert.asp)

Lets you add a new row into a table. You specify a table name and list of columns, then a list of values to insert. The values have to match positions with their respective columns (like function arguments in JS).

```sql
INSERT INTO users (username, first_name) VALUES ('oliverjam', 'oli');
```

would create a new user row with a username of `'oliverjam'` and first name of `'oli'`.

#### [`UPDATE`](https://www.w3schools.com/sql/sql_update.asp)

Lets you change existing data in a table. You provide the table name, then the name and new value of each column. You also need to provide a `WHERE` clause to select which rows to update, otherwise **every** row will be changed.

```sql
UPDATE users SET first_name = 'oliver' WHERE username = 'oliverjam';
```

would update the first name of the user with username `"oliverjam"` to be `"oliver"`.

## Challenges

1. Using [`SELECT`](https://www.w3schools.com/sql/sql_select.asp), retrieve all the information from the `users` table

**Expected Result**

| id  | username  | age | first_name | last_name | location              |
| --- | --------- | --- | ---------- | --------- | --------------------- |
| 1   | Sery1976  | 28  | Alisha     | Clayton   | Middlehill, UK        |
| 2   | Notne1991 | 36  | Chelsea    | Cross     | Sunipol, UK           |
| 3   | Moull1990 | 41  | Skye       | Hobbs     | Wanlip, UK            |
| 4   | Spont1935 | 72  | Matthew    | Griffin   | Saxilby, UK           |
| 5   | Precand   | 19  | Erin       | Gould     | Stanton, UK           |
| 6   | Ovion1948 | 53  | Reece      | Sheppard  | Easton in Gordano, UK |
| 7   | Thresuall | 21  | Daniel     | Grant     | Slackhall, UK         |
| 8   | Brity1971 | 23  | Daniel     | Brennan   | Saxilby, UK           |

2. Using `SELECT`, retrieve a list of _only_ username and location from the `users` table

**Expected Result**

| username  | location              |
| --------- | --------------------- |
| Sery1976  | Middlehill, UK        |
| Notne1991 | Sunipol, UK           |
| Moull1990 | Wanlip, UK            |
| Spont1935 | Saxilby, UK           |
| Precand   | Stanton, UK           |
| Ovion1948 | Easton in Gordano, UK |
| Thresuall | Slackhall, UK         |
| Brity1971 | Saxilby, UK           |

3. Using `SELECT` and [`WHERE`](https://www.w3schools.com/sql/sql_where.asp), retrieve a list of users with _all_ their data who are older than 50

**Expected Result**

| id  | username  | age | first_name | last_name | location              |
| --- | --------- | --- | ---------- | --------- | --------------------- |
| 4   | Spont1935 | 72  | Matthew    | Griffin   | Saxilby, UK           |
| 6   | Ovion1948 | 53  | Reece      | Sheppard  | Easton in Gordano, UK |

4. Using `SELECT` and `WHERE`, retrieve the first, last name and location of the user who lives in `Saxilby, UK` and is older than 40.

**Expected Result**

| first_name | last_name | location    |
| ---------- | --------- | ----------- |
| Matthew    | Griffin   | Saxilby, UK |

5. Using the `WHERE` operator, [`LIKE`](https://www.w3schools.com/sql/sql_like.asp), retrieve a list of user IDs that have posted blog posts that contain the word `departure`.

**Expected Result**

| user_id |
| ------- |
| 2       |
| 3       |

6. Imagine an API request is made for blog posts with the IDs `3 and 6`. Using `WHERE` and [`IN`](https://www.w3schools.com/sql/sql_in.asp), show the blog posts' user id and text content.

**Expected Result**

| user_id | text_content                                                                                                                                                                                                           |
| ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 3       | Far stairs now coming bed oppose hunted become his. You zealously departure had procuring suspicion. Books whose front would purse if be do decay.                                                                     |
| 6       | Etiam in est nec neque dapibus pretium in in lectus. Proin consequat velit quis magna aliquam tristique. Sed ultricies nulla vel feugiat mattis. Aliquam erat volutpat. Aliquam ac vehicula diam, eget ultricies nisi. |

7. You need to find out which of your users are teenagers and which are not. Using [`CASE WHEN`](https://www.postgresql.org/docs/7.4/static/functions-conditional.html) and [`AS`](https://www.w3schools.com/sql/sql_alias.asp), show a list of users by their `id` and a new column called `teenager` with the values `true` or `false`.

**Expected Result**

| id  | teenager |
| --- | -------- |
| 1   | false    |
| 2   | false    |
| 3   | false    |
| 4   | false    |
| 5   | true     |
| 6   | false    |
| 7   | false    |
| 8   | false    |

## Using `INSERT` and `UPDATE`

So, we have retrieved data from the database. The next exercises will cover adding data

8. Using [`INSERT INTO`](https://www.w3schools.com/sql/sql_insert.asp), add a blog post with the text "Hello world" to the user with ID `1`, then run `SELECT text_content FROM blog_posts WHERE user_id=1;` to test for the expected result.

**Expected Result**

| text_content |
| ------------ |
| Hello World  |

9. Using [`UPDATE`](https://www.w3schools.com/sql/sql_update.asp), update the blog post from the previous question to change the author to the user with ID `5`, then run `SELECT user_id FROM blog_posts WHERE text_content='Hello world';` to test for the expected result.

**Expected Result**

| user_id |
| ------- |
| 5       |

<!-- **Bonus Question**

10. Using [`INSERT INTO`](https://www.w3schools.com/sql/sql_insert.asp), add a comment with the text `Interesting post` from the user_id of `3` to the blog post containing the text `Peculiar` (reply_to will be null), then run `SELECT text_content FROM post_comments WHERE post_id = 2;` to test for the expected result.

**Expected Result**

| text_content     |
| ---------------- |
| Interesting post | -->
