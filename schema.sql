show databases;
select database();
create database insta;
use insta;
show tables;

CREATE TABLE users
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	image_url VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id) 
);

CREATE TABLE comments
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	comment_text VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id)
);

CREATE TABLE likes
(
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE tags
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	tag_name VARCHAR(255) UNIQUE,
	created_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE photo_tags
(
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
	FOREIGN KEY(photo_id) REFERENCES photos(id),
	FOREIGN KEY(tag_id) REFERENCES tags(id),
	PRIMARY KEY(photo_id, tag_id)
);

CREATE TABLE follows
(
	follower_id INT NOT NULL,
	followee_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY(follower_id) REFERENCES users(id),
	FOREIGN KEY(followee_id) REFERENCES users(id),
	PRIMARY KEY(follower_id, followee_id)
);


select * from users
order by created_at
limit 5;

select 
username,
count(*) as count,
dayname(created_at) as days
from users
group by days
order by count;


select * from users;

select username, image_url from users
left join photos
on users.id = photos.user_id
where photos.image_url is null;


select *, count(user_id) from likes
group by user_id;

select * from photos;
select * from likes;

select
	photos.id,
    photos.image_url,
    likes.user_id,
    username,
    count(*) as total
from photos
inner join likes
	  on likes.photo_id = photos.id
inner join users
		on photos.user_id = users.id
group by photos.id
order by total desc
limit 1;

select * from photos;


select *, count(*)
from users
inner join photos
	on users.id = photos.user_id
group by users.id;

select *, count(*) as count_tags
from photo_tags
join tags
on photo_tags.tag_id = tags.id
group by tags.id
order by count_tags desc
limit 5;
