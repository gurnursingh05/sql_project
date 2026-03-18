# Introduction

📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📉 where high demand meets high salary in data analytics.
🔍 SQL queries? Check them out here: [project_sqlfolder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.
Data hails from my [SQL Course]. It's packed with insights on job titles, salaries, locations, and essential skills.
### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

## Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

**SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
**PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
**Visual Studio Code**: My go-to for database management and executing SQL queries.
**Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:
1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

# Here's the breakdown of the top data analyst jobs in 2023:

Massive outlier at the top. The Mantys "Data Analyst" role at $650,000 is a stark outlier — nearly double the second-highest salary (Meta's Director of Analytics at $336,500). This is unusual for an individual contributor title and could reflect a specialized/senior scope or a data quality artifact.
Director/Principal-level roles dominate the rest. Once you exclude that outlier, the top 9 roles are predominantly Director or Principal-level positions, with salaries ranging from $184,000 to $336,500 — a much tighter band.
SmartAsset appears twice. They posted both a "Principal Data Analyst (Remote)" at $205,000 and a "Principal Data Analyst" at $186,000 — suggesting either different seniority sub-levels or different teams, both solidly mid-range for this list.
Everything is remote-friendly. All 10 roles are tagged "Anywhere" and full-time, reflecting the strong remote-work trend for senior data roles in 2023.
Key salary bands:
$600k+ → extreme outlier (1 role)
$300k–$340k → top-tier director level (1 role)
$185k–$260k → the realistic "elite" band for most senior DA roles (8 roles)