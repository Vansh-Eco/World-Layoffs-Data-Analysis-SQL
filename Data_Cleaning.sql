-- Data Cleaning

use world_layoffs;

select * from layoffs_dataset;


-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank values
-- 4. Remove any columns


create table layoffs_staging
like layoffs_dataset;
-- this will copy same table format from "layoffs_dataset" to "layoffs_staging"

select * from layoffs_staging;

insert layoffs_staging
select * 
from layoffs_dataset;
-- this will insert all the data from layoffs_dataset

select * from layoffs_staging;
-- we make this "Staging" data because if we make any mistake while working our main data does not effect.


-- DATA CLEANING

Select *,
ROW_NUMBER() OVER(
PARTITION BY 
company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

with duplicate_cte AS
(
Select *,
ROW_NUMBER() OVER(
PARTITION BY 
company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) 
AS row_num
from layoffs_staging

)
select *
from duplicate_cte
where row_num > 1;
-- now we can see which column has the duplicate

select *
from layoffs_staging
where company = 'casper'; -- We can see the duplicate for a particular company


-- For DELETING DUPLICATE 

Select *,
ROW_NUMBER() OVER(
PARTITION BY 
company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

with duplicate_cte AS
(
Select *,
ROW_NUMBER() OVER(
PARTITION BY 
company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) 
AS row_num
from layoffs_staging

)
DELETE
from duplicate_cte
where row_num > 1;



CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * from layoffs_staging2;

Insert into layoffs_staging2
Select *,
ROW_NUMBER() OVER(
PARTITION BY 
company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) 
AS row_num
from layoffs_staging;

select * 
from layoffs_staging2
where row_num > 1;

delete
from layoffs_staging2
where row_num > 1;

select * 
from layoffs_staging2;



-- DUPLICATE REMOVAL COMPLETE 

-- STANDARDIZING DATA

select company, TRIM(company)
from layoffs_staging2;

update layoffs_staging2
SET company = trim(company);

select distinct industry
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select *
from layoffs_staging2
where industry like 'Crypto%';

select distinct industry
from layoffs_staging2;

select distinct location
from layoffs_staging2
order by 1;

select distinct country
from layoffs_staging2
order by 1;

select *
from layoffs_staging2
where country like 'United States%'
order by 1;

select distinct country, trim(TRAILING "." FROM country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(TRAILING "." FROM country)
where country like 'United States%';

select * from layoffs_staging2;

select `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select `date`
from layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY column `date` DATE;

select * 
from layoffs_staging2;


-- Null Values or Blank values


select *
from layoffs_staging2
where 
total_laid_off is NULL
and 
percentage_laid_off is NULL;

update layoffs_staging2
set industry = null
where industry = '';

select *
from layoffs_staging2
where industry is NULL
or industry = '';

select *
from layoffs_staging2
where company = 'Airbnb';

select t1.industry, t2.industry
from layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

select *
from layoffs_staging2
where company = 'Airbnb';

select *
from layoffs_staging2
where company like 'bally%';

select *
from layoffs_staging2;

select *
from layoffs_staging2 
where total_laid_off is null
and percentage_laid_off is null;


-- REMOVES ANY COLUMNS OR DATA


DELETE 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

ALTER table layoffs_staging2
drop column row_num; -- No need

select * 
from layoffs_staging2;
