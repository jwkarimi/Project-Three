CREATE DATABASE  Investments;

USE Investments;

--- Data Cleaning----
--- 1. Remove duplicates
--- 2. Standardize the data
--- 3. Null values or Blanks

-- Duplicating tables----
CREATE TABLE companies_staging
LIKE companies;

SELECT * 
FROM companies_staging;

INSERT companies_staging
SELECT * FROM companies;

CREATE TABLE rounds2_staging
LIKE rounds2;

INSERT rounds2_staging
SELECT * FROM rounds2;

SELECT * FROM rounds2_staging;

------------- Duplicates------
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Name,homepage_url,Category_List,Status,Country_Code,State_Code,Region,City, Founded_Date)
AS row_num
FROM companies_staging;

WITH duplicate_cte AS 
(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Name,homepage_url,Category_List,Status,Country_Code,State_Code,Region,City, Founded_Date)
AS row_num
FROM companies_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT * FROM rounds2_staging;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Company_Permalink, funding_round_permalink,funding_round_type,funding_round_code,funded_at,raised_amount_usd)
AS row_num
FROM rounds2_staging;

WITH duplicate_cte AS 
(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Company_Permalink,funding_round_permalink,funding_round_type,funding_round_code,funded_at,raised_amount_usd)
AS row_num
FROM rounds2_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


--- Standardizing data

SELECT * FROM companies_staging;

SELECT name, TRIM(name) FROM companies_staging;

UPDATE companies_staging
SET name = TRIM(name);

SELECT DISTINCT name from companies_staging;

SELECT * FROM rounds_staging;
SELECT DISTINCT funding_round_type FROM rounds_staging;

---- Date Formating----

SELECT * FROM rounds2;

update rounds2
set funded_at =str_to_date(funded_at,'%d-%m-%Y');

ALTER TABLE rounds2_staging
MODIFY COLUMN funded_at DATE;

---- Date Format for companies didnt work----
SELECT * FROM companies_staging;

UPDATE companies_staging
SET founded_date= DATE_FORMAT(STR_TO_DATE(founded_date,'%m-%d-%Y'),'%Y-%m-%d');


--- Checking null values and blanks----

SELECT * FROM companies_staging
WHERE homepage_url='' or category_list=''or status='' or country_code=''
or state_code='' or region='' or city=''or founded_date='';

SELECT * FROM companies_staging WHERE city='';

UPDATE companies_staging
SET city='Unknown'
WHERE city='';

SELECT * FROM rounds2_staging
WHERE funding_round_code = '';

--- blanks in amounts---
SELECT * 
FROM rounds2_staging
WHERE raised_amount_usd IS NULL 
OR raised_amount_usd = '';

SELECT round(avg(raised_amount_usd),2)
FROM rounds2_staging;

UPDATE rounds2_staging
SET raised_amount_usd = 8741647.75
WHERE raised_amount_usd = '';

SELECT * FROM rounds2_staging;

--- Changing to lower case---

SELECT *, lcase(company_permalink)
FROM rounds2_staging;

UPDATE rounds2_staging
SET company_permalink = lcase(company_permalink);

select * from rounds2_staging;

SELECT *, lcase(permalink)
FROM companies_staging;

SELECT *, lower(name)
FROM companies_staging;

UPDATE companies_staging
SET permalink = lcase(permalink);

SELECT * FROM companies_staging;

SELECT * FROM  rounds2_staging 
WHERE raised_amount_usd BETWEEN 5000000 AND 15000000;

SELECT DISTINCT country_code FROM companies_staging;

SELECT * FROM companies_staging
WHERE country_code IN ('USA','CAN','GBR','AUS','IRL','NZL','BWA','NGA','ZAF','MUS',
'KEN','GHA','GGY','UGA','ZWE','BRB','TAN');









