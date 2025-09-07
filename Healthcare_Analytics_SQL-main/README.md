# 🏥 Healthcare Data Analysis using SQL

A structured SQL-based analysis on a healthcare dataset to uncover insights into patient demographics, billing patterns, medical conditions, and hospital efficiency.

---

## 🧩 Problem

Hospitals collect large amounts of patient and treatment data, but it's rarely leveraged to improve decision-making. This project solves that by answering:

- Which age groups are hospitalized the most?
- Which hospitals are most preferred and profitable?
- What are the billing trends based on medical conditions?
- How does insurance coverage affect hospital charges?

---

## 🔎 Dataset Overview

Key columns in the dataset:

| Column             | Description                            |
|--------------------|----------------------------------------|
| Name               | Patient name                           |
| Age                | Age of the patient                     |
| Gender             | Male/Female/Other                      |
| Hospital           | Name of hospital                       |
| Medical_Condition  | Diagnosed illness                      |
| Billing_Amount     | Hospital bill                          |
| Insurance_Provider | Patient’s insurance provider           |
| Date_of_Admission  | Date admitted                          |
| Discharge_Date     | Date discharged                        |
| Test_Results       | Result of medical test                 |
| Blood_Type         | Blood group                            |
| Medication         | Medicines given                        |

---

## 📊 Key Analyses Performed

### 1. Age-wise Hospitalization Trends

```sql
SELECT age, COUNT(*) AS Total
FROM healthcare_dataset
GROUP BY age
ORDER BY age DESC;
```

### 2. 🩺 Medical Condition Insights
- Frequency of medical conditions:

```sql
SELECT Medical_Condition, COUNT(*) AS Total_Condition
FROM healthcare_dataset
GROUP BY Medical_Condition
ORDER BY Total_Condition DESC;
```

- Top medications per condition using window functions:

```sql
SELECT Medical_Condition, Medication, COUNT(*) AS Total_Medicine,
RANK() OVER(PARTITION BY Medical_Condition ORDER BY COUNT(*) DESC) AS Ranking_Medicine
FROM healthcare_dataset
GROUP BY Medical_Condition, Medication;
```

### 3. 🏥 Hospital & Insurance Preferences
- Most preferred hospitals and insurance providers:

```sql
SELECT Hospital, COUNT(*) AS Total_Hospital
FROM healthcare_dataset
GROUP BY Hospital
ORDER BY Total_Hospital DESC;
```

```sql
SELECT Insurance_Provider, COUNT(*) AS Total_Insurance
FROM healthcare_dataset
GROUP BY Insurance_Provider
ORDER BY Total_Insurance DESC;
```

### 4. 💰 Billing Insights
- Average billing amount per condition:

```sql
SELECT Medical_Condition, ROUND(AVG(Billing_Amount), 2) AS Avg_Amount
FROM healthcare_dataset
GROUP BY Medical_Condition;
Billing comparison across insurance providers:
```

```sql
SELECT Insurance_Provider,
ROUND(AVG(Billing_Amount),0) AS Avg_Amount,
ROUND(MIN(Billing_Amount),0) AS Min_Amount,
ROUND(MAX(Billing_Amount),0) AS Max_Amount
FROM healthcare_dataset
GROUP BY Insurance_Provider;
```

### 5.🛡️ Risk Categorization (CASE logic)
- Status label based on test results:

```sql
SELECT Name, Medical_Condition,
CASE 
  WHEN Test_Results = 'Inconclusive' THEN 'Need more Test'
  WHEN Test_Results = 'Normal' THEN 'Can Discharge'
  WHEN Test_Results = 'Abnormal' THEN 'Need more attention'
END AS Status,
Hospital
FROM healthcare_dataset;
```

## 🧾 Conclusion
- Most patients are in their 40s and 60s, showing age-related hospitalization trends.
- Certain medical conditions require more medications and lead to longer stays.
- O- and AB+ blood types are critical for donation/receiving strategies.
- Private hospitals dominate, both in admissions and billing amounts.
- Over 62% patients are uninsured, highlighting a need for greater coverage.
- Hospitals can reduce costs and improve treatment timelines by using these insights.

## 🛠 Tools Used
✅ SQL (MySQL) — for data querying and analysis

✅ Excel — for data preview and structuring

✅ (Optional) Python — for further analysis and visualizations

