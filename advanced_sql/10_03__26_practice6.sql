/*Categorize the salaries from each job posting to see if it fits in your desired salary range. 
Put salary into different buckets, 
defining what's a high, standard, or low salary with your own conditions.
 Only look at data analyst roles and order from highest to lowest salary.*/

SELECT 
    COUNT(job_id) AS job_count,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'High Salary'
        WHEN salary_year_avg >= 50000 AND salary_year_avg < 100000 THEN 'Standard Salary'
        WHEN salary_year_avg < 50000 AND salary_year_avg >=0 THEN 'Low Salary'
            ELSE 'Unknown Salary'
    END AS salary_category
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    salary_category
ORDER BY
    job_count DESC
LIMIT 10;