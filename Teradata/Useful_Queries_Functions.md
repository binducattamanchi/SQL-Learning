# Date Functions


# String Functions
Concat:Select concat(‘Teradata’,’for beginners’)
OREPLACE: SELECT OREPLACE('TD13.1 is the current version', '13.1', '14.0');
OTRANSLATE: SELECT OTRANSLATE(' Current Year 2013 ',  '3', '4')
LENGTH: SELECT LEN(column_name) FROM table_name;
POSITION/INDEX: 
SELECT POSITION( 'u' IN 'formula');  Displays Result as '5' 
SELECT POSITION( 'fo' IN 'formula'); Displays Result as '1' 
SELECT POSITION( 'e' IN 'formula');  Displays Result as '0'
LOWER: SELECT LCASE(column_name) FROM table_name;
UPPER: SELECT UCASE(column_name) FROM table_name;
SUBSTRING/SUBSTR : SELECT SUBSTRING('TechOnTheNet.com', 1, 4);
INSTR: SELECT INSTR ('Love', 'o') ; Result 2
TRANSLATE: SELECT TRANSLATE('Tech Honey', 'ech','abc')
TRIM/LTRIM/RTRIM: SELECT TRIM('   Sample   ');
PAD/LPAD/RPAD :SELECT LPAD('building', 11, 'yz'); Result 'yzybuilding'
NVL: SELECT NVL(col_name,'No Value')
NVL2: SELECT NVL2('England', 'France', 'Spain'); Result France

# Arithmetic Functions
COUNT:
SUM:
MAX:
MIN:
AVG:
CSUM:
MAVG:
MDIFF:
MLINREG :
MSUM:
PERCENT_RANK:
QUANTILE:


# OLAP Functions

*** RANK()/ RANK() with Qualify/ RANK() with Qualify and Partition**
Use cases like - 
  * Get top 3 sales - any product in any store:
  * Show the lowest ranking of product sales for store 1001.
  * Show the ranking of product sales for store 1001.
  * Get the top three selling products in each store.
```
SELECT   storeid
     ,prodid
     ,sales
     ,RANK( ) OVER (PARTITION BY storeid
      ORDER BY sales DESC) AS "Ranking"
FROM  salestbl
QUALIFY Ranking <= 3;


Storeid         prodid         sales            Rank
----------------------------------------------------------------
1001            F               150000.00           1
1001            A               100000.00           2
1001            C                60000.00            3
1002            A                40000.00            1
1002            C                35000.00            2
1002            D                25000.00            3
1003            B                65000.00            1
1003            D                50000.00            2
1003            A                30000.00            3 

```
*** ROWNUMBER()**

