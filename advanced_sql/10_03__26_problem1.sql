/*
SUBQUERY EXAMPLE: Find all companies that have job postings mentioning "no degree required".
*/
SELECT
    company_id,
    company_dim.name AS name
FROM
    company_dim
WHERE 
    company_id IN ( 
        SELECT 
            company_id
        FROM
            job_postings_fact
        WHERE 
            job_no_degree_mention = 'TRUE'
    );
