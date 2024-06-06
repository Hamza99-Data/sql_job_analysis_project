
--what are the most in demand skills for my role as a data anylst?

SELECT
    skills,
    COUNT(SJD.skill_id) AS skills_count
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id =sd.skill_id
WHERE 
    jpf.job_title_short ='Data Analyst' AND 
    jpf.job_location ='New York, NY' AND 
    jpf.job_work_from_home ='false'
GROUP BY
    skills
ORDER BY 
    skills_count DESC
LIMIT 5;