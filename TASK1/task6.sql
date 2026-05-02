--Example tasks
-- 1|List the names, employee numbers, job titles, salaries, and department numbers of all employees with a CLERK job

SELECT ename,empno,job,sal,deptno
FROM emp
WHERE job = 'CLERK';

-- 2 Find the names and numbers of employees whose bosses are 7902, 7566, or 7788.

SELECT ename,empno,mgr
FROM emp
WHERE mgr = 7902 OR mgr = 7566 OR mgr = 7788;
-- or WHERE mgr IN (7902,7566,7788);

-- 3 Find the four-letter names of the employees.

SELECT ename
FROM emp
WHERE LENGTH(ename) = 4;

-- 4 Find the data of those employees who have a boss.

SELECT empno,ename,mgr
FROM emp
WHERE mgr IS NOT NULL;

-- 5 List the names, annual salary, and commission of all those SALESMANs whose monthly salary exceeds commission. Sort the results by decreasing salary, then by name (ascending).

SELECT ename,sal * 12 AS annual_salary, NVL(comm, 0), job
FROM emp
WHERE job = 'SALESMAN' AND sal > NVL(comm, 0)
ORDER BY sal DESC, ename ASC;

-- 6 Select the names of all employees, and the names of the departments in which they are employed. Sort the returned records in alphabetical order of the surnames

SELECT e.ename, d.dname
FROM emp e
JOIN dept d ON e.deptno = d.deptno
ORDER BY e.ename;

-- 7 List information about employees whose salaries correspond to salary class 3.

SELECT e.empno,e.ename,e.sal,s.grade
FROM emp e
JOIN Salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.GRADE = 3;

-- 8 List employees who have worked at the company for more than 5 years.

SELECT empno,ename,hiredate
FROM emp
WHERE (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hiredate)) > 5;

-- 9 For each project, list the name and work of all employees in one column.

SELECT p.pname, (e.ename || ' - ' || e.job) AS EMPLOYEE
FROM emp e
JOIN emp_proj ON e.empno = emp_proj.empno
JOIN proj p ON p.projno = emp_proj.projno;

-- Individual tasks

-- 1 List the names of employees whose commission exceeds their monthly salary.

SELECT ename, sal AS Monthly_Salary , NVL(comm, 0) AS Commision
FROM EMP
WHERE sal < NVL(comm, 0);

-- 2 Find the data of those employees whose salaries are outside the range <1000, 2000>.

SELECT empno,ename,sal
FROM emp
WHERE sal < 1000 OR sal > 2000;

-- 3 Find data of those employees who are employed in the position of CLERK, or their earnings are within the range <1000,2000>

SELECT ename,job,sal
FROM emp
WHERE job = 'CLERK' AND (sal > 1000 AND sal < 2000);

-- 4 Find all those employees who are employed in the position of MANAGER, or in the position of
-- SALESMAN with a salary above 1500.

SELECT ename,job,sal
FROM emp
WHERE job = 'MANAGER' OR (job = 'SALESMAN' AND sal > 1500);

-- 5 List all the data from the SALGRADE table.

SELECT *
FROM Salgrade;

-- 6 Find the data of those employees employed in the position of CLERK whose salaries are not in the
-- range <1000,2000>.

SELECT ename,job,sal
FROM emp
WHERE job = 'CLERK' AND (sal < 1000 OR sal > 2000);



-- 7 List all distinct (non-repeating) job titles.

SELECT DISTINCT(job)
FROM emp;



-- 8 List the names, positions, and department numbers of all employees in Department 20 employed at
-- the CLERK position.

SELECT e.ename,e.job,d.deptno
FROM emp e
JOIN Dept d ON e.deptno = d.deptno
WHERE e.job = 'CLERK' AND d.deptno = 20;

-- 9 List the name, position, and salary of employees who have a boss.

SELECT ename,job,sal,mgr
FROM emp
WHERE mgr IS NOT NULL;

-- 10 For employees with a monthly salary over 1500, list their names, the locations of their departments,
-- and the names of those departments.

SELECT e.ename, e.sal, d.loc, d.dname
FROM emp e
JOIN Dept d ON e.deptno = d.deptno
WHERE e.sal > 1500;

-- 11 Select employees in department 30 and 40 (name, department no., department name, location). Also
-- list the information of the department, 40 in which there are no employees.

SELECT e.ename,d.deptno,d.dname,d.loc
FROM emp e
RIGHT JOIN Dept d ON e.deptno = d.deptno
WHERE d.deptno IN (30,40);

-- 12 Output the names of all employees and the names of all departments. The result is supposed to show
-- the names of employees not assigned to any departments, as well as the names of departments with
-- no employees.

SELECT e.ename,d.dname
FROM emp e
FULL OUTER JOIN Dept d ON e.deptno = d.deptno;

-- Additional tasks
-- 1 List the employees and the names of their departments for people whose salary is outside the range
-- (2000,3000) and whose name does not begin with K.

SELECT e.ename,d.dname,e.sal
FROM emp e
JOIN Dept d ON e.DEPTNO = d.DEPTNO
WHERE (e.sal < 2000 OR sal > 3000) AND e.ename NOT LIKE '%k';

-- 2 In one column, write the name of the project and the name of the employee. Include employees who
-- are not working on any project.

SELECT (e.ename || ' - ' || p.pname) AS EMPLOYEE_PROJECT
FROM emp e
LEFT JOIN emp_proj ON e.empno = emp_proj.empno
LEFT JOIN proj p ON p.projno = emp_proj.projno;

-- 3 For each project, count how many days it took. Call the column with the days LENGTH. Show data only
-- for projects started after 2020.

SELECT PROJNO,pname,(ENDDATE - STARTDATE) AS LENGTH,STARTDATE
FROM Proj
WHERE EXTRACT(YEAR FROM STARTDATE) >= 2020;

-- 4 For each employee, specify their income group and give the name of the boss. Exclude employees who do not have a boss.

SELECT e.ename, s.grade, m.ename as Boss_Name
FROM emp e
JOIN Salgrade s ON e.sal BETWEEN s.losal AND s.hisal
JOIN emp m ON e.mgr = m.empno;



-- 5 List all project information. Give appropriate headings: NAME, START DATE, END DATE. Sort the
-- projects by start date ascending and by name descending.

SELECT projno AS Project_Number,pname AS NAME,startdate AS "START DATE",enddate AS "END DATE"
FROM Proj
ORDER BY startdate ASC, pname DESC;
