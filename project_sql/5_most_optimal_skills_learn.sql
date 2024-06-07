

--What are the optimal skills? i.e those with high demands and high salaries.

SELECT 
    sd.skill_id,
    COUNT(jpf.job_id) AS tot_jobs,
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg), 2) AS average_sal
FROM
    job_postings_fact jpf
JOIN  skills_job_dim sjd ON jpf.job_id = sjd.job_id
JOIN  skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short ='Data Engineer' AND 
    jpf.job_work_from_home ='true'AND
    jpf.salary_year_avg IS NOT NULL 
GROUP BY 
    sd.skill_id
HAVING 
    COUNT(jpf.job_id) >10
ORDER BY 
    average_sal DESC,
    tot_jobs DESC
LIMIT 10;