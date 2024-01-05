-- UC1
-- creating new database for address books
create database address_book_service;
show databases;

-- output to the above query
-- address_book_service
-- information_schema
-- mysql
-- payroll_service
-- performance_schema
-- sys

-- UC2
-- using the created database
use address_book_service;

-- creating an address book table
create table address_book_1 (
    first_name varchar(50) not null,
    last_name varchar(50),
    address varchar(100),
    city varchar(20),
    state varchar(20),
    zip varchar(10),
    phone varchar(20), 
    email varchar(320)
);

-- UC3
-- creating new contacts in address book
insert into address_book_1 (first_name, last_name, address, city, state, zip, phone, email) values
	("Tinam", "Durge", "abc", "Jamshedpur", "Jharkhand", "831009", "91 9313402393", "tinamdurge02@gmail.com"),
    ("Tanya", "Singh", "abc", "Mumbai", "Maharashtra", "456002", "91 5446123345", "tanya@gmail.com"),
    ("Priya", "Shah", "pqr", "Ahmedabad", "Gujarat", "380001", "91 945612345", "priya@gmail.com");
select * from address_book_1;

-- output to the above query
-- Tinam	Durge	abc	Jamshedpur	Jharkhand 831009	91 9313402393	tinamdurge02@gmail.com
-- Tanya	Singh	abc	Mumbai	Maharashtra	456002	91 5446123345	tanya@gmail.com
-- Priya	Shah	pqr	Ahmedabad	Gujarat	380001	91 945612345	priya@gmail.com

-- UC4
-- editing the contact using first name
update address_book_1 set address = "pqr-201" where first_name = "Priya";
select * from address_book_1;

-- output to the above query
-- Tinam Durge	abc	Jamshedpur	Jharkhand	831009	91 9313402393	tinamdurge02@gmail.com
-- Tanya Singh	abc	Mumbai	Maharashtra	456002	91 5446123345	tanya@gmail.com
-- Priya	Shah	pqr-201	Ahmedabad	Gujarat	380001	91 945612345	priya@gmail.com

-- UC5
-- deleting a contact using first_name
delete from address_book_1 where first_name = "Priya";
select * from address_book_1;

-- output to the above query
-- Tinam	Durge	abc	Jamshedpur Jharkhand 831009	91 9313402393	tinamdurge02@gmail.com
-- Tanya	Singh	abc	Mumbai	Maharashtra	456002	91 5446123345	tanya@gmail.com

-- adding more data to table
insert into address_book_1 (first_name, last_name, address, city, state, zip, phone, email) values
	("Shreya", "Kulkarni", "addr-101", "Jamshedpur", "Jharkhand", "360001", "91 546513151", "shreya@gmail.com"),
    ("Aditi", "Das", "addr-405", "Pune", "Maharashtra", "456110", "91 78823345", "aditi@gmail.com"),
    ("Priya", "Shah", "addr-201", "Ahmedabad", "Gujarat", "380001", "91 945612345", "priya@gmail.com");

-- UC6
-- retrieving people belonging to city
select * from address_book_1 where city = "Jamshedpur";

-- output to the above query
-- Tinam	Durge	abc	Jamshedpur	Jharkhand 831009	91 9313402393	tinamdurge02@gmail.com
-- Shreya Kulkarni addr-101 Jamshedpur Jharkhand 360001 91 546513151 shreya@gmail.com

-- retrieving people belonging to state
select * from address_book_1 where state = "Maharashtra";

-- output to the above query
-- Tanya Sharma	abc	Mumbai	Maharashtra	456002	91 5446123345	tanya@gmail.com
-- Aditi	Das	addr-405	Pune	Maharashtra	456110	91 78823345	aditi@gmail.com

-- UC7
-- getting number of contacts by each city
select city, count(city) from address_book_1 group by city;

-- output to above query
-- Jamshedpur	2
-- Mumbai	1
-- Pune	1
-- Ahmedabad	1

-- getting number of contacts by every state
select state, count(state) from address_book_1 group by state;

-- output to above query
-- Gujarat	3
-- Maharashtra	2

-- UC8
-- retrieve entries sorted by name for particular city
select * from address_book_1 where city = "Rajkot" order by first_name asc;

-- output to above query
-- Tinam	Durge	abc	Jamshedpur	Jharkhand 831009	91 9313402393	tinamdurge02@gmail.com
-- Shreya Kulkarni addr-101 Jamshedpur Jharkhand 360001 91 546513151 shreya@gmail.com

-- UC 9
-- adding name and type to address book
alter table address_book_1 add column type varchar(20), add column name varchar(50);

