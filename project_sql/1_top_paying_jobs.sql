--what are the top 10 highest paying data engineers job?

SELECT 
    job_id,
    job_title_short,
    name AS company_name,
    job_schedule_type,
    salary_year_avg 
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short ='Data Engineer' AND 
    job_location ='Anywhere'AND 
    salary_year_avg IS NOT NULL 
ORDER BY 
    salary_year_avg DESC
LIMIT 10;

