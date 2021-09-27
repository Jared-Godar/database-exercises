USE employees;

    create temporary table hopper_1545.employee_department_salary AS (
        select emp_no, first_name, last_name, dept_name, salary
        from employees
        join dept_emp using(emp_no)
        join departments using (dept_no)
        join salaries using(emp_no)
        where salaries.to_date > curdate() and dept_emp.to_date > curdate()
    );
    
    select * from hopper_1545.employee_department_salary;