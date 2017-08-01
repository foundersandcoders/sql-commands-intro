# SQL Commands Introduction
In this workshop, we will be using basic SQL in a CLI to work with an existing blog database.


## Getting Started
Make sure you have installed and setup PostgreSQL: [installation instructions](https://github.com/macintoshhelper/learn-sql/blob/master/postgresql/setup.md)

### Setting up the workshop database

Clone this workshop and `cd` into it, then run these commands after using `psql`:

```sql
CREATE DATABASE blog_workshop;
```

`\c blog_workshop`  - connect to the database

`\i init.sql` - run SQL build file in blog_workshop (You can also do `psql --file init.sql` in bash)


## Schema Info
You are given the task of creating a blog. A simple blog would have users who can write blog posts, and blog posts that can contain comments and replies.

Users has no direct relationships to other tables, but a blog post has to have an author, so `blog_posts` has a `user_id` `FOREIGN KEY` of `users(id)`. 

Comments have to be attached to a blog post, so `post_id` has a `post_id` `FOREIGN KEY` of `blog_posts(id)`.

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

1. Using [`SELECT`](https://www.w3schools.com/sql/sql_select.asp), retrieve all the information from the `users` table

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
8 | Brity1971 | 23 | Daniel | Brennan | Saxilby, UK


2. Using `SELECT`, retrieve a list of *only* username and location from the `users` table

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
Brity1971 | Saxilby, UK


3. Using `SELECT` and [`WHERE`](https://www.w3schools.com/sql/sql_where.asp), retrieve a list of users with *all* their data who are older than 50

**Expected Result**

id | username | age | first\_name | last\_name | location
--- | --- | --- | --- | --- | ---
4 | Spont1935 | 72 | Matthew | Griffin | Saxilby, UK | 
6 | Ovion1948 | 53 | Reece | Sheppard | Easton in Gordano, UK | 


4. Using `SELECT` and `WHERE`, retrieve the first, last name and location of the user who lives in `Saxilby, UK` and is older than 40.

**Expected Result**

first\_name | last\_name | location
--- | --- | ---
Matthew | Griffin | Saxilby, UK


5. Using the `WHERE` operator, [`LIKE`](https://www.w3schools.com/sql/sql_like.asp), retrieve a list of user IDs that have posted blog posts that contain the word `departure`.

**Expected Result**

user\_id |
--- |
2 |
3 |

6. Imagine an API request is made for blog posts with the IDs `3 and 6`. Using `WHERE` and [`IN`](https://www.w3schools.com/sql/sql_in.asp), show the blog posts' user id and text content.

**Expected Result**

user\_id | text\_content
--- | ---
3 | Far stairs now coming bed oppose hunted become his. You zealously departure had procuring suspicion. Books whose front would purse if be do decay.
6 | Etiam in est nec neque dapibus pretium in in lectus. Proin consequat velit quis magna aliquam tristique. Sed ultricies nulla vel feugiat mattis. Aliquam erat volutpat. Aliquam ac vehicula diam, eget ultricies nisi.

7. You need to find out which of your users are teenagers and which are not. Using [`CASE WHEN`](https://www.postgresql.org/docs/7.4/static/functions-conditional.html) and [`AS`](https://www.w3schools.com/sql/sql_alias.asp), show a list of users by their `id` and a new column called `teenager` with the values `true` or `false`. 


**Expected Result**

id | teenager
--- | ---
1 | false
2 | false
3 | false
4 | false
5 | true
6 | false
7 | false
8 | false


## Using `INSERT` and `UPDATE`
So, we have retrieved data from the database. The next exercises will cover adding data

8. Using [`INSERT INTO`](https://www.w3schools.com/sql/sql_insert.asp), add a blog post with the text "Hello world" to the user with ID `1`, then run `SELECT text_content FROM blog_posts WHERE user_id=1;` to test for the expected result.

**Expected Result**

text\_content |
--- |
Hello World |

9. Using [`UPDATE`](https://www.w3schools.com/sql/sql_update.asp), update the blog post from the previous question to change the author to the user with ID `5`, then run `SELECT user_id FROM blog_posts WHERE text_content='Hello world';` to test for the expected result.

**Expected Result**

user\_id |
--- |
5 |

**Bonus Question**

10. Using [`INSERT INTO`](https://www.w3schools.com/sql/sql_insert.asp), add a comment with the text `Interesting post` from the user\_id of `3` to the blog post containing the text `Peculiar` (reply\_to will be null), then run `SELECT text_content FROM post_comments WHERE post_id = 2;` to test for the expected result.

**Expected Result**

text\_content |
--- |
Interesting post |
