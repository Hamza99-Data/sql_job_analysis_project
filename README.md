# Introduction
As a young  **data engineer**, I'm on a journey to research into the data analytics market to identify the jobs that offers a much higher compensation and also determine the skills that are mostly demanded by these high paying jobs so that I can focus on acquiring those skills.

Following through Luke Barousse SQL for data analytics course, I hope to learn new things in using sql to retrieve and modify data from a database.

Please check out all the sql queries used in this project via this link: [project.sql folder](/project_sql/)

# Background
with a stoing desire to secure data engineer role that offers higher remuneration, a research like this was necessary to provide the information I needed to navigate around the data market. 
### The following are the key objectives that I lay out for this projects:
* To identify the 10 highest paying data engineer jobs.
* To identify the skills associated with these highest paying jobs.
* To determine the most in-demand skills for data engineers.
* To find the skills associated with higher salaries.
* to identify the most optimal skills to focus on as a data engineer.

# Tools used in this project
To enable me achieve the objectives for this project, I employed the use of these tools:

* ***SQL**: The main tool of my analysis, presenting me with all the tools to query and retrieve all the vital details form the database.

* **PostgreSQL**: The database management system, robust in handling the huge job postings data.

* **Visual Studio Code**: My favourite code editor for executing sql queries.

* **Git & GitHub**: To help me share this project and it's analysis, and also keep a track of all changes.

# The analysis
Each objective of this project require a specific query to investigate the data analystics job markets. In the next couple of lines, I present each objective along with the sql queries I used and with an alnalysis of the result sets.
 ### 1. The top 10 highest paying data engineer jobs
 To find out the top 10 highest paying data engineer jobs, I filtered out data engineers jobs by average yearly salary and the job locations with a focus on remote jobs. The query below produced the desired results:

```sql
SELECT 
    job_id,
    job_title,
    job_posted_date,
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
```

#### Here's a breakdown of above query results:
1. **Attractive salaries:** the top 10 highest paying data engineer remote jobs has salaries ranging from USD242,000 to USD325,000. indicating closely related salaries and significant fairness in salary structures.
2. **Mostly Full-time jobs**: all the top 10 highest paying jobs are scheduled as full time jobs,  given me an insghts on the need to put in appropriate time management skills.
3. **Timeframe of job postings:** 7 out of the top 10 paying jobs were posted in first quarter of 2023, indicating that much efforts should be pu in place during the first quarter of the year in order to secure such jobs.

### 2. Top skills for the top paying jobs
To discover the important skills associated with the top paying jobs, job postings and skills tables were joined together, providing the opportunity to understand what skills are of high value to employers.
 below is the sql query for the above task:

```sql
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        name AS company_name,
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
        LIMIT 10
    )

SELECT 
    tpj.*,
    sd.skills
FROM
    top_paying_jobs tpj

INNER JOIN  skills_job_dim SJd ON tpj.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
ORDER BY
    tpj.salary_year_avg DESC;
```
    
#### Here's a look into the most in demand skills.

* **Python**-having a count of 5.

* **Spark** matching python with same count of 5.

* **Hadoop and Kafta** also made it to the list with a count of 3 each. other notable skills include **scala**, n**umpy**, **panda**s, and **pyapark**, all having a count of 2.

### 3. The most in-demand skills for data engineers

This query below retrieve the top 5 most skills sought after in jobs relating to data engineers.

```sql
  SELECT
    skills,
    COUNT(SJD.skill_id) AS skills_count
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id =sd.skill_id
WHERE 
    jpf.job_title_short ='Data Engineer' AND 
    jpf.job_work_from_home ='true'
GROUP BY
    skills
ORDER BY 
    skills_count DESC
LIMIT 5;

```

#### Here are a breakdown of the findings:
*  **SQL** tops the list with a count of 144,213 indicating the need to acquire foundational skills in storing and processing information in a relational database.
*  **Python** follows sql with a count of 13,893 echoeing the importance of programming langauges in data engineering, particularly the python language.

* **Cloud service::** like **aws** and **azure** making it to the list indicate the growing demands for skills in cloud computing for data management.
Table ---- represent the top 5 in-demand skills for data engineers.

**Table 1**: Demand count for the top 5 skills for data engineers.


| skill s|skills_count|
| --- | --- |
| sql       |114213    |
|python     |13893    |
| aws       |8570    |
| azure    |6997    |
|spark     |6612     |

### 4. The skills asscociated with higher salaries
Below query identifies the top 10 skills with the highest average salaries.

```sql
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
```

#### Here's a breakdown of the results of the top 10 skills that command higher salries:
* **High level languages and machine learning skills**: top salaries are commanded by the ability to translate high-level languages into machine languages. 
* **Documentation, Extractionl, and Reporting***: the presence of **mongo**,**ggplot2**, and **perl** demonstrate a requireme0nt for document-oriented programming, text processing, and report language techniques.
The table below presents the average salaries top 10 skills.

Table 2: Average salaries for the top 10 highest paying data engineers job.

|skills     |Average salary($) |
| --  | --- |
|assembly   | 192500.00    |
|clojure     | 170866.50    |
|ggplot2     |176250.00     |
|graphql     |162546.88     |
|julia       |160500.00     |
|mongo       |182222.81     |
|neo4j       |166559.44|     |
|perl        |169000.00     |
|rust        |172819.17     |
|solidity    |166250.00     |

### 5. Most Optimal skills
This objective combine results from skills demand and salary data to identify skills that are both in high demand and have higher salaries for data engineers.

```sql
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
    jpf.job_title_short ='Data Analyst' AND 
    jpf.job_work_from_home ='true'AND
    jpf.salary_year_avg IS NOT NULL 
GROUP BY 
    sd.skill_id
HAVING 
    COUNT(jpf.job_id) >10
ORDER BY 
    average_sal DESC,
    tot_jobs DESC;
```

#### Breakdown of findings:

Table 3 present a preview of the optimal skills for data engineers.

Table 3: Most optimal skills for data engineers filtered by salary.

| skill ID    |Demand count     |skills name     |average salary($) 
| --- | --- | --- | --- |
|213    |56     |kubernetes | 158189.73 |
|94     |14     |numpy     |157592.32   |
|63     |19     |cassandra |151282.18   |
|98     |134    |kafka     |150549.04   |
|27     |11     |golang    |147818.18   |
|212    |44     |terraform |146057.28   |
|93     |38     |pandas    |144656.21   |
|59     |21     |elasticsearch|144101.93 |
|30     |14     |ruby     |144000.00     |
|144    |14     |ruby     |144000.00     |


## Lessons learnt
This project presented a superb opportunity to learn new commands, troubleshooting codes, and version controls. 
* **Problem solving skills**: the project presented numerous thinkthrough situations where I had to analyze the objectives and come out with queries that provide a reliable solution.
* **Simplification of quries** I have gain a great deal of knowledge on how to simplify complex queries and at same time eliminating errors, and enhancing readability.
* **Documentation**: mastered the art of documenting and presenting my project work in a more professional manner.


# Conclusions
The following conclusions can be drawn based on the analysis presented in this document:
1. **Top rewarding data engineer jobs:**  The 10 highest paying data engineers jobs are closely related with the highest at USD325,000.
2. ***Top paying job skill:*** Python and Spark led the list, indicating they are critical skills for earning a high salary in the data market.
3. ***Most In-demand skills:*** SQL is the most in-demand skill for data engineers, making it a must have to succeed in the data market.
4. ***Kills with highest salaries:*** specialized skills such as assembly and numpy are the most commanding skills in terms of higher rewards.
5. ***Optimal skills to learn:** kubernetes leads in demand and offers high average salary. 