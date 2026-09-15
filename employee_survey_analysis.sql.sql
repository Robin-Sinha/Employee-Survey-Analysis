CREATE TABLE employee_survey (
    response_id INTEGER PRIMARY KEY,
    department VARCHAR(100),
    director SMALLINT,
    manager SMALLINT,
    supervisor SMALLINT,
    staff SMALLINT,
    question TEXT,
    response SMALLINT
);
select count(*)
from employee_survey ;

SELECT *
FROM employee_survey
LIMIT 10;


--Q1.Which department has the highest number of survey responses?
SELECT department, COUNT(response) AS response_count
FROM employee_survey
GROUP BY department
ORDER BY response_count DESC
LIMIT 1;

--Q2.Which department has the lowest number of survey responses?
SELECT department, COUNT(response) AS response_count
FROM employee_survey
GROUP BY department
ORDER BY response_count asc
LIMIT 1;

--Q3.What is the total number of valid survey responses in the dataset?
select count(response )
from employee_survey;

--Q4.What is the distribution of survey responses (0–4) across all employees?
select response ,count(*)
from employee_survey
group by response ;

--q5.Which department has the highest average survey response score?
select department,avg(response ) as avg_survey_response
from employee_survey
group by department 
order by avg_survey_response desc
limit 1 ;

--Q6. Which department has the highest number of Strongly Agree (response = 4) responses?
select department,count(response )as max_response 
from employee_survey
where response = 4
group by department 
order by max_response desc
limit 1;
--Q7.Which department has the highest number of Strongly Disagree (response = 1) responses?

select department,count(response )as max_response 
from employee_survey
where response = 1
group by department 
order by max_response desc
limit 1;


--Q8.Which department has the highest percentage of Strongly Agree (response = 4) responses among all its survey responses?

SELECT
    department,
    COUNT(*) FILTER (WHERE response = 4) * 100.0 / COUNT(*) AS percentage
FROM employee_survey
GROUP BY department
ORDER BY percentage DESC
LIMIT 1;

--Q9:--Which department has the highest average response score for the survey question:

--“This last year, I have had opportunities at work to learn and grow”

select 
department,question,
avg(response) as highest_average_response_score
from employee_survey
WHERE question = '7. This last year, I have had opportunities at work to learn and grow'
group by department,question
order by highest_average_response_score desc
limit 1 ;

--Q10.Q10:

--Which department has the highest average response score for the survey question:

--“10. Overall I am satisfied with my job”
select 
department,question,
round(avg(response),2) as highest_average_response_score
from employee_survey
WHERE question = '10. Overall I am satisfied with my job'
group by department,question
order by highest_average_response_score desc
limit 1 ;

--Q11 — Subquery
--Which departments have an average survey response score higher than the overall average response score across all departments?

SELECT department,ROUND(AVG(response), 2)
FROM employee_survey
GROUP BY department
HAVING AVG(response) > (SELECT AVG(response)
FROM employee_survey);

SELECT AVG(response)
FROM employee_survey;


--Q12 — CTE (WITH)
--Which department has the highest number of positive survey responses, where a positive response means Agree (3) or
--Strongly Agree (4)?
WITH positive_responses AS (
    SELECT
        department,
        COUNT(*) AS positive_response_count
    FROM employee_survey
    WHERE response IN (3, 4)
    GROUP BY department
)
SELECT
    department,
    positive_response_count
FROM positive_responses
ORDER BY positive_response_count DESC
LIMIT 1;

--Q13 — CASE WHEN + Aggregation
--For each department, how many survey responses are Positive, Neutral, and Negative?
SELECT
    department,
    COUNT(CASE
        WHEN response IN (3, 4) THEN 1
    END) AS positive_responses,
    
    COUNT(CASE
        WHEN response = 2 THEN 1
    END) AS neutral_responses,
    
    COUNT(CASE
        WHEN response IN (0, 1) THEN 1
    END) AS negative_responses

FROM employee_survey
GROUP BY department
ORDER BY department;

--Q 14.Across the entire organisation, what is the distribution of employee responses by category
-- Positive, Neutral, and Negative?
SELECT
    CASE
        WHEN response IN (3, 4) THEN 'Positive'
        WHEN response = 2 THEN 'Neutral'
        WHEN response IN (0, 1) THEN 'Negative'
    END AS response_category,
    COUNT(*) AS response_count
FROM employee_survey
GROUP BY response_category
ORDER BY response_count DESC;

--Q15 — Window Function: RANK()
--Rank all departments based on their average survey response score, from highest to lowest.
SELECT
    department,
    ROUND(AVG(response), 2) AS average_survey_response,
    RANK() OVER (ORDER BY AVG(response) DESC) AS department_rank
FROM employee_survey
GROUP BY department
ORDER BY department_rank;

--Q16 — Window Function: PARTITION BY
--For each department, identify the survey question that received the highest average response score.

select *from(SELECT
    department,
    question,
	ROUND(AVG(response), 2) AS average_survey_response,
	rank()over (partition by department order by avg(response)desc) as question_rank
    FROM employee_survey
GROUP BY department, question)ranked_question
where question_rank=1 ;

--Q17 — ROW_NUMBER() + PARTITION BY
--For each department, identify the single highest-rated survey question, ensuring that only one question is selected per department.
select * from
(SELECT
    department,
    question,
	ROUND(AVG(response), 2) AS average_survey_response,
	row_number()over (partition by department order by avg(response)desc) as question_row_number
    FROM employee_survey
GROUP BY department, question)ranked_question
where question_row_number=1 ;

--Q18 
--Which departments have the top 3 highest average survey response scores, while allowing departments with tied scores to share
--the same rank?
SELECT *
FROM (
    SELECT
        department,
        ROUND(AVG(response), 2) AS average_survey_response,
        DENSE_RANK() OVER (
            ORDER BY AVG(response) DESC
        ) AS department_rank
    FROM employee_survey
    GROUP BY department
) ranked_department
WHERE department_rank <= 3
ORDER BY department_rank;

--Q19
--For each department, calculate the percentage of employees who gave a Positive response (Agree = 3 or Strongly Agree = 4). 
--Then rank the departments from highest to lowest based on this positive-response percentage.
SELECT *
FROM (
    SELECT
        department,
        COUNT(*) AS total_responses,

        COUNT(
            CASE
                WHEN response IN (3, 4) THEN 1
            END
        ) AS positive_responses,

        ROUND(
            COUNT(CASE WHEN response IN (3, 4) THEN 1 END) * 100.0
            / COUNT(*),
            2
        ) AS positive_response_percentage,

        RANK() OVER (
            ORDER BY
                COUNT(CASE WHEN response IN (3, 4) THEN 1 END) * 100.0
                / COUNT(*) DESC
        ) AS department_rank

    FROM employee_survey
    GROUP BY department
) ranked_departments
ORDER BY department_rank;

--Q20.Identify the survey question that has the highest percentage of Positive responses (Agree = 3 or Strongly Agree = 4) 
--across the entire organisation.
select question,count(*)as total,count(case when response in (3,4)then 1 end)as positive_response ,
 ROUND(
            COUNT(CASE WHEN response IN (3, 4) THEN 1 END) * 100.0
            / COUNT(*),
            2
        ) AS positive_response_percentage

from employee_survey
group by question
order by positive_response_percentage desc
limit 1;

