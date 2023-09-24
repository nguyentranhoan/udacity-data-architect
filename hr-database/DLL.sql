create table departments
(
	id INTEGER
		primary key autoincrement,
	name varchar(80) not null
);

create table employees
(
	id TEXT
		primary key
		unique,
	name varchar(80) not null,
	email TEXT not null,
	hire_date TEXT not null,
	education_level varchar(50) not null
);

create table department_lead
(
	id INTEGER
		primary key,
	department_id bigint
		references departments,
	manager_id TEXT
		references employees,
	start_date TEXT not null,
	end_date TEXT
);

create table job_titles
(
	id INTEGER
		primary key autoincrement,
	title varchar(50)
);

create table location
(
	id INTEGER
		primary key autoincrement,
	region_name varchar(80) not null,
	city_name varchar(50) not null,
	state_name varchar(50) not null,
	address varchar(80) not null
);

create table job_histories
(
	id INTEGER
		primary key autoincrement,
	job_title_id bigint
		references job_titles,
	start_date TEXT not null,
	end_date TEXT,
	employee_id TEXT
		references employees,
	department_id bigint
		references departments,
	location_id bigint
		references location,
	salary float not null
);

