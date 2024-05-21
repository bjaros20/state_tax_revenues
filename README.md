# state_tax_revenues
Panel of US state collections from major taxes.  Data is from the US Census Bureau (Census of States), which is compiled into state time series by FRED. 

The Census Bureau [collects](https://www.census.gov/programs-surveys/stc.html) state and local tax revenues in the Census of States. These revenues are summarized into 5 broad categories and 25 subcategories.  FRED then collects this information and compiles it into a time series for each of the collections.  FRED allows you to create individual lists with collections of interest for each state (For example, Alaska's main collections page is linked [here](https://fred.stlouisfed.org/release/tables?eid=151977&rid=143)).  

I compiled a list for each of the states and included the following nine collections named, followed by their series id: 

(1) Business License Tax, BUSLICTAX
(2) Corporate Income Tax, CORPINCTX
(3) Individual Income Tax, INCTAX
(4) Property Tax, PROPTAX
(5) General Sales and Gross Receipts Tax, SALESTAX
(6) Severance Tax, SVRNCTAX
(7) Total Income Tax (includes Individual and Corporate Income Taxes), TLINCTAX
(8) Total Selective Sales Tax, TLSLTAX
(9) Total Taxes, TOTLTAX

The collections are in thousands of dollars and are not seasonally adjusted.

_____

These data files are annual data pulled from FRED in February 2024.  I then include the R-code that filtered, merged, and transposed data from the individual xls files for each state into one long panel "FRED_SALT_Rev_Feb_2024.csv". I generally commit and work in my own private folders on state corporate income tax and tax incentives.  If you are interested in those topics, feel free to reach out.  

Lastly, I will try to keep the files as up to date as possible.  The original data is publicly available and updated by the Census Bureau and FRED.
