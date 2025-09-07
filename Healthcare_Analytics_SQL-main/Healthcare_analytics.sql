SELECT * from healthcare_dataset;

-- Describe the table
DESC healthcare_dataset;

-- Counting Total Record in Database
SELECT count(*) 
from healthcare_dataset;

-- Finding maximum age of patient admitted
SELECT max(age) as Maximum_Age 
from healthcare_dataset;

-- Finding Average age of hospitalized patients
SELECT round(avg(Age),0)as Average_Age 
from healthcare_dataset;

-- Calculating Patients Hospitalized Age-wise from Maximum to Minimum
SELECT age, count(age) as Total
from healthcare_dataset
GROUP BY Age
ORDER BY Age Desc;

-- Ranking Age on the number of patients Hospitalized
SELECT Age, Count(Age) as Total, 
DENSE_RANK() OVER(ORDER BY Count(Age) Asc) as Ranking
from healthcare_dataset
GROUP BY AGE;

-- Finding Count of Medical Condition of patients and lisitng it by maximum no of patients.
SELECT Medical_Condition, Count(Medical_Condition) as Total_Condition
from healthcare_dataset
GROUP BY Medical_Condition
ORDER BY Total_Condition Desc;

-- Finding Rank & Maximum number of medicines recommended to patients based on Medical Condition pertaining to them.
SELECT Medical_Condition, Medication, COUNT(Medication) AS Total_Medicine, RANK() OVER(PARTITION BY Medical_Condition ORDER BY COUNT( Medication) Desc) AS Ranking_Medicine
from healthcare_dataset
GROUP BY 1,2
ORDER BY 1;

-- Most preffered Insurance Provide  by Patients Hospatilized
SELECT Insurance_Provider, COUNT(Insurance_Provider) as Total_Insurance
from healthcare_dataset
GROUP BY 1
ORDER BY 2;

-- Finding out most preffered Hospital
SELECT Hospital, COUNT(Hospital) as Total_Hospital
from healthcare_dataset
GROUP BY 1
ORDER BY 2 Desc;

-- Identifying Average Billing Amount by Medical Condition.
SELECT Medical_Condition, round(avg(Billing_Amount), 2) as Avg_Amount
from healthcare_dataset
GROUP BY 1
ORDER BY 2;

-- Finding Billing Amount of patients admitted and number of days spent in respective hospital.
SELECT Name, Medical_Condition, round(Billing_Amount,0) as Bill, datediff(Discharge_Date, Date_of_Admission) AS Total_Days
from healthcare_dataset;

-- Finding Hospitals which were successful in discharging patients after having test results as 'Normal' with count of days taken to get results to Normal
SELECT Name, Medical_Condition, Hospital, datediff(Discharge_Date, Date_of_Admission) AS Total_Days
FROM healthcare_dataset
WHERE Test_Results = 'Normal';

-- Calculate number of blood types of patients which lies between age 20 to 45
SELECT Blood_Type, count(Blood_Type)
from healthcare_dataset
WHERE Age between 20 and 45
GROUP BY 1
ORDER BY 2;

-- Provide a list of hospitals along with the count of patients admitted in the year 2024 AND 2025
SELECT DISTINCT Hospital, COUNT(*) AS Patience_Count
from healthcare_dataset
WHERE YEAR(Date_of_Admission) BETWEEN 2024 AND 2025
GROUP BY 1;

--   Find the average, minimum and maximum billing amount for each insurance provider?
SELECT Insurance_Provider, ROUND(avg(Billing_Amount),0) as Avg_Amount, ROUND(min(Billing_Amount),0) as Min_Amount, 
ROUND(max(Billing_Amount),0) as Max_Amount
from healthcare_dataset
GROUP BY 1
ORDER BY 1;

-- Create a new column that categorizes patients as high, medium, or low risk based on their medical condition.
SELECT Name, Medical_Condition,
CASE WHEN Test_Results = 'Inconclusive' then 'Need more Test'
	 WHEN Test_Results = 'Normal' then 'Can Discharge'
     WHEN Test_Results = 'Abnormal' then 'Need more attention'
     END AS 'Status', Hospital
from healthcare_dataset;

-- Find how many of patient are Universal Blood Donor and Universal Blood reciever
SELECT DISTINCT (SELECT count(Blood_Type) from healthcare_dataset WHERE Blood_Type = 'O-') AS Universal_Donor,
(SELECT count(Blood_Type) from healthcare_dataset WHERE Blood_Type = 'AB+') AS Universal_Recipient
from healthcare_dataset;