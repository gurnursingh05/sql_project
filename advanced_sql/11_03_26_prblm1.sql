/*
Find the companies that have the most job openings.
Get the total number of job postings per company id
Return the total number of jobs  with the company  name
*/
WITH job_postings AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM 
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    name AS company_name,
    total_jobs
FROM company_dim
LEFT JOIN job_postings ON company_dim.company_id = job_postings.company_id
ORDER BY 
    total_jobs DESC