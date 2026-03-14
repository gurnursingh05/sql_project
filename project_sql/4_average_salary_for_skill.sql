/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or improve
*/


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

/*
SVN is a massive outlier. At $400k average, it's more than double the next skill (Solidity at $179k). This is almost certainly a small sample size effect — very few job postings require SVN in 2023, so one or two high-comp roles skew the average dramatically. It shouldn't be taken as a reliable signal.
AI/ML skills cluster strongly in the $120k–$155k range. PyTorch, Keras, TensorFlow, Hugging Face, MXNet, and DataRobot all land here, forming a dense band. The consistency of this cluster suggests AI skills carry a real and predictable salary premium for data analysts.
DevOps/Infra tools pay surprisingly well. Terraform, VMware, Puppet, Ansible, and GitLab all appear — these are not typical "data analyst" skills, which suggests that analysts who can operate in infrastructure-heavy or platform engineering environments command a significant premium.
Niche languages beat mainstream ones. Solidity (blockchain), Golang, and Perl all outpay more common languages like Python or SQL, which don't appear on this list at all. The lesson: rare language skills carry a scarcity premium even in analyst roles.
Data engineering tools are the baseline floor. Kafka, Cassandra, Airflow, and Scala all sit in the $115k–$130k range — respectable, but at the lower end of this top-25 list, suggesting they're becoming more expected than exceptional.
The practical takeaway: If maximising salary is the goal, pairing core analyst skills with AI/ML frameworks or DevOps tooling appears to be the highest-leverage move in the 2023 market
*/