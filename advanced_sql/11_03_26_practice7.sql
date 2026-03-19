/*
    Find the count of the numebr of remote jobs postings per skill
    -Display the top 5 skills by there demand in remote jobs
    -Icnlude Skills ID, name , and count of postings requiring the skill
*/
WITH remote_job_skills AS (
    SELECT 
        COUNT(job_postings_fact.job_id) AS remote_jobs,
        skills_job_dim.skill_id
    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
    WHERE
        job_location = 'Anywhere' AND job_title_short = 'Data Analyst'
    GROUP BY
        skills_job_dim.skill_id
)

SELECT 
    skills_dim.skill_id,
    skills_dim.skills AS skill_name,_
    remote_job_skills.remote_jobs
FROM   
    remote_job_skills
    INNER JOIN skills_dim ON remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY
    remote_jobs DESC
LIMIT 5;