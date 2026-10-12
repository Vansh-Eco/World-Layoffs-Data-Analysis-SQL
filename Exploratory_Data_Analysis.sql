-- Exploratory Data Analysis

use world_layoffs;

Select * 
from layoffs_staging2;

Select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

Select * 
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

Select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

Select min(`date`), max(`date`)
from layoffs_staging2;

Select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

Select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

Select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

Select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

Select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc; -- not in use as much
-- Till now I am just analyzing the data what is in the data

-- ROLLING TOTAL LAY OFFS
select substring(`date`,1,7) as `MONTH`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 asc
;

with Rolling_total as 
(
select substring(`date`,1,7) as `MONTH`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1 asc
)
select `month`, Total_off
,sum(total_off) over(order by `month`) as rolling_total
from Rolling_total;


Select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

Select company, year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company, YEAR(`date`)
order by 3 desc;

with Company_Year (Company, years, total_laid_off) as
(
Select company, Year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, Year(`date`)
),
Company_Year_Rank as
(select *, 
dense_rank() OVER(partition by years order by total_laid_off desc) as Ranking
from Company_Year
where years is not null
)
select *
from Company_Year_Rank
where Ranking  <= 5
;