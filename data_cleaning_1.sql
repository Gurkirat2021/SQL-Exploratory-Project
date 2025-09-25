-- Data Cleaning Project

select * from layoffs;
-- 1. Remove duplicates.
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove Any Columns 

-- create table
create table staging_layoffs
like layoffs;

select * from staging_layoffs;

-- insert  data in the table
insert staging_layoffs
select * 
from layoffs;

--  to find the duplicates in the data table

select company, count(company) as count
from staging_layoffs 
group by company
having count >1
order by count DESC;


select * from staging_layoffs 
where company = 'Loft';

select * from staging_layoffs 
where company = 'Zymergen';
select * ,
row_number() over(partition by company, industry, total_laid_off, percentage_laid_off, date) as row_num
from staging_layoffs;

-- creating  a CTE  to check the duplicates in the table

with duplicate_cte as
(
select * ,
row_number()
 over( partition by company,location,industry, total_laid_off, percentage_laid_off, date,stage, country, funds_raised_millions) as row_num
from staging_layoffs
)
select * 
from duplicate_cte
where row_num > 1 ;

select * from staging_layoffs 
where company = 'Yahoo';

-- create table using copy to clipboard and paste by right clicking on staging_layoffs to delete the duplicates and
--  add a row_mun column to check the duplicates

 CREATE TABLE `staging_layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`  int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from staging_layoffs2;

-- insert the row number in the staging_layoffs with duplicates

insert into staging_layoffs2
select * ,
row_number()
 over ( partition by company,location,industry, total_laid_off, percentage_laid_off, date,stage, country, funds_raised_millions) as row_num
from staging_layoffs;

-- checking the duplicates
select * from staging_layoffs2 
where row_num >1;

-- deleting the duplicate rows 
-- checking whether the rows are deleted or not

 select * from staging_layoffs2;
 
 -- creating another table for removing duplicates
 CREATE TABLE `staging_layoffs3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num`  int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from staging_layoffs3;

select * from staging_layoffs2;


-- insert the row number in the staging_layoffs3 with duplicates

insert into staging_layoffs3
select * ,
row_number()
 over ( partition by company,location,industry, total_laid_off, percentage_laid_off, date,stage, country, funds_raised_millions) as row_num
from staging_layoffs2;

-- checking the duplicates
select * from staging_layoffs3
where row_num > 1;

delete 
from staging_layoffs3
where row_num = 2;

-- standardizing data
-- remove or trim the space from left side of the company row
select company, trim(company) from staging_layoffs2;
update staging_layoffs3
set company = trim(company);

-- check industry column
select distinct(industry) from staging_layoffs3 order by 1; 

select * from staging_layoffs2 
where industry like 'Crypto%' ;

-- updating the industry column  (crypto and cryptocurrency) as crypto
update staging_layoffs3
set industry = 'Crypto' 
where industry like 'Crypto%';

-- checking wherther the  industry = Crypto updated or not 
select distinct(industry) 
from staging_layoffs3;

-- check for location 
select distinct(location)
from staging_layoffs3
order by 1;

-- check for country
select distinct(country)
from staging_layoffs3
order by 1;
 
 -- check for stage 
 select distinct(stage)
 from staging_layoffs3 
 order by 1;
 
 -- check for company
 select distinct(company)
 from staging_layoffs3
 order by 1;
 
 

select * from staging_layoffs3 
where country like 'United States%'
order by location;

select * from staging_layoffs3
where country like 'United States.'
order by location;

-- to update the country column for value 'United States'
select distinct country , trim(trailing '.' from country)
from staging_layoffs3
order by 1;

update staging_layoffs3
set country = trim(trailing '.' from country)
where country like 'United States%';

-- checking for updates applied or not?

select  distinct(country) from staging_layoffs3
order by 1 ;


-- change the date column data type to date from text
select `date` from staging_layoffs2;
select `date` from staging_layoffs3;
select `date` ,
str_to_date(`date`, '%m/%d/%Y')
from staging_layoffs3;

update staging_layoffs3
set `date` = str_to_date(`date`, '%m/%d/%Y');

select * from staging_layoffs3;

-- alter the table or data type date text to date

alter table staging_layoffs3
modify column `date` date;

select * from staging_layoffs3;

-- check for stage column
select distinct(stage) from staging_layoffs3
order by 1;

-- working with null or blank values
select * from staging_layoffs3 
where total_laid_off is NULL
and percentage_laid_off is NULL;

-- checking for null or blank values in industry column
select * from staging_layoffs3 
where industry is null
or industry ='';

select * from staging_layoffs3
where company = 'Airbnb';

select * from staging_layoffs3 
where company = "Zymergen";

-- joining same table to check which industry column is null or blank but few have entires with same company and location column.

select t1.company, t1.industry, t2.company,t2.industry from 
staging_layoffs3 t1
join staging_layoffs3 t2
on t1.company = t2.company
where(t1.industry is null or t1.industry ='')
and t2.industry is not null;


-- update industry column blanks to null
update staging_layoffs3
set industry = null
where industry ='';

-- update the industry column where Airbnb  company column 

update staging_layoffs3 t1
join staging_layoffs3 t2
on t1.company = t2.company
set t1.industry = t2.industry
where(t1.industry is null )
and t2.industry is not null;


select * from staging_layoffs3 
where company = 'Airbnb';

-- checking again for the blank or null values
select * from staging_layoffs3
where industry is null
or industry ='';

select * from staging_layoffs3 ;

select * from staging_layoffs3
where total_laid_off is null
and percentage_laid_off is null;

-- delete the rows which has total_laid_off and percentage_laid_off is null
delete 
from staging_layoffs3
where total_laid_off is null
and percentage_laid_off is null;

select * from staging_layoffs3 ;


-- drop a column from the table
alter table staging_layoffs3
drop  column row_num;


select * from staging_layoffs3 ;
select * from staging_layoffs3
where company = 'Included Health';