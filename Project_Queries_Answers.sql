USE investments;

SELECT * FROM companies_sectors;

SELECT * FROM funding_rounds;

ALTER TABLE Companies_sectors CHANGE ï»¿permalink Permalink text;

ALTER TABLE Funding_rounds CHANGE ï»¿Company_Permalink Company_Permalink text;

-- Question one -----
-- 1.	What is the distribution of investment amounts across different investment 
    types (venture, seed, angel, private equity, etc.)? --

SELECT funding_round_type, sum(raised_amount_usd) AS Total_Amount
FROM funding_rounds
GROUP BY funding_round_type
ORDER BY Total_Amount desc;

SELECT funding_round_type, Round(Avg(raised_amount_usd),2) AS Avg_Investment_Amount
FROM funding_rounds
GROUP BY funding_round_type
ORDER BY  Avg_Investment_Amount desc;


---- Question Two----
-- 2.	Which countries have received the highest total investments in USD?--

SELECT MAX(raised_amount_usd) AS Highest_Investment, country_code
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
GROUP BY Country_code
ORDER BY Highest_Investment desc;

---- Question Three-----
---- 3.	In which sectors do most investments occur globally?

SELECT COUNT(raised_amount_usd) AS Number_of_Investments, main_sectors, country_code
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
GROUP BY main_sectors, country_code
ORDER BY number_of_investments desc;

---- Question Four ---
---- 4.	What is the average investment amount in each main sector?

SELECT Round(AVG(raised_amount_usd),2) AS Avg_Investment_Amnt, main_sectors
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
GROUP BY main_sectors
ORDER BY Avg_investment_Amnt desc;

---- Question Five ----
---- 5.	Which sectors have the highest number of investments?

SELECT COUNT(raised_amount_usd) AS Highest_Investment, main_sectors
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
GROUP BY main_sectors
ORDER BY Highest_Investment desc;

--- Question Six---
---- 6.	How does the investment distribution vary between different countries in the top three sectors?

SELECT SUM(raised_amount_usd) AS Total_Investment, main_sectors, country_code
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
WHERE main_sectors = 'other' OR main_sectors='Social_Finance_Analytics_Advertising' 
OR main_sectors='Cleantech_Semiconductors'
GROUP BY main_sectors, country_code
ORDER BY Total_Investment desc;

--- Question Seven---
--- 7.	What is the relationship between funding rounds and investment amounts?

SELECT rounds, SUM(raised_amount_usd) AS Investment_amnts
 FROM funding_rounds
 GROUP BY rounds
 ORDER BY Investment_amnts desc;

---- Question Eight---
---- 8.	Which sectors and countries have the highest ratio of investment amount to number of investments?

SELECT SUM(raised_amount_usd) AS Total_Investment, COUNT(raised_amount_usd) AS Number_of_investment,
main_sectors, country_code
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
GROUP BY main_sectors, country_code
ORDER BY Number_of_investment desc;

SELECT  COUNT(raised_amount_usd) / SUM(raised_amount_usd) AS Ratio,
main_sectors, country_code
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
GROUP BY main_sectors, country_code
ORDER BY Ratio desc;

---- Question Nine---
---- 9.	How has the investment trend changed over the years in the top sectors?

SELECT SUM(raised_amount_usd) AS Total_Investment, main_sectors, funded_date
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
GROUP BY main_sectors, funded_date
ORDER BY funded_date,Total_investment desc;

---- Question Ten -----
---- 10.What is the distribution of investments in different funding rounds 
(first, second, third, etc.) within the top sectors and countries? ---- 

SELECT sum(raised_amount_usd) AS Total_amount, main_sectors
country_code, rounds, funding_round_type
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
GROUP BY main_sectors, country_code, funding_round_type,rounds
order by Total_amount desc;

SELECT sum(raised_amount_usd) AS Total_amount, main_sectors,
country_code, rounds, funding_round_type
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
WHERE Rounds != 'Unknown' 
GROUP BY main_sectors, country_code, funding_round_type, rounds
order by Total_amount desc;

SELECT * FROM funding_rounds;

---- Question eleven---
--- What is the average equity stake taken by Spark Funds in its investments 
across different sectors and countries -----

SELECT AVG(raised_amount_usd) AS Avg_equity, main_sectors, country_code
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
WHERE raised_amount_usd BETWEEN 5000000 AND 15000000
GROUP BY main_sectors, country_code
ORDER BY Avg_equity desc;

SELECT Avg(raised_amount_usd) AS Avg_equity, main_sectors, country_code, Funding_round_type, rounds
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
WHERE  Funding_round_type = 'Venture' 
AND raised_amount_usd BETWEEN 5000000 AND 15000000
GROUP BY main_sectors, country_code, rounds, funding_round_type
ORDER BY Avg_equity desc;

SELECT raised_amount_usd, country_code, Funding_round_type, rounds,main_sectors
FROM companies_sectors INNER JOIN funding_rounds ON 
companies_sectors.permalink = funding_rounds.company_permalink
WHERE  Funding_round_type = 'venture' 
AND raised_amount_usd BETWEEN 5000000 AND 15000000
ORDER BY raised_amount_usd desc;

select * from funding_rounds;