create database if not exists learnercoursedb;
use learnercoursedb;


create table learners(
learner_id int primary key auto_increment,
full_name varchar(50) unique,
country varchar(50)
);


create table courses(
course_id int primary key,
course_name varchar(150),
category varchar(150),
unit_price decimal(10,2)
);

create table purchaes(
purchase_id int auto_increment primary key,
learner_id int,
course_id int,
quantity decimal(10,2),
purchase_date date,
foreign key (learner_id) references learners(learner_id),
foreign key (course_id) references courses(course_id)
);

rename table purchaes to purchases;
INSERT INTO learners (full_name,country)
VALUES
('Vinitha', 'India'),
('Mikul', 'Dubai'),
('Dinesh', 'Saudi'),
('Sudhan', 'UK'),
('Surya', 'England');

INSERT INTO courses (course_name,category,unit_price)
VALUES
('Data Analyst', 'Programming', 1500.00),
('Java', 'Programming', 2000.00),
('Python', 'Programming', 2500.00),
('Data Science', 'Data', 3000.00),
('Digital Marketing', 'Marketing', 3500.00);

INSERT INTO purchases
(course_id,learner_id,quantity,purchase_date)
VALUES
(1,1,2,'2026-01-10'),
(3,2,1,'2026-02-12'),
(2,3,1,'2026-02-20'),
(4,4,2,'2026-03-15'),
(1,5,1,'2026-03-10'),
(2,1,1,'2026-04-10'),
(3,2,2,'2026-05-05');

SELECT c.course_id,
       c.course_name,
       COUNT(p.quantity) AS total_quantity
FROM courses AS c
LEFT JOIN purchases AS p
ON p.course_id = c.course_id
GROUP BY c.course_id,c.course_name
ORDER BY total_quantity DESC
LIMIT 3;

SELECT c.category,
       SUM(p.quantity*c.unit_price) AS total_revenue,
       COUNT(DISTINCT p.learner_id) AS unique_learners
FROM purchases AS p
JOIN courses AS c
ON p.course_id=c.course_id
GROUP BY c.category;

SELECT l.learner_id,
       l.full_name,
       COUNT(DISTINCT c.category) AS category_purchased
FROM learners AS l
JOIN purchases AS p
ON l.learner_id=p.learner_id
JOIN courses AS c
ON c.course_id=p.course_id
GROUP BY l.learner_id,l.full_name
HAVING category_purchased > 1;

SELECT c.course_name,
       l.full_name,
       c.unit_price,
       p.quantity
FROM purchases AS p
INNER JOIN courses AS c
ON c.course_id=p.course_id
INNER JOIN learners AS l
ON l.learner_id=p.learner_id;

SELECT c.course_name,
       c.category,
       p.quantity,
       (p.quantity*c.unit_price) AS total_revenue,
       p.purchase_date
FROM purchases AS p
LEFT JOIN courses AS c
ON c.course_id=p.course_id
LEFT JOIN learners AS l
ON l.learner_id=p.learner_id;