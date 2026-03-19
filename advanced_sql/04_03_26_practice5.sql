/*
Create three tables: Jan 2023 jobs, Feb 2023 jobs, and Mar 2023 jobs. 
Use CREATE TABLE table_name AS syntax to create your table and use EXTRACT to filter out only specific months.
*/

CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE feb_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;


CREATE TABLE march_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;