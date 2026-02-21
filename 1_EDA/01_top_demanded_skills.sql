/*
==> What are the most in-demand skills for data engineers?
- identify the top 10 in-demand skills for data engineers
- Focus on remote jobs postings
- Why?
    Retrives the top 10 skills with the highest demand in the remote job market providing insights into the most valueable skills for data enginners seeking remote work
*/

WITH
    cte_top_skills
    AS
    (
        SELECT
            jpf.job_id,
            jpf.job_title_short,
            sd.skills,
            sd.type
        FROM job_postings_fact jpf
            INNER JOIN skills_job_dim sjd
            ON jpf.job_id = sjd.job_id
            INNER JOIN skills_dim sd
            ON sjd.skill_id = sd.skill_id
        WHERE jpf.job_title_short LIKE '%Data Engineer%'
            --WHERE jpf.job_title_short = 'Data Engineer' 
            AND jpf.job_work_from_home IS TRUE
    )
    SELECT
        skills,
        COUNT(*) demand_count
    FROM cte_top_skills
    GROUP BY skills
    ORDER BY demand_count DESC
    LIMIT 10;

-- Result:
/*
    
    WHERE jpf.job_title_short = 'Data Engineer' 
    ┌────────────┬──────────────┐
    │   skills   │ demand_count │
    │  varchar   │    int64     │
    ├────────────┼──────────────┤
    │ sql        │        29221 │
    │ python     │        28776 │
    │ aws        │        17823 │
    │ azure      │        14143 │
    │ spark      │        12799 │
    │ airflow    │         9996 │
    │ snowflake  │         8639 │
    │ databricks │         8183 │
    │ java       │         7267 │
    │ gcp        │         6446 │
    ├────────────┴──────────────┤
    │ 10 rows         2 columns │
    └───────────────────────────┘



    WHERE jpf.job_title_short LIKE '%Data Engineer%' 
    ┌────────────┬──────────────┐
    │   skills   │ demand_count │
    │  varchar   │    int64     │
    ├────────────┼──────────────┤
    │ sql        │        38368 │
    │ python     │        38117 │
    │ aws        │        24514 │
    │ azure      │        18707 │
    │ spark      │        17591 │
    │ airflow    │        13395 │
    │ snowflake  │        11781 │
    │ databricks │        10962 │
    │ java       │         9993 │
    │ kafka      │         9315 │
    ├────────────┴──────────────┤
    │ 10 rows         2 columns │
    └───────────────────────────┘
*/


