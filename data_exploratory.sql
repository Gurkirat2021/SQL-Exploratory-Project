-- Data Exploratory Analysis on staging_layoffs2
select * from staging_layoffs3;

-- checking how big these layoffs were

select max(total_laid_off), max(percentage_laid_off) 
from staging_layoffs3;

select max(total_laid_off), max(percentage_laid_off) 
from staging_layoffs3
where percentage_laid_off is not null;

select max(total_laid_off), min(percentage_laid_off) 
from staging_layoffs3
where total_laid_off is not null;

-- which companies had 100 percent layoff (where value is equal to 1) order by total_laid_off in DESC
select  *  from staging_layoffs3
where percentage_laid_off = 1 
order by total_laid_off DESC;


-- which company has raised maximum fund
select  *  from staging_layoffs3
where percentage_laid_off = 1 
order by funds_raised_millions DESC;


-- checking for company amazon
select company, location, total_laid_off from staging_layoffs3
where company = 'Amazon';
 
-- sum of the total laid off per company
select  company , sum(total_laid_off) from staging_layoffs3
group by company
order by 2 DESC;

-- find the layoffs dates max and min
select min(`date`),max(`date`) from staging_layoffs3;

-- which industry hit hard in terms of lay offs
select industry, sum(total_laid_off) from staging_layoffs3
group by industry
order by 2 DESC;


-- maximim hit by company and industry
select company,industry, sum(total_laid_off) from staging_layoffs3
group by company, industry
order by 3 DESC;

--  countries that hit the hardest 
select country , sum(total_laid_off) from staging_layoffs3
group by country
order by 2 DESC;

-- look by date, year worst year of laidoffs
select year(`date`) as year , sum(total_laid_off)  from staging_layoffs3
group by year
order by 1 DESC;

-- look by stage
select stage, sum(total_laid_off) from staging_layoffs3
group by stage
order by 2 DESC ;


select company, stage, sum(total_laid_off) from staging_layoffs3
group by company,stage
order by 3 DESC;


select company, sum(total_laid_off) from staging_layoffs3
group by company
order by 2 DESC;

-- find which month and year has most layoffs
select substr(`date`,6,2) as `month`,
 substr(`date`,1,4) as `year` , sum(total_laid_off)
 from staging_layoffs3
 group by `month`, `year`
 order by `month`, `year`;
 
 
select substr(`date`,1,7) as `year_month`, 
 sum(total_laid_off)
 from staging_layoffs3
where substr(`date`,1,7) is not null
  group by `year_month`
 order by 1 ASC;
 
 
 
 select company, location, `date`, total_laid_off from staging_layoffs3
 where `date`  is null;
 
 
 -- creating CTE for finding total layoffs month by month. showing each month's layoff and rolling down to the end of 2023
 with Rolling_Total as
 (
 select substr(`date`,1,7) as `year_month`, 
 sum(total_laid_off) as total_off
 from staging_layoffs3
 where substr(`date`,1,7) is not null
 group by `year_month`
 order by 1 ASC
 )
 select `year_month` , total_off, sum(total_off) over(order by `year_month`) as rolling_total
 from Rolling_Total;
 
 select  company , sum(total_laid_off) from staging_layoffs3
group by company
order by 2 DESC;

--
 select  company , year(`date`),sum(total_laid_off) 
 from staging_layoffs3
group by company, year(`date`)
order by company ASC;

 select  company , year(`date`),sum(total_laid_off) 
 from staging_layoffs3
group by company, year(`date`)
order by 3 DESC;

with company_year ( company, years,total_laid_off) as 
(
 select  company , year(`date`),sum(total_laid_off) 
 from staging_layoffs3
group by company, year(`date`)
)
select * from company_year;

-- who laid off most people in partition by years
-- this query will show the rank 1 for all years first and then so on..
with company_year ( company, years,total_laid_off) as 
(
 select  company , year(`date`),sum(total_laid_off) 
 from staging_layoffs3
group by company, year(`date`)
)
select * , dense_rank() over(partition by years order by total_laid_off DESC) as ranking
from company_year
where years is not null
order by ranking ASC;

-- this query will show the company rank year by year (like  for 2020 -all company ranks first then followed by 2021,2022,2023 )

with company_year ( company, years,total_laid_off) as 
(
 select  company , year(`date`),sum(total_laid_off) 
 from staging_layoffs3
group by company, year(`date`)
), company_year_rank as     -- another CTE
(
select * , 
dense_rank() over(partition by years order by total_laid_off DESC) as ranking
from company_year
where years is not null
)
select * from company_year_rank
where ranking <= 5;



with industry_year_ranking (industry, years, total_laid_off) as 
(
select industry, year(`date`), sum(total_laid_off) 
from staging_layoffs3
group by industry, year(`date`)
)
select * , dense_rank() over(partition by industry,years order by years ASC) as ranking
from industry_year_ranking
-- where years is not null
 -- where industry is not null
where total_laid_off is not null
order by ranking;





-- it will displays the layoffs in crypto industry order by year
select industry, year(`date`), sum(total_laid_off)
from staging_layoffs3
where industry = 'Crypto'
group by industry,  year(`date`)
order by year(`date`)
;

