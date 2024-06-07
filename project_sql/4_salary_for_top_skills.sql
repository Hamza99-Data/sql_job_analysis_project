
--what are the avg salary of the skills 
SELECT
    skills,
    ROUND(AVG(jpf.salary_year_avg), 2) AS avg_sal
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id =sd.skill_id
WHERE 
    jpf.job_title_short ='Data Engineer' AND 
    jpf.job_work_from_home ='true'  AND 
    jpf.salary_year_avg IS NOT NULL 
GROUP BY
    skills
ORDER BY 
   avg_sal DESC
LIMIT 10;
