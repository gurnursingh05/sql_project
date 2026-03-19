SELECT 
    skills_job_dim.job_id,
    salary_year_avg,
    job_country,
    job_title_short,
    skills
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_country = 'India' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
