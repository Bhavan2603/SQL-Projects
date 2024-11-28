create database sm;
use sm;

create table users(
user_id INT PRIMARY KEY,
username VARCHAR(50),
email VARCHAR(50),
registration_date DATE NOT NULL);
desc users;

INSERT INTO users
VALUES(1, 'aaa', 'aaa@gmail.com', '2000-03-20'),
(2, 'bbb', 'bbb@gmail.com', '2012-09-07'),
(3, 'ccc', 'ccc@gmail.com', '2020-10-28'),
(4, 'ddd', 'ddd@gmail.com', '2004-11-14'),
(5, 'eee', 'eee@gmail.com', '2010-04-19'),
(6, 'fff', 'fff@gmail.com', '2023-07-27');
select * from users;

CREATE TABLE posts(
post_id INT PRIMARY KEY,
user_id INT,
content VARCHAR(50) DEFAULT NULL,
post_date DATE NOT NULL,
likes_count INT NOT NULL,
comments_count INT NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(user_id));
desc posts;

INSERT INTO posts
VALUES(100, 2, 'abcdefgh', '2012-12-20', 100, 10),
(101, 4, 'ijklmno', '2006-04-12', 60, 50),
(102, 5, 'pqrstuvw', '2011-04-06', 220, 102),
(103, 1, 'xyzabcde', '2002-12-20', 50, 2),
(104, 1, 'fghijklmno', '2005-08-20', 500, 100);
select * from posts

CREATE TABLE comments(
comment_id INT PRIMARY KEY,
user_id INT,
post_id INT,
comment_text VARCHAR(30),
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (post_id) REFERENCES posts(post_id));
desc comments;

INSERT INTO comments
VALUES(10, 1, 100, 'self love'),
(11, 6, 102, 'love yourself'),
(12, 3, 104, 'mic drop'),
(13, 2, 100, 'boy with love'),
(14, 2, 103, 'fake love'),
(15, 5, 102, 'black swan'),
(16, 4, 102, 'butter'),
(17, 1, 103, 'permission to dance'),
(18, 6, 101, 'dynamite');
desc comments;

CREATE TABLE likes(
like_id INT PRIMARY KEY,
user_id INT,
post_id INT,
like_date DATE NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(user_id),
FOREIGN KEY (post_id) REFERENCES posts(post_id));
desc likes;

INSERT INTO likes
VALUES(1001, 2, 104, '2014-04-23'),
(1002, 3, 103, '1010-12-12'),
(1003, 6, 101, '2023-08-17'),
(1004, 4, 102, '2006-04-06'),
(1005, 4, 102, '2008-10-09'),
(1006, 1, 104, '2003-05-22'),
(1007, 5, 101, '2011-03-10'),
(1008, 4, 102, '2014-04-23');
select * from likes;


/*Reteieve users posts*/
select username, content
from users
left join posts
on users.user_id = posts.user_id 

/*Find 5 most liked posts*/
select content, likes_count
from posts
group by content, likes_count
order by likes_count desc
limit 5

/*Retrieve posts comments*/
select content, comment_text
from posts
left join comments 
on posts.post_id = comments.post_id

/*Count total engagements for a post*/
select post_id, content, likes_count + comments_count as 'total engagements'
from posts
where post_id = 100

/*Find active users based on post frequency*/
select username, count(content) 
from users
left join posts
on users.user_id = posts.user_id
group by username
order by count(content) desc

/*Calculate average likes per post for a user*/
select username, avg(likes_count)
from users
left join posts
on users.user_id = posts.user_id
where username = 'aaa'
group by username

/*Get posts along with their comments*/
select content, comment_text
from posts
left join comments
on posts.post_id = comments.post_id

/*Find users who liked their own post*/
select user_id, likes_count
from posts
where post_id = 100

/*Determine users who haven't posted anything*/
select username, post_id, content
from users
left join posts
on users.user_id = posts.user_id
where content is null

/*Calculate total number of users, posts, likes and comments*/
select count(username), count(content), sum(likes_count), sum(comments_count)
from users
left join posts 
on users.user_id = posts.user_id

select count(distinct username)from users
select count(*)content from posts
select sum(likes_count) from posts
select count(*)comments_count from posts

/*Determine the post that received no likes*/
select content, likes_count
from posts
where likes_count is null

/*Identify users who haven't liked or commented on any post*/
select user_id, content, likes_count, comments_count
from posts