-- adding name and type to all contacts
update address_book_1 set name = "book1";
update address_book_1 set type = "friends" where first_name in ("Shreya", "Priya");
update address_book_1 set type = "family" where first_name in ("Tinam", "Tanya", "Aditi");
select * from address_book_1;

-- output to above query
-- Tinam Durge	xyz	Jamshedpur Jharkhand	360005	91 9313402393	tinamdurge02@gmail.com	family	book1
-- Tanya Singh	abc	Mumbai	Maharashtra	456002	91 5446123345	rahul@gmail.com	family	book1
-- Shreya Kulkarni addr-101 Jamshedpur Jharkhand 360001 91 546513151 shreya@gmail.com	friends	book1
-- Aditi	Das	addr-405	Pune	Maharashtra	456110	91 78823345	aditi@gmail.com	family	book1
-- Priya	Shah	addr-201	Ahmedabad	Gujarat	380001	91 945612345	priya@gmail.com	friends	book1


-- UC10
-- get number of contacts by type
select type, count(type) from address_book_1 group by type;

-- output to above query
-- family	3
-- friends	2

-- UC12
-- modify tables to create separate entities
-- creating table for a new address book
create table address_book_2(
	person_id int not null,
    address_id int not null,
    name varchar(50),
    type varchar(20),
    primary key(person_id),
    foreign key(person_id) references person_details(person_id),
    foreign key(address_id) references address_details(address_id)
);

-- creating table for person details
create table person_details(
	person_id int not null auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50),
    phone varchar(20),
    email varchar(320) not null,
    primary key(person_id, first_name, email)
);

-- creating table for address details
create table address_details(
	address_id int not null auto_increment,
    address varchar(100) not null,
    city varchar(20) not null,
    state varchar(20),
    zip varchar(10),
    primary key(address_id)
);

-- inserting some values into the tables
insert into person_details(first_name, last_name, phone, email) values
	("Tinam", "Durge", "91 9313402393", "tinamdurge02@gmail.com"),
    ("Tanya", "Singh", "91 5446123345", "tanya@gmail.com"),
	("Shreya", "Kulkarni", "91 546513151", "shreya@gmail.com"),
    ("Aditi", "Das", "91 78823345", "aditi@gmail.com"),
    ("Priya", "Shah", "91 945612345", "priya@gmail.com");
insert into address_details(address, city, state, zip) values
	("abc", "Jamshedpur", "Jharkhand", "831009"),
    ("abc", "Mumbai", "Maharashtra", "456002"),
	("addr-101", "Jamshedpur", "Jharkhand", "360001"),
    ("addr-405", "Pune", "Maharashtra", "456110"),
    ("addr-201", "Ahmedabad", "Gujarat", "380001");
insert into address_book_2(person_id, address_id, name, type) values
	(1,1,"book2","Family"),
    (2,2,"book2","Family"),
    (3,3,"book2","Friend"),
    (4,4,"book2","Friend"),
    (5,5,"book2","Family");
    
-- UC13
-- ability to execute all queries as in UC6,7,8,10

-- retrieving people belonging to a city
select * from person_details where person_id in 
	(select person_id from address_book_2 as ab inner join address_details as ad on ab.address_id=ad.address_id where city = "Jamshedpur");

-- output to above query is
-- 1	Tinam Durge	91 9313402393	tinamdurge02@gmail.com
-- 3	Shreya	Kulkarni	91 546513151	shreya@gmail.com

-- count contacts by city or state
select state, count(person_id) from address_book_2 as ab inner join address_details as ad on ab.address_id=ad.address_id where state = "Jharkhand";

-- output to above query is
-- Jharkhand	3

-- get contacts sorted by name for given city
select * from person_details where person_id in 
	(select person_id from address_book_2 as ab inner join address_details as ad on ab.address_id=ad.address_id where city = "Jamshedpur")
order by first_name asc;

-- output to above query
-- 1	Tinam Durge	91 9313402393	tinamdurge02@gmail.com
-- 3	Shreya	Kulkarni	91 546513151	shreya@gmail.com

-- count contacts by type
select type, count(type) from address_book_2 group by type;

-- output to above query
-- Family	3
-- Friend	2

-- UC18
-- adding the date_added attribute to contacts
alter table address_book_2 add column date_added date not null;
update address_book_2 set date_added = "2023-12-12";
select * from address_book_2;

-- output to above query
-- 1	1	book2	Family	2023-12-11
-- 2	2	book2	Family	2023-12-11
-- 3	3	book2	Friend	2023-12-11
-- 4	4	book2	Friend	2023-12-11
-- 5	5	book2	Family	2023-12-11