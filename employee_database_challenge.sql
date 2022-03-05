--Deliverable 1, Retiring Employees by Title--
--D1, retirement titles
select 
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
	into retirement_titles
	from employees as e
	inner join titles as t
	on (e.emp_no = t.emp_no)
	where birth_date between '1952-01-01' and '1955-12-31'
	order by e.emp_no
	

--D1, remove dupes
SELECT DISTINCT ON (emp_no) emp_no,
		first_name,
		last_name,
		title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no ASC, to_date DESC;

-- D1, employees by title about to retire
select count(title), title
into retiring_titles
from unique_titles
group by title
order by count(title) desc;

--D2, Employees eligible for the mentorship program
select distinct on (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
into mentorship_eligibility
from employees as e
inner join dept_emp as de
on (e.emp_no = de.emp_no)
inner join titles as t
on (e.emp_no = t.emp_no)
where 
	de.to_date = '999-01-01' and
	e.birth_date between '1965-01-01' and '1965-12-31'
order by e.emp_no;



--D3, additional tables
--mentorship eligibility by title
select count(title), title
from mentorship_eligibility
group by title
order by count(title) desc;

--current mentorship eligibility vs outgoing by department
select distinct on (e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title,
		d.dept_name
		into mentorship_eligibility_in_dept
		from employees as e
		inner join dept_emp as de
		on (e.emp_no = de.emp_no)
		inner join titles as t
		on (e.emp_no = t.emp_no)
		inner join departments as d
		on (d.dept_no = de.dept_no)
		where de.to_date = '999-01-01' and
		e.birth_date between '1965-01-01' and '1965-12-31'
		order by e.emp_no;

--count of available mentors per dept
select count(title) as "potential_mentors",
		dept_name
into available_mentors
from mentorship_eligibility_in_dept
group by dept_name
order by count(title) desc;

--match available mentors with retiring employees per dept
select count(title) as "potential_mentors",
		dept_name
into available_mentors
from mentorship_eligibility_in_dept
group by dept_name
order by count(title) desc;
















