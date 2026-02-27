-- Step:4 - create skills demand mart

DROP SCHEMA IF EXISTS skills_mart CASCADE;
CREATE SCHEMA skills_mart;


CREATE TABLE skills_mart.dim_skills (
    skill_id    INT PRIMARY KEY,
    skills      VARCHAR,
    type        VARCHAR
);

SELECT '=== Loading Skills Dim for Skills Mart ===' AS info;

INSERT INTO skills_mart.dim_skills
SELECT 
    skill_id,
    skills,
    type 
FROM skills_dim;

CREATE TABLE skills_mart.dim_date_month (
    month_start_date DATE PRIMARY KEY, 
    year INT,
    month INT,
    quarter INT,
    quarter_name VARCHAR,
    year_quarter VARCHAR
);

SELECT '=== Loading Date Dim for Skills Mart ===' AS info;

INSERT INTO skills_mart.dim_date_month
SELECT DISTINCT
    DATE_TRUNC('month', job_posted_date) AS month_start_date,
    EXTRACT(YEAR FROM job_posted_date) AS year,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(QUARTER FROM job_posted_date) AS quarter,
    'Q-' || EXTRACT(QUARTER FROM job_posted_date)::VARCHAR AS quarter_name,
    EXTRACT(YEAR FROM job_posted_date)::VARCHAR || '-Q' || EXTRACT(QUARTER FROM job_posted_date)::VARCHAR 
    AS year_quarter
FROM job_postings_fact
ORDER BY month_start_date;


CREATE TABLE skills_mart.fact_skill_demand_monthly (
    skill_id INT,
    month_start_date DATE,
    job_title_short VARCHAR,
    postings_count INT,
    remote_postings_count INT,
    health_insurance_postings_count INT,
    no_degree_mention_postings_count INT,
    PRIMARY KEY (skill_id, month_start_date, job_title_short),
    FOREIGN KEY (skill_id) REFERENCES skills_mart.dim_skills (skill_id),
    FOREIGN KEY (month_start_date) REFERENCES skills_mart.dim_date_month (month_start_date)

);

SELECT '=== Loading Skill Fact for Skills Mart ===' AS info;

INSERT INTO skills_mart.fact_skill_demand_monthly
WITH job_postings_prep AS (
SELECT
    skill_id,
    DATE_TRUNC('month', jpf.job_posted_date) AS month_start_date,
    jpf.job_title_short,
    -- convert boolean flags
    CASE 
        WHEN jpf.job_work_from_home IS TRUE THEN 1
        ELSE 0
    END AS is_remote,
    CASE 
        WHEN jpf.job_health_insurance IS TRUE THEN 1
        ELSE 0
    END AS has_health_insurance,
    CASE 
        WHEN jpf.job_no_degree_mention IS TRUE THEN 1
        ELSE 0
    END AS no_degree_mentioned
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
)
SELECT
    skill_id,
    month_start_date,
    job_title_short,
    COUNT(*) postings_count,
    SUM(is_remote) remote_postings_count,
    SUM(has_health_insurance) health_insurance_postings_count,
    SUM(no_degree_mentioned) no_degree_mention_postings_count
FROM job_postings_prep 
GROUP BY ALL 
ORDER BY 
    skill_id,
    month_start_date,
    job_title_short;



-- Checking Data Validation
SELECT 'skills_mart.dim_skills' AS table_name, COUNT(*) AS record_count FROM skills_mart.dim_skills
UNION ALL
SELECT 'skills_mart.dim_date_month',COUNT(*) FROM skills_mart.dim_date_month
UNION ALL
SELECT 'skills_mart.fact_skill_demand_monthly',COUNT(*) FROM skills_mart.fact_skill_demand_monthly;



SELECT '== Skill Dimension Sample ==' AS info;
SELECT * FROM skills_mart.dim_skills LIMIT 10;

SELECT '== Date Month Dimension Sample ==' AS info;
SELECT * FROM skills_mart.dim_date_month LIMIT 10;

SELECT '== Skill Demand Fact Sample ==' AS info;
SELECT * FROM skills_mart.fact_skill_demand_monthly LIMIT 10;




