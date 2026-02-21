/*
Question: what are the most optimal skills for data engineers? balancing both demand and salary
- create a ranking column that combines demand count and median salary to identify the most valuable skills
- focus on remote data engineer positions with specified annual salaries
- Why?
    this approach highlights skills that balances market demand and financial reward.
    it weights core skills appropriately, rather than letting rare, outlier skills distort the results

*/

WITH
    cte_top_skills
    AS
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
        -- WHERE jpf.job_title_short LIKE '%Data Engineer%' 
        WHERE 
        jpf.job_title_short = 'Data Engineer'
            AND jpf.job_work_from_home IS TRUE
            AND jpf.salary_year_avg IS NOT NULL
    )
    SELECT
        skills,
        ROUND(MEDIAN(salary_year_avg), 0) median_salary,
        -- COUNT(salary_year_avg) demand_count,
        ROUND(LN(COUNT(*)), 1) ln_demand_count,
        ROUND((MEDIAN(salary_year_avg) * LN(COUNT(*)) / 1_000_000), 2) AS optimal_score
    FROM cte_top_skills
    GROUP BY skills
    HAVING COUNT(*) > 100
    ORDER BY optimal_score DESC LIMIT 25;


/*

📊 Key Insights (Optimal Skills – Demand + Salary Balanced)

🥇 Terraform ranks highest overall, showing the strongest balance between high salary and strong market demand.

🧠 Core fundamentals like Python and SQL rank near the top due to extremely high demand, even if their salaries are slightly lower than niche skills.

☁️ Cloud platforms (AWS, Azure, GCP) and cloud data tools (Snowflake, BigQuery, Redshift) are consistently strong performers, reinforcing cloud expertise as essential.

🔄 Modern data stack technologies (Airflow, Spark, Kafka, Databricks, PySpark) score highly, highlighting the importance of distributed data processing and orchestration.

🐳 Infrastructure tools (Kubernetes, Docker) remain valuable but rank slightly lower than core programming and cloud skills when balancing both pay and demand.

Overall: The most optimal skills are not rare niche tools, but widely adopted technologies that combine strong salaries with high demand — especially cloud, orchestration, and distributed processing tools.


┌────────────┬───────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ ln_demand_count │ optimal_score │
│  varchar   │    double     │     double      │    double     │
├────────────┼───────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │             5.3 │          0.97 │
│ python     │      135000.0 │             7.0 │          0.95 │
│ sql        │      130000.0 │             7.0 │          0.91 │
│ aws        │      137320.0 │             6.7 │          0.91 │
│ airflow    │      150000.0 │             6.0 │          0.89 │
│ spark      │      140000.0 │             6.2 │          0.87 │
│ kafka      │      145000.0 │             5.7 │          0.82 │
│ snowflake  │      135500.0 │             6.1 │          0.82 │
│ azure      │      128000.0 │             6.2 │          0.79 │
│ java       │      135000.0 │             5.7 │          0.77 │
│ scala      │      137290.0 │             5.5 │          0.76 │
│ kubernetes │      150500.0 │             5.0 │          0.75 │
│ git        │      140000.0 │             5.3 │          0.75 │
│ databricks │      132750.0 │             5.6 │          0.74 │
│ redshift   │      130000.0 │             5.6 │          0.73 │
│ gcp        │      136000.0 │             5.3 │          0.72 │
│ nosql      │      134415.0 │             5.3 │          0.71 │
│ hadoop     │      135000.0 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │             5.0 │           0.7 │
│ docker     │      135000.0 │             5.0 │          0.67 │
│ mongodb    │      135750.0 │             4.9 │          0.67 │
│ r          │      134775.0 │             4.9 │          0.66 │
│ go         │      140000.0 │             4.7 │          0.66 │
│ bigquery   │      135000.0 │             4.8 │          0.65 │
│ github     │      135000.0 │             4.8 │          0.65 │
├────────────┴───────────────┴─────────────────┴───────────────┤
│ 25 rows                                            4 columns │
└──────────────────────────────────────────────────────────────┘
*/
