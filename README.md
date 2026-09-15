# Employee Survey Analysis

## Project Overview

The dataset used for this project was obtained from Maven Analytics.
This project looks at employee survey responses to understand employee sentiment across different departments.

I first worked on the dataset in Excel. The data was cleaned and checked before carrying out the initial analysis using PivotTables.

The cleaned data was then imported into PostgreSQL for further analysis using SQL.

## Dataset

The original dataset was provided as an Excel workbook. It contained employee survey responses along with a data dictionary.

The dataset had 14725 records before cleaning.

There were 21 departments and 12 survey questions.

Employee responses were recorded on a scale from 0 to 4.

0 means Not Applicable

1 means Strongly Disagree

2 means Disagree

3 means Agree

4 means Strongly Agree

## Data Cleaning in Excel

I created a separate cleaned data sheet so that the original data remained unchanged.

I used Excel to check the data and prepare it for analysis.

The main cleaning steps were:

Removed 15 exact duplicate records.

Identified 135 incomplete responses and excluded them from the analysis.

Checked the department column for missing values.

Checked the Director Manager Supervisor and Staff fields for missing or unexpected values.

Checked the Response column to make sure it contained only valid values from 0 to 4.

Checked the Response Text values against the numerical Response values.

Found an inconsistency in Question 7 where the same question appeared with learn and grow and learn & grow. The wording was standardised to learn and grow.

Checked the Response ID values using COUNTIF to make sure every response ID was unique.

After cleaning ,the dataset contained 14575 valid survey responses.

## Excel Analysis

After cleaning the data I used PivotTables to explore the survey responses.

The main questions I looked at were:

Which department had the highest number of survey responses

Which department had the lowest number of survey responses

How many valid responses were received from each department

How were responses distributed across the 0 to 4 scale

Which department had the highest average survey response score

Which department had the highest number of Strongly Agree responses

Which department had the highest number of Strongly Disagree responses

Which five departments had the highest average response scores

Which department had the highest combined number of Agree and Strongly Agree responses

Which department had the highest percentage of Agree and Strongly Agree responses

## Key Findings from Excel

Planning and Public Works had the highest number of survey responses with 4663 responses.

Family Justice Center had the lowest number of responses with 39 responses.

The overall average survey response score was approximately 2.98.

Family Justice Center had the highest average survey response score at 3.51.

Planning and Public Works had the highest number of Strongly Agree responses with 1489 responses.

Sheriff's Department had the highest number of Strongly Disagree responses with 390 responses.

The top five departments based on average response score were Family Justice Center Emergency Management Economic Development Human Resources and Exec Office & Directors.

Planning and Public Works had the highest combined number of Agree and Strongly Agree responses with 3597 responses.

Emergency Management had the highest percentage of Agree and Strongly Agree responses at 87.23 percent.

## SQL Analysis

The cleaned dataset was further analysed in PostgreSQL using 20 business focused SQL questions.

The analysis covered basic aggregation conditional logic subqueries CTEs and window functions.

The complete SQL queries are available in the employee_survey_analysis.sql file.

## Tools Used

Microsoft Excel

PostgreSQL

SQL

## Project Outcome

This project helped me practise working with a real world employee survey dataset from data cleaning through exploratory analysis and SQL analysis.

The main focus was to use data to answer practical business questions and identify differences in employee sentiment across departments.
