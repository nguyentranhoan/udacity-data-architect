-- question 1
select e.name, d.name, jt.title
from job_histories join departments d on d.id = job_histories.department_id
join job_titles jt on job_histories.job_title_id = jt.id
join employees e on job_histories.employee_id = e.id;


-- question 2
insert into job_titles(title)
values ('Web Programmer');

select * from job_titles
where title='Web Programmer';


-- question 3
update job_titles
set title='web developer'
where title='Web Programmer';

select * from job_titles
where title='web developer';


-- question 4
delete from job_titles
where title='web developer';

select * from job_titles
where title='web developer';


-- question 5
select count(distinct(employee_id)), d.name as department_name
from job_histories join departments d on d.id = job_histories.department_id
group by department_name;


-- question 6
with temp as (
    select dd.id, dd.name as department_name, e2.name as manager_name, dl.manager_id
    from department_lead dl
        join employees e2 on e2.id = dl.manager_id
        join departments dd on dd.id = dl.department_id

)

select e.name as employee_name, jt.title as job_title, d.department_name, d.manager_name, jh.start_date, jh.end_date
from job_histories jh
    join employees e on e.id = jh.employee_id
    join job_titles jt on jh.job_title_id = jt.id
    join temp d on e.id = d.manager_id
where e.name='Toni Lembeck';

