create table if not exists employees
(
    id text unique primary key,
    name varchar(80) not null,
    email text not null,
    education_level varchar(50) not null,
    is_manager boolean not null,
    is_active boolean not null,
    created_at timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

create table if not exists departments
(
    id serial primary key,
    name varchar(80) not null,
    manager_id text references employees(id)
);

create table if not exists regions
(
    id serial primary key,
    region_name varchar(80) not null
);

create table if not exists cities
(
    id serial primary key,
    name varchar(50) not null
);

create table if not exists states
(
    id serial primary key,
    city_id bigint references cities(id),
    state varchar(50) not null
);

create table if not exists address
(
    id serial primary key,
    address_name varchar(80) not null,
    region_id bigint references regions(id),
    state_id bigint references states(id)
);

create table if not exists job_titles
(
    id serial primary key,
    title varchar(50)
);

create table if not exists job_histories
(
    id serial primary key,
    job_title_id bigint references job_titles(id),
    start_date date not null,
    end_date date,
    employee_id text references employees(id),
    department_id bigint references departments(id),
    address_id bigint references address(id),
    salary float not null,
    is_active boolean not null DEFAULT True
);

create table if not exists salaries
(
    id serial primary key,
    job_id bigint references job_histories(id),
    salary_amount float not null,
    start_date date not null,
    end_date date
);
