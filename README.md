# World Layoffs Data Analysis (MySQL)

## Project Overview
This project focuses on cleaning and exploring a global layoffs dataset using MySQL. It demonstrates how SQL can be used to improve data quality, investigate layoff patterns, and summarize workforce reductions across companies, industries, countries, and years.

## Project Objectives
- Identify and remove duplicate records.
- Standardize inconsistent text values and date formats.
- Handle NULL and blank values.
- Analyze layoffs by company, industry, country, and funding stage.
- Calculate monthly rolling totals.
- Rank the top five companies by layoffs for each year.

## Tools Used
- MySQL
- MySQL Workbench
- SQL

## Repository Files
| File | Description |
|---|---|
| `Data_Cleaning.sql` | Removes duplicates, standardizes values, handles missing data, and prepares the dataset for analysis. |
| `Exploratory_Data_Analysis.sql` | Explores layoffs by company, industry, country, year, and funding stage; calculates rolling totals and yearly rankings. |
| `layoffs_dataset.csv` | Original dataset used in the project. |

## Data Cleaning Process
The data-cleaning workflow includes:
1. Creating staging tables to preserve the original dataset.
2. Identifying duplicate records using `ROW_NUMBER()` and window functions.
3. Standardizing company names, industry categories, country values, and dates.
4. Handling blank and NULL industry values.
5. Populating missing industry information using self-joins.
6. Removing records where both total layoffs and percentage laid off are missing.
7. Removing the temporary `row_num` column after duplicate removal.

## Exploratory Data Analysis
The analysis includes:
- Total layoffs by company.
- Layoffs by industry and country.
- Layoffs by funding stage.
- Yearly layoffs across the dataset.
- Monthly layoffs and cumulative rolling totals.
- Top five companies by total layoffs for each year.
- Maximum layoffs and percentage laid off.

## SQL Concepts Demonstrated
- Data Cleaning and Standardization
- Joins and Self-Joins
- Common Table Expressions (CTEs)
- Window Functions
- `ROW_NUMBER()`
- `DENSE_RANK()`
- Aggregate Functions
- `GROUP BY` and `ORDER BY`
- Date Functions
- Rolling Totals
- NULL Handling

## Key Findings
The SQL scripts investigate which companies, industries, countries, and funding stages account for the highest reported layoffs. They also examine changes over time and identify the five companies with the highest layoffs in each year.

## Project Outcome
This project demonstrates an end-to-end SQL workflow, from preparing raw data to performing exploratory analysis using MySQL.

## Author
Vansh Verma
