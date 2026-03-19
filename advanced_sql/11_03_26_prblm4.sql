/*
Get the corresponding skill and skill type for each job posting in Q1, including those without any skills.
 Look at the skills and the type for each job in the first quarter that has a salary greater than $70,000
*/

SELECT 
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type,
    salary_year_avg,
    job_posted_date
FROM 
    january_jobs
    LEFT JOIN skills_job_dim ON january_jobs.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    january_jobs.salary_year_avg > 70000

UNION

SELECT 
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type,
    salary_year_avg,
    job_posted_date
FROM 
    feb_jobs
    LEFT JOIN skills_job_dim ON feb_jobs.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    feb_jobs.salary_year_avg > 70000

UNION

SELECT 
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type,
    salary_year_avg,
    job_posted_date
FROM 
    march_jobs
    LEFT JOIN skills_job_dim ON march_jobs.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    march_jobs.salary_year_avg > 70000
