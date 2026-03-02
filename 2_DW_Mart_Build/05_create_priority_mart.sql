-- Step 5: Mart - Create priority roles mart
DROP SCHEMA IF EXISTS priority_mart CASCADE;

CREATE SCHEMA priority_mart;

SELECT '=== Loading Roles for Priority Mart ===' AS info;
CREATE OR REPLACE TABLE priority_mart.priority_roles (
    role_id INT PRIMARY KEY,
    role_name VARCHAR,
    priority_lvl INT 
);

INSERT INTO priority_mart.priority_roles
VALUES
    (1, 'Data Engineer', 2),
    (2, 'Senior Data Engineer', 1),
    (3, 'Software Engineer', 3);

SELECT * FROM priority_mart.priority_roles;


SELECT '=== Loading Snapshot for Priority Mart ===' AS info;
CREATE or REPLACE TABLE priority_mart.priority_jobs_snapshot (
    job_id              INT PRIMARY KEY,
    job_title_short     VARCHAR,
    company_name        VARCHAR,
    job_posted_date     TIMESTAMP,
    salary_year_avg     DOUBLE,
    priority_lvl        INT,
    updated_at          TIMESTAMP
);

INSERT INTO priority_mart.priority_jobs_snapshot
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.name company_name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    r.priority_lvl,
    CURRENT_TIMESTAMP updated_at
FROM 
    job_postings_fact jpf
LEFT JOIN
    company_dim cd
    ON jpf.company_id = cd.company_id
INNER JOIN 
    priority_mart.priority_roles r 
    ON jpf.job_title_short = r.role_name;



SELECT 
    job_title_short,
    COUNT(*) AS job_count,
    MIN(priority_lvl) AS priority_lvl,
    MIN(updated_at) updated_at
FROM
    priority_mart.priority_jobs_snapshot
GROUP BY 
    job_title_short
ORDER BY 
    job_count DESC;


-- .read "./05_create_priority_mart.sql"

