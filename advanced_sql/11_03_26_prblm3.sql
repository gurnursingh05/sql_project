/*
Determine the size category ('Small', 'Medium', or 'Large') for each company based on number of job postings. 
Small = less than 10, Medium = between 10 and 50, Large = more than 50. Use a subquery to aggregate job counts per company before classifying them.
*/

SELECT
    name AS company_name,
    
    CASE 
        WHEN COUNT(*) < 10 THEN 'Small'
        WHEN COUNT(*) BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size_category
FROM 
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
GROUP BY
     name



