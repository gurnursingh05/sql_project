# Introduction

Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📉 where high demand meets high salary in data analytics.
SQL queries? Check them out here: [project_sqlfolder](/project_sql/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.
Data hails from my [SQL Course](https://www.lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.
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

![Top Paying Roles](assets\1_top_paying_jobs.png)
*Bar graph visualizing the salary for the top 10 salaries for data analytics; 
CLAUDE generated this graph for my SQL query results*

2. Top Paying Skills
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills AS skill_name
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY   
    top_paying_jobs.salary_year_avg DESC
```
1. Core must-haves (8–10 roles): SQL and Tableau appear together in 8 out of 10 roles, making them the undisputed baseline combination. Python follows closely at 7 roles — essentially non-negotiable for senior positions.
2. Secondary tier (4–7 roles): R shows up in 4 roles, mostly at the director/principal level, suggesting it matters more as seniority increases. Snowflake, pandas, Excel, and numpy form a practical second tier that differentiates candidates.
3. Category breakdown: Languages (SQL, Python, R, Go) dominate total mentions, followed by Cloud/DB tools (Snowflake, AWS, Azure, Oracle). 
Notably, Collaboration tools (Atlassian, Jira, Confluence, Bitbucket) are heavily concentrated in just two high-paying roles — the Director at Inclusively ($189k) and the Motional AV role ($189k) — suggesting that tool-heavy environments correlate with cross-functional leadership expectations.
3. Niche but notable: Databricks and PySpark appearing in the AT&T role ($255k — the highest salary) hints that big data processing skills are rewarded at the top end of the pay scale.
4. The "safe" skill stack to target based on this data: SQL + Python + Tableau + one cloud platform (Snowflake or AWS/Azure) covers the majority of these postings

![Top Paying Skills](assets\2_top_paying_skills.png)

3. In Demand Skills for Data Analysis
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(job_postings_fact.job_id) AS job_count
FROM   
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY
    job_count DESC
LIMIT 5
```

Here's the breakdown of the most demanded skills for data analysts in 2023:
SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

![Top Demanding Skills](assets\3_top_demanding_skills.png)
Table of the demand for the top 5 skills in data analyst job postings.

4. Skill based on salary

Exploring the average salaries of different skills which revealed skills with highest pay.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM   
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY
    average_salary DESC
LIMIT 25;
```
1. SVN is a massive outlier. At $400k average, it's more than double the next skill (Solidity at $179k). This is almost certainly a small sample size effect — very few job postings require SVN in 2023, so one or two high-comp roles skew the average dramatically. It shouldn't be taken as a reliable signal.
2. AI/ML skills cluster strongly in the $120k–$155k range. PyTorch, Keras, TensorFlow, Hugging Face, MXNet, and DataRobot all land here, forming a dense band. The consistency of this cluster suggests AI skills carry a real and predictable salary premium for data analysts.
3. DevOps/Infra tools pay surprisingly well. Terraform, VMware, Puppet, Ansible, and GitLab all appear — these are not typical "data analyst" skills, which suggests that analysts who can operate in infrastructure-heavy or platform engineering environments command a significant premium.
4. Niche languages beat mainstream ones. Solidity (blockchain), Golang, and Perl all outpay more common languages like Python or SQL, which don't appear on this list at all. The lesson: rare language skills carry a scarcity premium even in analyst roles.
5. Data engineering tools are the baseline floor. Kafka, Cassandra, Airflow, and Scala all sit in the $115k–$130k range — respectable, but at the lower end of this top-25 list, suggesting they're becoming more expected than exceptional.
6. The practical takeaway: If maximising salary is the goal, pairing core analyst skills with AI/ML frameworks or DevOps tooling appears to be the highest-leverage move in the 2023 market.

![Average Salary For Skill](assets\4_average_salary_for_skill.png)

5. Most Optimal Skills

Combining insights for demand and salary data,this query aimed to pinpoint skills that are both in high demand and high average salary.
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
table for most optimal skills based on demand and salary

Here's the breakdown:

1. Specialized ML/AI skills pay the most — Kafka ($130k), PyTorch ($125k), and TensorFlow ($121k) top the salary chart but have lower demand, making them niche but lucrative.
2. Cloud & Big Data skills are most in demand — Snowflake (241), Spark (187), and Hadoop (140) have the highest job counts, offering the best balance of availability and solid pay (~$110–113k).
3. High salary and high demand rarely overlap — the top-paying skills aren't always the most requested, so the sweet spot lies in tools like Spark and Snowflake that score well on both.

![Most Optimal Skills](assets\5_optimal_skills.png)

# What I learned

 1. Advanced Query Building: Gained hands-on experience writing complex SQL, joining multiple tables and using WITH clauses (CTEs) to break down large problems into clean and manageable steps.
 2. Data Aggregation Mastery: Leveraged GROUP BY alongside COUNT() and AVG() to transform raw job data into meaningful summaries and comparisons.
 3. Turning Questions into Insights: Sharpened analytical thinking by framing real-world questions about the job market and translating them into precise, result-driven SQL queries.

# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it's a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable in sights into the jobmarket landscape. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring professionals can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends across the ever-evolving tech industry.
