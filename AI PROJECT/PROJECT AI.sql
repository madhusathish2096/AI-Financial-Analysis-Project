create database projectai;
use projectai;

select * from ai_data;
describe ai_data;

-- ADD COLUMN FOR SERIAL_NO
alter table ai_data add column serial_no int auto_increment first, add unique (serial_no) ;

-- YEARWISE COMPANIES POSITIVE STOCK IMPACT 
select distinct `Year`, Company,`Stock_Impact_%`from ai_data where `Stock_Impact_%` >=0 order by `Stock_Impact_%` desc;

-- R&D_EXPENSES PER COMPANY
select Company,sum(`R&D_Spending_USD_Mn`) as RD_Expenses from ai_data group by company ; 

-- COMPANIES TOTAL AI REVENUE
select Company,sum(`AI_Revenue_USD_Mn`) as AI_Revenue from ai_data group by company;

-- AI_REVENUE GROWTH PERCENTAGE PER COMPANY
select Company,sum(`AI_Revenue_Growth_%`) as AI_Revenue_Growth from ai_data group by company order by AI_Revenue_Growth desc;

-- AI_REVENUE GROWTH LEVEL USING CASE STATEMENT
select Company,`Year`,`AI_Revenue_Growth_%`,
case
when `AI_Revenue_Growth_%` <=0 then 'NEGAVTIVE'
when `AI_Revenue_Growth_%` <=200 then 'LOW'
when `AI_Revenue_Growth_%` <350 then 'MEDIUM'
when `AI_Revenue_Growth_%` >350 then 'HIGH'
end as growth_level from ai_data order by `AI_Revenue_Growth_%` ;

-- MINIMUM AND MAXIMUM AI REVENUE BY COMPANYWISE
select Company,min(`AI_Revenue_USD_Mn`) as Low_Revenue,
max(`AI_Revenue_USD_Mn`) as High_Revenue from ai_data group by Company;

-- PROFIT DIFFERENCE OF R&D EXPENSES VS AI REVENUE BY COMPANYWISE
select Company,
SUM(`AI_Revenue_USD_Mn`) as Total_Revenue,
SUM(`R&D_Spending_USD_Mn`) as Total_Expenses,
(SUM(`AI_Revenue_USD_Mn`) - SUM(`R&D_Spending_USD_Mn`)) as Profit_Difference
from ai_data group by Company;

-- FIND COMPANIES EVENT IN THE YAER OF 2024 
select Company,`Event`,`Year` from ai_data where `Year` = 2024 and `Event` <> 'No Event' order by Company;

-- COMPANYWISE YEARLY PROFIT DIFFERENCE
Select Company,Year, 
SUM(`AI_Revenue_USD_Mn`) - SUM(`R&D_Spending_USD_Mn`) AS Profit_Diff from ai_data
group by Year,Company order by Year, Company ;

-- COMPANIES AVG REVENUE GROWTH
select Company,avg(`AI_Revenue_Growth_%`) as AVG_Revenue_Growth from ai_data group by Company order by AVG_Revenue_Growth desc ;


 