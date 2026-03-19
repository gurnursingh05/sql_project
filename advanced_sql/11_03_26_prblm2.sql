/*
Identify the top 5 skills most frequently mentioned in job postings.
 Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table, 
 then join with the skills_dim table to get the skill names.
*/

SELECT
    skills_dim.skills,
    skill_counts.skill_count
FROM 
    skills_dim
INNER JOIN (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim
    GROUP BY 
        skill_id
    ORDER BY 
        skill_count DESC
    LIMIT 5
) AS skill_counts ON skills_dim.skill_id = skill_counts.skill_id
ORDER BY 
    skill_counts.skill_count DESC;