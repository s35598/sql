--Example tasks
--1|Calculate the average earnings in a company. The result column should be called Average Wage.

SELECT AVG(sal) AS AVARAGE_WAGE
FROM emp;

--2|Calculate the average earnings for each job in each department.

SELECT d.dname AS DEPARTMENT_NAME, e.job, AVG(e.sal) AS AVERAGE_EARNINGS
FROM emp e
JOIN Dept d ON e.deptno = d.deptno
GROUP BY d.dname, e.job;

--3Select the average earnings of departments that have more than three employees.

SELECT d.deptno, AVG(e.sal) AS AVERAGE_EARNINGS, COUNT(*)
FROM emp e
JOIN Dept d ON e.deptno = d.deptno
GROUP BY d.deptno
HAVING COUNT(*) > 3;


--4|List the lowest salaries paid to subordinates of their managers. Eliminate groups with minimum
--salaries less than 1,000. Arrange the results in descending order by salary size.

SELECT mgr AS MANAGER_ID, MIN(sal) as LOWEST_SALARY
FROM emp
WHERE mgr IS NOT NULL
GROUP BY mgr
HAVING MIN(sal) >= 1000
ORDER BY LOWEST_SALARY DESC;

-- Individual tasks
--1 Find the minimum salary for a CLERK position.

SELECT MIN(SAL),job
FROM emp
WHERE job = 'CLERK'
GROUP BY job;


--2 Count the employees employed in department 20.

SELECT deptno, COUNT(*) AS EMPLOYEE_COUNT
FROM emp
WHERE deptno = 20
GROUP BY deptno;


--3 Calculate the average earnings for each of the jobs.

SELECT AVG(sal),job
FROM emp
GROUP BY job;

--4 Calculate the average earnings for each of the jobs, except for the MANAGER job.

SELECT AVG(sal),job
FROM emp
WHERE job != 'MANAGER'
GROUP BY job;

--5 Calculate the maximum earnings for each job position.

SELECT MAX(sal),job
FROM emp
GROUP BY job;

--6 Select jobs with average earnings greater than or equal to 3,000.

SELECT AVG(sal) AS average_earnings, job
FROM emp
GROUP BY job
HAVING AVG(sal) >= 3000;

--7 Find average monthly salaries and average annual earnings for each position (remember to includecommissions).

SELECT job,AVG(sal) AS average_monthly_earnings, AVG(sal * 12 + NVL(comm, 0)) AS AVG_ANNUAL_EARNINGS
FROM emp
GROUP BY job;

--8 Find departments with more than three employees.

SELECT d.deptno,d.dname, COUNT(*) AS EMPLOYEE_COUNT
FROM emp e
JOIN Dept d ON e.deptno = d.deptno
GROUP BY d.deptno,d.dname
HAVING COUNT(*) > 3;


--9 Verify that all employee numbers are indeed different from each other.

SELECT empno, COUNT(*) AS EMPLOYEE_COUNT
FROM emp
GROUP BY empno
HAVING COUNT(*) > 1;

--SELECT COUNT(empno), COUNT(DISTINCT empno)
--FROM emp;

--10 Count how many employees a department based in DALLAS has.

SELECT d.loc AS LOCATION, COUNT(e.empno) AS EMPLOYEE_COUNT
FROM emp e
JOIN Dept d ON e.deptno = d.deptno
WHERE loc = 'DALLAS'
GROUP BY d.loc;


--11 List the maximum earnings for each salary group.

SELECT MAX(e.sal + NVL(comm,0)) AS maximum_earnings, s.grade
FROM emp e
JOIN Salgrade s ON e.sal BETWEEN s.losal AND s.hisal
GROUP BY s.grade;


--12 Find which earnings values are recurring and how many workers receive them.

SELECT (sal + NVL(comm, 0)), COUNT(*)
FROM emp
GROUP BY (sal + NVL(comm, 0))
HAVING COUNT(*) > 1;

--13 Give the average earnings of workers in the second salary group

SELECT AVG(e.sal + NVL(comm,0)) AS average_earnings, s.grade
FROM emp e
JOIN Salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade = 2
GROUP BY s.grade;

--14 Find out how many subordinates each manager has. Show name of the manager.

SELECT m.ename AS MANAGER_NAME, COUNT(e.empno) AS SUBORDINATES_COUNT
FROM emp e
JOIN emp m ON e.mgr = m.empno
GROUP BY m.ename;

--15 Give the total that all workers in the first salary group earn together.

SELECT SUM(e.sal + NVL(comm,0)) AS TOTAL_EARNINGS, s.grade
FROM emp e
JOIN Salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade = 1
GROUP BY s.grade;

-- Additional tasks
-- 1 Show average duration of all projects. Name the resulting column as AVERAGE TIME.

    


-- 2 For each salary grade, list the highest existing earnings. Include only those employees who have
-- worked for more than 10 years.



-- 3 Show average earnings for each department. Show only those departments whose average earnings
-- are below 2,000. Include departments that have no employees.



-- 4 For each project, count how many employees are involved. Count only those employees who work in
-- SALES or RESEARCH.



-- 5 For each boss, show the average salary of his subordinates and the number of subordinates. Sort the
-- records by the number of subordinates and then descending by name.