![image](https://user-images.githubusercontent.com/32897934/123853619-493d8b00-d93b-11eb-9586-41d2cab22bb8.png)

To order salespersons based on sales within a sales region, the following SQL query might yield the following results.
Screenshot 2021-06-30 at 12.39.05 AM<img width="580" alt="Screenshot 2021-06-30 at 12 39 05 AM" src="https://user-images.githubusercontent.com/32897934/123853885-99b4e880-d93b-11eb-9b56-04cb7a4f3d87.png">

*** LEAD() & LAG() **

Find the EmployeeID for each employee that has closest salary to them.


```
select	EmployeeID,EmployeeName,Salary,
LAG(EmployeeID) ignore nulls over (
partition by 1
order by Salary) as EmployeeID_Lag,
LAG(Salary) ignore nulls over (
partition by 1
order by Salary) as Salary_Lag,
LEAD(EmployeeID) ignore nulls over (
partition by 1
order by Salary) as EmployeeID_Lead,
LEAD(Salary) ignore nulls over (
partition by 1
order by Salary) as Salary_Lead
from	TD_MS_SAMPLE_DB.Employee;
```



**Cumulative**	
ROWS UNBOUNDED PRECEDING
ROWS BETWEEN UNBOUNDED PRECEDING AND value PRECEDING
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
ROWS BETWEEN UNBOUNDED PRECEDING AND value FOLLOWING
**Group**	
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
**Moving**	
ROWS value PRECEDING
ROWS CURRENT ROW
ROWS BETWEEN value PRECEDING AND value PRECEDING
ROWS BETWEEN value PRECEDING AND CURRENT ROW
ROWS BETWEEN value PRECEDING AND value FOLLOWING
ROWS BETWEEN CURRENT ROW AND CURRENT ROW
ROWS BETWEEN CURRENT ROW AND value FOLLOWING
ROWS BETWEEN value FOLLOWING AND value FOLLOWING
**Remaining**	
ROWS BETWEEN value PRECEDING AND UNBOUNDED FOLLOWING
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
ROWS BETWEEN value FOLLOWING AND UNBOUNDED FOLLOWING

Examples:
Group Count :  where the group count for sales is returned for each of the four partitions defined by city and kind. Notice that rows that have no sales are not counted.
```
SELECT city, kind, sales, profit,
   COUNT(sales) OVER (PARTITION BY city, kind 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND
                      UNBOUNDED FOLLOWING)
   FROM activity_month;
   
   city     kind      sales  profit  Group Count(sales)
   -------  --------  -----  ------  ------------------
   LA       Canvas       45     320                   4
   LA       Canvas      125     190                   4
   LA       Canvas      125     400                   4
   LA       Canvas       20     120                   4
   LA       Leather      20      40                   1
   LA       Leather       ?       ?                   1
   Seattle  Canvas       15      30                   3
   Seattle  Canvas       20      30                   3
   Seattle  Canvas       20     100                   3
   Seattle  Leather      35      50                   1
   Seattle  Leather       ?       ?                   1
   ```
   
Remaining Count
To count all the rows, including rows that have no sales, use COUNT(*). Here is an example that counts the number of rows remaining in the partition after the current row:
```
SELECT city, kind, sales, profit,
   COUNT(*) OVER (PARTITION BY city, kind ORDER BY profit DESC
                  ROWS BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING)
   FROM activity_month;
   
   city     kind      sales  profit  Remaining Count(*)
   -------  --------  -----  ------  ------------------
   LA       Canvas       20     120                   ?
   LA       Canvas      125     190                   1
   LA       Canvas       45     320                   2
   LA       Canvas      125     400                   3
   LA       Leather       ?       ?                   ?
   LA       Leather      20      40                   1
   Seattle  Canvas       15      30                   ?
   Seattle  Canvas       20      30                   1
   Seattle  Canvas       20     100                   2
   Seattle  Leather       ?       ?                   ?
   Seattle  Leather      35      50                   1
   ```
Cumulative Maximum
The following SQL query might yield the results that follow it, where the cumulative maximum value for sales is returned for each partition defined by city and kind.
```
   SELECT city, kind, sales, week, 
   MAX(sales) OVER (PARTITION BY city, kind 
                    ORDER BY week ROWS UNBOUNDED PRECEDING)
   FROM activity_month;
   
   city     kind      sales  week  Cumulative Max(sales)
   -------  --------  -----  ----  ---------------------
   LA       Canvas      263    16                    263
   LA       Canvas      294    17                    294
   LA       Canvas      321    18                    321
   LA       Canvas      274    20                    321
   LA       Leather     144    16                    144
   LA       Leather     826    17                    826
   LA       Leather     489    20                    826
   LA       Leather     555    21                    826
   Seattle  Canvas      100    16                    100
   Seattle  Canvas      182    17                    182
   Seattle  Canvas       94    18                    182
   Seattle  Leather     933    16                    933
   Seattle  Leather     840    17                    933
   Seattle  Leather     899    18                    933
   Seattle  Leather     915    19                    933
   Seattle  Leather     462    20                    933
   ```

Cumulative Minimum
The following SQL query might yield the results that follow it, where the cumulative minimum value for sales is returned for each partition defined by city and kind.
```
   SELECT city, kind, sales, week, 
   MIN(sales) OVER (PARTITION BY city, kind
                    ORDER BY week 
                    ROWS UNBOUNDED PRECEDING) 
   FROM activity_month;
   
   city     kind      sales  week  Cumulative Min(sales)
   -------  --------  -----  ----  ---------------------
   LA       Canvas      263    16                    263
   LA       Canvas      294    17                    263
   LA       Canvas      321    18                    263
   LA       Canvas      274    20                    263
   LA       Leather     144    16                    144
   LA       Leather     826    17                    144
   LA       Leather     489    20                    144
   LA       Leather     555    21                    144
   Seattle  Canvas      100    16                    100
   Seattle  Canvas      182    17                    100
   Seattle  Canvas       94    18                     94
   Seattle  Leather     933    16                    933
   Seattle  Leather     840    17                    840
   Seattle  Leather     899    18                    840
   Seattle  Leather     915    19                    840
   Seattle  Leather     462    20                    462
   ```
   
Cumulative Sum
The following query returns the cumulative balance per account ordered by transaction date:
```
   SELECT acct_number, trans_date, trans_amount,
   SUM(trans_amount) OVER (PARTITION BY acct_number 
                           ORDER BY trans_date 
                           ROWS UNBOUNDED PRECEDING) as balance
   FROM ledger
   ORDER BY acct_number, trans_date;
Here are the possible results of the preceding SELECT.

acct_number	trans_date	trans_amount	balance
73829	1998-11-01	113.45	113.45
73829	1988-11-05	-52.01	61.44
73929	1998-11-13	36.25	97.69
82930	1998-11-01	10.56	10.56
82930	1998-11-21	32.55	43.11
82930	1998-11-29	-5.02	38.09
```
Group Sum
The query below finds the total sum of meat sales for each city.
```
   SELECT city, kind, sales,
   SUM(sales) OVER (PARTITION BY city ROWS BETWEEN UNBOUNDED PRECEDING
   AND UNBOUNDED FOLLOWING) FROM monthly;
The possible results of the preceding SELECT appear in the following table.

city	kind	sales	Group Sum (sales)
Omaha	pure pork	45	220
Omaha	pure pork	125	220
Omaha	pure pork	25	220
Omaha	variety pack	25	220
Chicago	variety pack	55	175
Chicago	variety pack	45	175
Chicago	pure pork	50	175
Chicago	variety pack	25	175
```

Group Sum
The following query returns the total sum of meat sales for all cities. Note there is no PARTITION BY clause in the SUM function, so all cities are included in the group sum.
```
   SELECT city, kind, sales,
   SUM(sales) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND
                    UNBOUNDED FOLLOWING) 
   FROM monthly;
The possible results of the preceding SELECT appear in the table below.

city	kind	sales	Group Sum (sales)
Omaha	pure pork	45	395
Omaha	pure pork	125	395
Omaha	pure pork	25	395
Omaha	variety pack	25	395
Chicago	variety pack	55	395
Chicago	variety pack	45	395
Chicago	pure pork	50	395
Chicago	variety pack	25	395
```
Moving Sum
The following query returns the moving sum of meat sales by city. Notice that the query returns the moving sum of sales by city (the partition) for the current row (of the partition) and three preceding rows where possible.

The order in which each meat variety is returned is the default ascending order according to profit.

Where no sales figures are available, no moving sum of sales is possible. In this case, there is a null in the sum(sales) column.
```
   SELECT city, kind, sales, profit,
   SUM(sales) OVER (PARTITION BY city, kind
                    ORDER BY profit ROWS 3 PRECEDING)
   FROM monthly;
city	kind	sales	profit	Moving sum (sales)
Omaha	pure pork	25	40	25
Omaha	pure pork	25	120	50
Omaha	pure pork	45	140	95
Omaha	pure pork	125	190	220
Omaha	pure pork	45	320	240
Omaha	pure pork	1255	400	340
Omaha	variety pack	?	?	?
Omaha	variety pack	25	40	25
Omaha	variety pack	25	120	50
Chicago	pure pork	?	?	?
Chicago	pure pork	15	10	15
Chicago	pure pork	54	12	69
Chicago	pure pork	14	20	83
Chicago	pure pork	54	24	137
Chicago	pure pork	14	34	136
Chicago	pure pork	95	80	177
Chicago	pure pork	95	140	258
Chicago	pure pork	15	220	219
Chicago	variety pack	23	39	23
Chicago	variety pack	25	40	48
Chicago	variety pack	125	70	173
Chicago	variety pack	125	100	298
Chicago	variety pack	23	100	298
Chicago	variety pack	25	120	298
```
For more such examples refer: https://docs.teradata.com/r/756LNiPSFdY~4JcCCcR5Cw/LxlW3DwM2KhrHX5qlrD4nQ

# NUM Functions

ping.png![ping](https://user-images.githubusercontent.com/32897934/123848230-1c867500-d935-11eb-9c3b-0eca2bf29e65.png)


# Operators

Operators are symbols or words that cause an 'operation' to occur on one or more elements called 'operands'. Below are the types of Operators  
'='
<> 
>  
<  
>= 
<= 
BETWEEN AND
[NOT] IN
IS [NOT] NULL
EXISTS
LIKE ANY/LIKE SOME
LIKE ALL
LIKE


# REGEX 

* **REGEXP_SUBSTR** 
This function extracts a substring from a source string that matches a regular expression pattern.

General Syntax:
```
REGEXP_SUBSTR (source_string, regexp_string, position_arg);
position_arg = (occurance_org, match_arg)
```

REGEXP_SUBSTR Function Example
```
SELECT REGEXP_SUBSTR ('God Bless Mummy God Bless Daddy', 'bless', 1, 2, 'i')
Output: Bless
```

In the above example
source_string = God Bless Mummy God Bless Daddy
regexp_string = Bless
position_arg = Find the second occurrence of the string that matches regular expression. 'i' indicates case insensitive.

* **REGEXP_REPLACE**
This function replaces portions of the source string parameter that match a regular expression pattern with a replace string.

General Syntax:
```
REGEXP_REPLACE (source_string, regexp_string, replace_string);
replace_string=(position_arg,occurance_org, match_arg)
```

```
SELECT REGEXP_REPLACE ('ABCD123-$567xy','[^0-9]*','',1,0,'i');
Output: 123567
```
In this we are replacing the any character or symbols with NULL. So it results only Numeric values.


* **REGEXP_INSTR**
This function Search the source string for a match to a regular expression pattern and return the beginning or ending position of that match.

General Syntax:
```
REGEXP_INSTR (source_string, regexp_string, position_arg)
position_argt = (occurance_org,return_opt, match_arg)
return_opt  returns  0 = function returns the beginning position of the match (default).
                               1 = function returns the end position
```

REGEXP_INSTR Function Examples:
```
SELECT REGEXP_INSTR('Happy Birthday to you', 'Happy Birthday', 1, 1, 0, 'c');
It returns 1

SELECT REGEXP_INSTR('Happy Birthday to you', 'Happy Birthday', 1, 1, 1, 'c');
It returns 15
```

* **REGEXP_SIMILAR**
This function compares a source string to a regular expression and returns an integer value.
 1 (true) if the entire string matches regexp_arg
 0 (false) if the entire string does not match regexp_arg

General Snytax:
```
REGEXP_SIMILAR(source_string, regexp_string, match_arg)
```

REGEXP_SIMILAR Function Examples:
```
SELECT    Emp_Name
FROM    Emp_Table
WHERE    REGEXP_SIMILAR (emp_name, '(Smith B(i|y)rd)|| (John B(i|y)rd)','c') = 1;

It returns the names of employees that match
Smith Byrd
Smith Bird
John Bird
John Byrd
```

* **REGEXP_SPLIT_TO_TABLE**
This table function splits a source string into a table of strings using a regular expression as the delimiter.

General Snytax:
```
REGEXP_SPLIT_TO_TABLE (source_string, regexp_string, match_arg)
```

REGEXP_SPLIT_TO_TABLE Function Examples:
```
CREATE TABLE split_table_latin(id integer, src varchar(100) character set latin, pattern varchar(100) character set latin, match varchar(100) character set latin);
INSERT into split_table_latin(3, 'The2134quick234brown234fox987jumps8743over342the03487lazy089734red972384dog2343.', '[0-9]*','c');
```

Then the following SELECT statement:
```
SELECT * from table ( regexp_split_to_table(split_table_latin.src,split_table_latin.pattern,split_table_latin.match)returns (res varchar(100) character set latin)) as t1;

Returns a table with the following rows
The
quick
brown
fox
jumps
over
the
lazy
red
dog
.
```
