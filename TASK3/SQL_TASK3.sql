-- Example tasks
-- 1 Find employees with a salary equal to the company's minimum wage.

SELECT ename,sal
FROM emp
WHERE sal = (
    SELECT MIN(sal)
    FROM emp
    );


-- 2 Find employees with salaries equal to the lowest salaries in their corresponding departments.

SELECT ename,sal,deptno
FROM emp
WHERE (deptno,sal) IN (
    SELECT deptno,MIN(sal)
    FROM emp
    GROUP BY deptno
    );


-- 3 Find the employees with the lowest salaries in their departments.

SELECT ename,sal,deptno
FROM emp
WHERE sal IN (
    SELECT MIN(sal)
    FROM emp
    GROUP BY deptno
    );

-- 4 Using the ANY quantifier, select the employees earning more than the lowest salary in department 30
-- (i.e., more than any employee in department 30).

-- ANY ALL = < >

SELECT ename,sal,deptno
FROM emp
WHERE sal > ANY (
    SELECT sal
    FROM emp
    WHERE deptno = 30
    );

-- 5 Find the position with the highest average earnings.

SELECT job, AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) >= ALL (
    SELECT AVG(sal)
    FROM emp
    GROUP BY job
    );

SELECT job, AVG(sal)
FROM emp
GROUP BY job
HAVING AVG(sal) = (
    SELECT MAX(AVG(sal))
    FROM emp
    GROUP BY job
    );


-- 6 Using operations on the result set, find the jobs that appear in department 10 and 30 in the same time.

    SELECT job
    FROM emp
    WHERE deptno = 10
    INTERSECT
    SELECT job
    FROM emp
    WHERE deptno = 30;

-- Individual tasks

-- 1 Find all employees employed in the same position as BLAKE.

SELECT job,ename,empno
FROM emp
WHERE job = (
    SELECT job
    FROM emp
    WHERE ename = 'BLAKE'
    ) AND ename != 'BLAKE';


-- 2 Using the ALL quantifier, find employees whose earnings are above the salary of any employee in
-- department 30 (that is, greater than the highest salary in department 30).

    SELECT sal,ename,deptno
    FROM emp
    WHERE sal > ALL (
        SELECT sal
        FROM emp
        WHERE deptno = 30
        );

-- 3 Select departments whose average earnings exceed the average earnings of department 30.

SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) > (
    SELECT AVG(sal)
    FROM emp
    WHERE deptno = 30
    GROUP BY deptno
    );

-- 4 Find employees whose salaries exceed the highest salaries from the SALES department.

SELECT empno,ename,sal
FROM emp
WHERE sal > ALL (
    SELECT e.sal
    FROM emp e
    JOIN Dept d ON e.deptno = d.DEPTNO
    WHERE dname = 'SALES'
  );

-- 5 Find employees who work in the same position as employee number 7369 and whose salaries are
-- greater than employee number 7876.

SELECT empno,ename,job,sal
FROM emp
WHERE job = (
    SELECT job
    FROM emp
    WHERE empno = 7369
    ) AND empno != 7369
INTERSECT
SELECT empno,ename,job,sal
FROM emp
WHERE sal > (
    SELECT sal
    FROM emp
    WHERE empno = 7876
    );

-- 6 List the names of the departments in which the clerks work.

SELECT dname
FROM DEPT
WHERE deptno IN (
    SELECT deptno
    FROM emp
    WHERE job = 'CLERK'
    );

-- 7 Using operations on the result set, list the positions that appear in department 10 and not in 30.

SELECT job
FROM emp
WHERE deptno = 10
MINUS
SELECT job
FROM emp
WHERE deptno = 30;

-- 8 Using operations on the result set, list all positions that appear in departments 10 and 30.

SELECT job
FROM emp
WHERE deptno = 10
INTERSECT
SELECT job
FROM emp
WHERE deptno = 30;