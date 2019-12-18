--show all drug companies
select DC_ID,
       DC_NAME,
       DC_ADDRESS
from "DRUG_COMP" a;

--show all drug suppliers
select DS_ID,
       DS_NAME,
       DS_ADDRESS
from "DRUG_SUPP" a;

--show all drugs and their producers
select DRG_ID,
       DRG_NAME,
       DRG_TYPE,
       (select "DC_NAME" from "DRUG_COMP" x where x."DC_ID" = a."DC_ID") "DC_NAME"
from "DRUG" a;

--show all drugs and their suppliers*
select a.DRG_ID,
       a.DRG_NAME,
       a.DRG_TYPE,
       b.DS_NAME
from "DRUG" a,"DRUG_SUPP" B,"SUPPLIERS" c 
where ((c.DRG_ID = a.DRG_ID) and (c.DS_ID =b.DS_ID));

--show all employees and the pharmacies they work in
select EMP_ID,
       EMP_NAME,
       EMP_PHONE,
       EMP_SAL,
       (select "PH_NAME" from "PHARMACY" x where x."PH_ID" = a."PH_ID") "PH_NAME"
from "EMPLOYEE" a;

--show all incomes and which pharmacy they are from
select IN_ID,
       IN_DATE,
       (select "PH_NAME" from "PHARMACY" x where x."PH_ID" = a."PH_ID") "PH_NAME"
from "INCOME" a;

-- show all inventories and the pharmacies they are in
select INV_ID,
       (select "PH_NAME" from "PHARMACY" x where x."PH_ID" = a."PH_ID") "PH_NAME"
from "INVENTORY" a;

--show all outcomes and which pharmacy they are from
select OUT_ID,
       OUT_DATE,
       (select "PH_NAME" from "PHARMACY" x where x."PH_ID" = a."PH_ID") "PH_NAME"
from "OUTCOME" a;

--show pharmacy info
select PH_ID,
       PH_NAME,
       PH_ADDRESS,
       PH_PHONE
from "PHARMACY" a;

-- show all of stocked drugs and their names
select ST_ID,
       ST_BUY_PRICE,
       ST_EXPIRE,
       ST_SELL_PRICE,
       INV_ID,
       (select "DRG_NAME" from "DRUG" x where x."DRG_ID" = a."DRG_ID") "DRG_NAME"
from "STOCK" a;
                                  
                                 
--show average, minimum, maximum selling prices and total sales income
select AVG(ST_SELL_PRICE)"AVERAGE SELLING PRICE",MIN(ST_SELL_PRICE)"MINIMUM SELLING PRICE",
       MAX(ST_SELL_PRICE)"MAXIMUM SELLING PRICE",SUM(ST_SELL_PRICE)"TOTAL SALES INCOME"
from STOCK

--show average, minimum, maximum buying prices and total buyinngs outcome
select AVG(ST_BUY_PRICE)"AVERAGE BUYING PRICE",MIN(ST_BUY_PRICE)"MINIMUM BUYING PRICE",
       MAX(ST_BUY_PRICE)"MAXIMUM BUYING PRICE",SUM(ST_BUY_PRICE)"TOTAL BUYINGS OUTCOME"
from STOCK

--drugs with lowest sale price
select a.DRG_ID,
       b.DRG_NAME
from "STOCK" a,"DRUG"b where (select MIN(ST_SELL_PRICE) from stock ) = a.ST_SELL_PRICE and a.DRG_ID=b.DRG_ID

--drugs with highest sale price
select a.DRG_ID,
       b.DRG_NAME
from "STOCK" a,"DRUG"b where (select MAX(ST_SELL_PRICE) from stock ) = a.ST_SELL_PRICE and a.DRG_ID=b.DRG_ID

-- show the specific drug #x's suppliers
select a.DRG_ID,
       a.DRG_NAME,
       a.DRG_TYPE,
       b.DS_NAME
from "DRUG" a,"DRUG_SUPP" B,"SUPPLIERS" c 
where (a.DRG_ID = #X and(c.DRG_ID = a.DRG_ID) and (c.DS_ID =b.DS_ID));

--show how much suppliers every drug has
select C.DRG_ID,
       count(c.DS_ID)
from "DRUG" a,"DRUG_SUPP" B,"SUPPLIERS" c 
where (c.DRG_ID = a.DRG_ID) and (c.DS_ID =b.DS_ID)
group by a.DRG_ID
order by c.DRG_ID;                                  
