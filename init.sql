BEGIN;

DROP TABLE IF EXISTS users, blog_posts, post_comments CASCADE;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  age INTEGER,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  location VARCHAR(255)
);

CREATE TABLE blog_posts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  text_content TEXT
);

CREATE TABLE post_comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER REFERENCES blog_posts(id),
  reply_to INTEGER REFERENCES post_comments(id),
  user_id INTEGER REFERENCES users(id),
  text_content TEXT
);

INSERT INTO users (username, age, first_name, last_name, location) VALUES
  ('Sery1976', 28, 'Alisha', 'Clayton', 'Middlehill, UK'),
  ('Notne1991', 36, 'Chelsea', 'Cross', 'Sunipol, UK'),
  ('Moull1990', 41, 'Skye', 'Hobbs', 'Wanlip, UK'),
  ('Spont1935', 72, 'Matthew', 'Griffin', 'Saxilby, UK'),
  ('Precand', 19, 'Erin', 'Gould', 'Stanton, UK'),
  ('Ovion1948', 53, 'Reece', 'Sheppard', 'Easton in Gordano, UK'),
  ('Thresuall', 21, 'Daniel', 'Grant', 'Slackhall, UK'),
  ('Brity1971', 23, 'Daniel', 'Brennan', 'Saxilby, UK')
;

INSERT INTO blog_posts (text_content, user_id) VALUES
  (
    'Announcing of invitation principles in. Cold in late or deal. Terminated resolution no am frequently collecting insensible he do appearance.',
    1
  ),
  (
    'Peculiar trifling absolute and wandered vicinity property yet. The and collecting motionless departure difficulty son.',
    2
  ),
  (
    'Far stairs now coming bed oppose hunted become his. You zealously departure had procuring suspicion. Books whose front would purse if be do decay.',
    3
  ),
  (
    'Curabitur arcu quam, imperdiet ac orci ac, mattis tempor nunc. Nunc a lacus sollicitudin, bibendum libero a, consectetur orci. In eget vulputate nisl. Mauris at nunc at massa cursus feugiat.',
    4
  ),
  (
    'Aenean blandit risus sed pellentesque vestibulum. Fusce in ultrices augue. Nunc interdum quis nibh non feugiat.',
    5
  ),
  (
    'Etiam in est nec neque dapibus pretium in in lectus. Proin consequat velit quis magna aliquam tristique. Sed ultricies nulla vel feugiat mattis. Aliquam erat volutpat. Aliquam ac vehicula diam, eget ultricies nisi.',
    6
  ),
  (
    'Proin euismod arcu nec diam dictum, a eleifend sem placerat. Quisque ultrices fermentum mi, fermentum molestie mauris tincidunt sit amet.',
    7
  )
;

INSERT INTO post_comments (post_id, reply_to, user_id, text_content) VALUES
  (
    4,
    NULL,
    2,
    'Great blog post! Really nice. Would be good to have an English version though :)'
  )
;

COMMIT;
