import sqlite3
import csv
import pandas as pd
import os


os.remove('udacity.db')


con = sqlite3.connect("udacity.db")
cur = con.cursor()


def create_table():
    cur.execute("""create table if not exists employees
(
    id text unique primary key,
    name varchar(80) not null,
    email text not null,
    hire_date text not null,
    education_level varchar(50) not null
);""")
    cur.execute("""
create table if not exists departments
(
    id INTEGER primary key AUTOINCREMENT,
    name varchar(80) not null
);
""")
    cur.execute("""
create table if not exists department_lead
(
    id integer primary key,
    department_id bigint references departments(id),
    manager_id text references employees(id),
    start_date text not null,
    end_date text
);
""")
    cur.execute("""
create table if not exists location
(
    id INTEGER primary key AUTOINCREMENT,
    region_name varchar(80) not null,
    city_name varchar(50) not null,
    state_name varchar(50) not null,
    address varchar(80) not null
);
""")
    cur.execute("""
create table if not exists job_titles
(
    id INTEGER primary key AUTOINCREMENT,
    title varchar(50)
);
""")
    cur.execute("""
create table if not exists job_histories
(
    id INTEGER primary key AUTOINCREMENT,
    job_title_id bigint references job_titles(id),
    start_date text not null,
    end_date text,
    employee_id text references employees(id),
    department_id bigint references departments(id),
    location_id bigint references location(id),
    salary float not null
);
""")
                
def get_data():
    data = pd.read_excel('hr-database/hr-dataset.xlsx')
    employees = data.drop_duplicates(subset=['EMP_ID']).get(['EMP_ID', 'EMP_NM', 'EMAIL', 'HIRE_DT', 'EDUCATION LEVEL']).values.tolist()
    salary = data.drop_duplicates(subset=['EMP_ID']).get(['EMP_ID', 'SALARY']).values.tolist()
    employee_data = [(item[0],item[1],item[2],str(item[3]),item[4]) for item in employees]
    departments = [(idx, item) for idx,item in enumerate(data.DEPARTMENT.unique().tolist(), start=1)]
    location_data = data.drop_duplicates(subset=['LOCATION', 'CITY', 'STATE', 'ADDRESS']).get(['LOCATION', 'CITY', 'STATE', 'ADDRESS'])
    location = [(idx, item[0], item[1], item[2], item[3]) for idx,item in enumerate(location_data.values.tolist(), start=1)]
    job_titles = [(idx, item) for idx,item in enumerate(data.JOB_TITLE.unique().tolist(), start=1)]

    cur.executemany("""INSERT INTO employees Values(?,?,?,?,?);""", employee_data)
    cur.executemany("""INSERT INTO departments Values(?,?);""", departments)
    cur.executemany("""INSERT INTO location Values(?,?,?,?,?);""", location)
    cur.executemany("""INSERT INTO job_titles Values(?,?);""", job_titles)
    # cur.executemany("""INSERT INTO salary Values(?,?,?);""", salary)

    con.commit()

    sql_departments = pd.read_sql_query("select id as DEPT_ID, name as DEPARTMENT from departments", con)
    sql_job_titles = pd.read_sql_query("select id as JT_ID, title as JOB_TITLE from job_titles", con)
    sql_location = pd.read_sql_query("select id as LOCATION_ID, region_name as 'LOCATION', city_name as 'CITY', state_name as 'STATE', address as 'ADDRESS'from location", con)
    # department_lead
    department_lead = pd.merge(data, sql_departments, how='inner', on='DEPARTMENT').get(['DEPT_ID', 'EMP_ID', 'START_DT', 'END_DT'])
    department_lead = [(idx, int(item[0]), str(item[1]), str(item[2]), str(item[3])) for idx,item in enumerate(department_lead.values.tolist(), start=1)]
    cur.executemany("""INSERT INTO department_lead Values(?,?,?,?,?);""", department_lead)
 
    # job_histories
    jh_data = pd.merge(data, sql_job_titles, how='inner', on='JOB_TITLE')
    jh_data = pd.merge(jh_data, sql_departments, how='inner', on='DEPARTMENT')
    jh_data = pd.merge(jh_data, sql_location, how='inner', on=['LOCATION', 'CITY', 'STATE', 'ADDRESS']).get(['JT_ID', 'HIRE_DT', 'END_DT', 'EMP_ID', 'DEPT_ID', 'LOCATION_ID'])
    jh_data = [(idx, item[0], str(item[1]), str(item[2]), item[3], item[4], item[5], item[6]) for idx,item in enumerate(jh_data.values.tolist(), start=1)]
    cur.executemany("""INSERT INTO job_histories Values(?,?,?,?,?,?,?);""", jh_data)


    con.commit()

create_table()
get_data()


tables = ['employees', 'departments', 'department_lead', 'location', 'job_titles', 'job_histories']
for table in tables:
    query = pd.read_sql_query(f"select * from {table} limit 2", con)
    print(table,"\n",query)