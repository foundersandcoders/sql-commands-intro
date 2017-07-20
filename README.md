# SQL Commands Introduction
This workshop will teach you how to use basic SQL - Structured Query Language. SQL is a standard for relational database systems, while MySQL and PostgreSQL are implementations of the standard.

## Getting Started
Make sure you have installed and setup PostgreSQL.

To learn how to use SQL, refer to https://github.com/macintoshhelper/learn-sql/tree/master/postgresql .

If you feel stuck or forget something, all the resources to complete this can be found there.

[PostgreSQL Cheatsheet](https://github.com/macintoshhelper/learn-sql/tree/master/postgresql/cheatsheet.md)

[Skip to hints - please use as a last resort](#hints)

### Setting up the workshop database

1. Clone this workshop and `cd` into it, then run these commands after using `psql`:

  ```sql
  CREATE DATABASE blog_workshop;

  \c blog_workshop
  \i init.sql
  ```

## Schema Diagrams

### Users - `users`

Column | Type | Modifiers
--- | --- | ---
id | serial (translates to integer and AUTO\_INCREMENT) | PRIMARY KEY
username | VARCHAR(255) | NOT NULL
age | INTEGER |
first\_name | VARCHAR(255) |
last\_name | VARCHAR(255) |
location | VARCHAR(255) |




### Blog Posts - `blog_posts`

Column | Type | Modifiers
--- | --- | ---
id | SERIAL | PRIMARY KEY
user_id | INTEGER | REFERENCES users(id)
text_content | TEXT |

### post_comments - `post_comments`

Column | Type | Modifiers
--- | --- | ---
id | SERIAL | PRIMARY KEY
post\_id | INTEGER | REFERENCES blog\_posts(id),
reply\_to | INTEGER | REFERENCES post\_comments(id),
user\_id | INTEGER | REFERENCES users(id)
text\_content | TEXT |

## Challenges

1. Retrieve all the information from the `users` table

**Expected Result**

id | username | age | first\_name | last\_name | location
--- | --- | --- | --- | --- | ---
1 | Sery1976 | 28 | Alisha | Clayton | Middlehill, UK | 
2 | Notne1991 | 36 | Chelsea | Cross | Sunipol, UK | 
3 | Moull1990 | 41 | Skye | Hobbs | Wanlip, UK | 
4 | Spont1935 | 72 | Matthew | Griffin | Saxilby, UK | 
5 | Precand | 19 | Erin | Gould | Stanton, UK | 
6 | Ovion1948 | 53 | Reece | Sheppard | Easton in Gordano, UK | 
7 | Thresuall | 21 | Daniel | Grant | Slackhall, UK | 


2. Retrieve a list of *only* username and location from the `users` table

**Expected Result**

username | location
--- | ---
Sery1976 | Middlehill, UK | 
Notne1991 | Sunipol, UK | 
Moull1990 | Wanlip, UK | 
Spont1935 | Saxilby, UK | 
Precand | Stanton, UK | 
Ovion1948 | Easton in Gordano, UK | 
Thresuall | Slackhall, UK | 


3. Retrieve a list of users who are older than 50

**Expected Result**

id | username | age | first\_name | last\_name | location
--- | --- | --- | --- | --- | ---
4 | Spont1935 | 72 | Matthew | Griffin | Saxilby, UK | 
6 | Ovion1948 | 53 | Reece | Sheppard | Easton in Gordano, UK | 


4. Retrieve the first and last name of the user who lives in `Saxilby, UK` and is older than 40.

**Expected Result**

first\_name | last\_name | location
--- | --- | ---
Matthew | Griffin | Saxilby, UK


## Hints

1. Use `SELECT`
2. Use `SELECT`
3. Use `SELECT` and `WHERE`
