use sakila;

drop table if exists films_2020;

CREATE TABLE `films_2020` (
  `film_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year(4) DEFAULT NULL,
  `language_id` tinyint(3) unsigned NOT NULL,
  `original_language_id` tinyint(3) unsigned DEFAULT NULL,
  `rental_duration` int(6),
  `rental_rate` decimal(4,2),
  `length` smallint(5) unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

show variables like 'local_infile';
set global local_infile = 1;
set global local_infile = true;

load data local infile 'C:/Users/urgpa/OneDrive/Escritorio/Documentos/RELHACKERS/LEWORK/DAY1_4/labs/dataV3_Lesson_2.7_lab/films_2020.csv'
into table films_2020
fields terminated by ',';

select * from films_2020;
SET SQL_SAFE_UPDATES = 0;

update sakila.films_2020 set rental_duration = 3;
update sakila.films_2020 set rental_rate = 2.99;
update sakila.films_2020 set replacement_cost = 8.99;

-- 1
select last_name,count(last_name) from actor
group by last_name
having count(last_name) = 1;

-- 2
select last_name,count(last_name) from actor
group by last_name
having count(last_name) > 1;

-- 3

select staff_id, count(staff_id) as rental_staff from rental
group by staff_id;

-- 4 Using the film table, find out how many films were released each year.
select release_year, count(title) from film
group by release_year;

-- 5
select rating, count(title) from film
group by rating;

-- 6
select rating, round(avg(length), 2), count(title) from film
group by rating
order by rating desc;

-- 7
select rating, avg(length) from film
group by rating
having avg(length) > 120
order by rating desc;