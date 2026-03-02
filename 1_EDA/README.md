# 📊 SQL-Based Exploratory Data Analysis: Data Engineer Job Market

![Project Preview](../Images/1_1_Project1_EDA1.png)

A structured SQL analytics project that explores the data engineer job market using real-world job posting data. This project highlights my ability to translate business questions into efficient analytical queries and extract actionable insights from a dimensional data warehouse.

---

## 🧾 Executive Overview (For Recruiters & Hiring Managers)

- ✅ **Analytical scope:** Developed 3 production-style SQL queries to evaluate demand, salary, and skill optimization
- ✅ **Dimensional querying:** Performed multi-table joins across fact, dimension, and bridge tables
- ✅ **Advanced analytics:** Applied aggregations, filtering logic, and ranking techniques
- ✅ **Business insights delivered:** Identified dominant programming languages, cloud adoption trends, and high-value infrastructure tools

---

## ⏱ Quick Review (1-Minute Overview)

If reviewing quickly, focus on these core analytical queries:

1. [`01_top_demanded_skills.sql`](./01_top_demanded_skills.sql) – Skill demand analysis using multi-table joins
2. [`02_top_paying_skills.sql`](./02_top_paying_skills.sql) – Salary-based skill ranking using statistical aggregation
3. [`03_optimal_skills.sql`](./03_optimal_skills.sql) – Demand + salary optimization using logarithmic scoring

---

## 🎯 Business Context

Hiring analysts and career strategists often need to answer:

- 🎯 Which technical skills appear most frequently in data engineer job postings?
- 💰 Which skills command the highest compensation?
- ⚖️ Which skills offer the best balance between demand and salary?

To answer these questions, this project queries a dimensional data warehouse structured using a star schema model.

---

## 🏛 Data Warehouse Structure

![Warehouse Schema](../Images/1_2_Data_Warehouse.png)

The warehouse includes:

### 📌 Fact Table

- `job_postings_fact` – Core table containing job metadata such as title, salary, location, and posting date

### 📌 Dimension Tables

- `company_dim` – Company-level descriptive attributes
- `skills_dim` – Skill catalog with standardized skill names and categories

### 📌 Bridge Table

- `skills_job_dim` – Resolves the many-to-many relationship between job postings and skills

By joining across these interconnected tables, the analysis extracts demand metrics, compensation statistics, and value-based skill rankings.

---

## 🛠 Technology Stack

- 🐥 **Query Engine:** DuckDB (optimized for analytical workloads)
- 🧾 **Language:** SQL (ANSI-style with analytical and mathematical functions)
- 📐 **Data Model:** Star schema (fact + dimensions + bridge)
- 💻 **Development Environment:** VS Code + DuckDB CLI
- 📦 **Version Control:** Git & GitHub

---

## 📁 Project Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql        # Skill demand analysis
├── 02_top_paying_skills.sql          # Salary-focused analysis
├── 03_optimal_skills.sql             # Combined demand + salary scoring
└── README.md                         # Project documentation
```

---

# 📈 Analytical Approach

## Query Breakdown

### 1️⃣ Top Demanded Skills

Identifies the 10 most frequently requested skills for remote data engineer positions.

- Uses multi-table joins
- Filters for remote roles
- Counts job occurrences per skill
- Orders by demand descending

---

### 2️⃣ Top Paying Skills

Evaluates the 25 highest-paying skills.

- Filters out NULL salaries
- Computes median salary per skill
- Includes demand metrics for context
- Sorts by compensation level

---

### 3️⃣ Optimal Skills Ranking

Introduces a scoring method combining demand and compensation.

- Applies `LN()` (natural logarithm) to normalize demand
- Combines log-transformed demand with median salary
- Filters for skills with ≥ 100 job postings
- Produces a balanced "value score"

This method prevents highly common skills from dominating purely due to frequency.

---

# 🔎 Key Findings

- 🧠 **Core Programming Languages:** SQL and Python dominate demand (~29,000 postings each)
- ☁️ **Cloud Platforms:** AWS and Azure remain critical for modern data engineering roles
- 🧱 **Infrastructure & DevOps:** Kubernetes, Docker, and Terraform correlate with higher salary brackets
- 🔥 **Big Data Ecosystem:** Apache Spark shows both strong demand and competitive compensation

---

# 💻 SQL Competencies Demonstrated

## 🔗 Query Engineering

- Multi-table `INNER JOIN` operations across fact, dimension, and bridge tables
- Efficient join strategies aligned with star schema modeling
- Use of CTEs (Common Table Expressions) for structured transformations

---

## 📊 Aggregation & Statistical Analysis

- `COUNT()` for demand measurement
- `MEDIAN()` for compensation analysis
- `ROUND()` for presentation-ready metrics
- `GROUP BY` for categorical aggregation
- `HAVING` for filtering aggregated results

---

## 🎯 Filtering & Ranking

- Boolean filtering with `WHERE`
- Multiple conditional filters (`job_title_short`, `job_work_from_home`, salary constraints)
- `ORDER BY DESC` for ranking
- `LIMIT` for top-N selection

---

## 🧮 Mathematical & Analytical Functions

- `LN()` for natural logarithm normalization
- Derived scoring metrics combining demand and salary
- Proper NULL handling (`salary_year_avg IS NOT NULL`)
- Log-based transformation to prevent skew from extreme frequency counts

---

# 🏁 Project Outcome

This project demonstrates the ability to:

- Query dimensional data warehouses efficiently
- Apply analytical thinking to real-world labor market data
- Design production-quality SQL queries
- Derive actionable business insights from structured datasets
- Communicate technical findings clearly
