/* 1. Count & Percentage of F vs M that have OCD & --Average Obsession Score by Gender*/
with data as (
SELECT
Gender,
count('Patient ID') as patient_count,
round(Avg(`Y-BOCS Score (Obsessions)`),2)as avg_obs_score
FROM yt_data.ocd_patient_dataset
group by 1
order by 2
)
Select 
	sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
	sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

	round(sum(case when Gender = 'Female' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end))*100,2)
as pct_female,

round(sum(case when Gender = 'Male' then patient_count else 0 end)/
	(sum(case when Gender = 'Male' then patient_count else 0 end)+sum(case when Gender = 'Female' then patient_count else 0 end))*100,2)
as pct_Male
from data;

/* 2. Count of Patient by Ethnicity and their respective Average Obsession Score */

Select 
	Ethnicity,
	count('Patient ID') as patient_count,
	avg(`Y-BOCS Score (Obsessions)`) as obs_score
	from yt_data.ocd_patient_dataset
group by 1
order by 2 ;

/* 3. Number of people diagnosed with OCD MoM */
alter table yt_data.ocd_patient_dataset
modify `OCD Diagnosis Date` date;
select
date_format(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
count('Patient ID') patient_count
from yt_data.ocd_patient_dataset
group by 1
order by 1;

/* 4. What is the most common Obsession Type (Count) & it's respective Average Obsession Score */
select
`Obsession Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from yt_data.ocd_patient_dataset
group by 1
order by 2;

/* 5. What is the most Compulsion type (Count) & its respective Average Obsession Score */
SELECT
`Compulsion Type`,
count('Patient ID') as patient_count,
round(Avg(`Y-BOCS Score (Obsessions)`),2)as avg_obs_score
FROM yt_data.ocd_patient_dataset
group by 1
order by 2;

