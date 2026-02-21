/*
==> Question: What are the highest paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specific salaries
- include skill frequency to identify both salary and demand
- Why?
    helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for skill development priorities.
    the median is used instead of the average to reduce the impact of outlier salaries.
*/


WITH cte_top_skills AS
    (
    SELECT 
        jpf.job_title_short, 
        sd.skills, 
        jpf.salary_year_avg
    FROM 
        job_postings_fact jpf 
    INNER JOIN 
        skills_job_dim sjd
        ON jpf.job_id = sjd.job_id 
    INNER JOIN skills_dim sd 
        ON sjd.skill_id = sd.skill_id 
    -- WHERE jpf.job_title_short LIKE '%Data Engineer%' AND jpf.job_work_from_home IS TRUE
    WHERE jpf.job_title_short = 'Data Engineer' AND jpf.job_work_from_home IS TRUE
    )
    SELECT 
        skills, 
        ROUND(median(salary_year_avg), 0) median_salary,
        COUNT(*) demand_count
    FROM cte_top_skills
    GROUP BY skills
    HAVING COUNT(*) > 100
    ORDER BY median_salary DESC LIMIT 25;

/*

📊 Key Insights

💰 The highest salaries are linked to systems and infrastructure skills (e.g., Rust, Golang, Terraform), indicating strong demand for performance-focused and platform-level expertise.

☁️ Airflow, Kubernetes, and Terraform combine high salary with very high demand, making them core skills in modern data engineering.

🗃 Specialized databases like Neo4j and MongoDB command above-average pay, showing the value of distributed and non-relational data knowledge.

🧱 Backend frameworks (Spring, FastAPI, GraphQL) appear among top-paying skills, reflecting the growing overlap between data engineering and backend development.

🔐 Data governance knowledge (e.g., GDPR) is financially rewarded, highlighting the importance of compliance and secure data handling.

Overall: High-paying remote Data Engineering roles are strongly aligned with infrastructure, distributed systems, and backend engineering capabilities.


┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ terraform  │      184000.0 │         3248 │
│ golang     │      184000.0 │          912 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ css        │      150000.0 │          262 │
│ airflow    │      150000.0 │         9996 │
│ ruby       │      150000.0 │          736 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ css        │      150000.0 │          262 │
│ airflow    │      150000.0 │         9996 │
│ ruby       │      150000.0 │          736 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ css        │      150000.0 │          262 │
│ airflow    │      150000.0 │         9996 │
│ ruby       │      150000.0 │          736 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
├────────────┴───────────────┴──────────────┤
│ 25 rows                         3 columns │
└───────────────────────────────────────────┘



*/



