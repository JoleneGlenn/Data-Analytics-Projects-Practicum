### Project title
05. Data Collection and Storage (SQL): Find patterns in ride-share passenger preferences

### Project Description
Zuber is a new ride-sharing company launching in Chicago. 

Find patterns to understand passenger preferences and the impact of external factors on rides.

Working with a database, analyze data from competitors and test a hypothesis about the impact of weather on ride frequency.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: There is a table of contents, however it does not have links as I was still learning the syntax of Markdown, so finding the desired information in the formatting may be difficult.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.

### Instructions for completing the project (high level - see PDF file for more details)
1. Parse the data - python on Practicum platform
2. Exploratory Data Analysis - SQL on Practicum platform
3. Test hypothesis that duration of rides from the Loop to O'Hare International Airport changes on rainy Saturdays - SQL on Practicum platform
4. Exploratory Data Analysis - python jupyter notebook
5. Test Hypothesis - python jupyter notebook
	- The average duration of rides from the Loop to O'Hare International Airport changes on rainy Saturdays.

### Libraries used
requests

BeautifulSoup from bs4

pandas as pd

numpy as np

matplotlib.pyplot as plt

datetime

stats as st	from scipy

### Project Conclusions
Results
- The null hypothesis is rejected, the alternative hypothesis is true: the average duration of rides from the Loop to O'Hare International Airport is different on rainy Saturdays compared to non-rainy Saturdays.
    - This is supported by the weather_stats table showing that the average ride time for bad days is 7 minutes longer than good days

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Data Collection and Storage (SQL) sprint. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Python (pre SQL)**

**Parse the data**
Request access to URL
- data_req = requests.get(URL)

Parse data
- data = BeautifulSoup(data_req.text, 'lxml')

Find table information
- table = data.find('table', attrs = {'id': 'table_name'})

Find table headers
- headers = []
```
for row in table.find_all('th'):
	headers.append(row.text)
```

Find table contents
```
	contents = []
	for row in table.find_all('tr'):
		if not row.find_all('th'):
			contents.append([element.text for element in row.find_all('td')])
```

Create df from request
- df = pd.DataFrame(contents, columns = headers)

**SQL**
**Commands**
SELECT
```
	AGGREGATE_FUNCTION(field) AS output_col_name
		COUNT(col) AS output_col_name
		Others (not used in this project):
			COUNT(col)
			COUNT(DISTINCT col)
			SUM(col)
			AVG(col)
			MIN(col)
			MAX(col)
	CAST(col AS data_type) AS output_col_name --converts data types, can have boolean expressions after ()
	CASE
		WHEN col boolean_expresion 'value'
		THEN 'value'
		ELSE col END AS output_col_name
FROM
	--subqueries
	col_name = (SELECT
	FROM
	WHERE
	...) as subquery_1
Joining tables
	INNER JOIN table ON table_1.col = table_2.col
	UNION
WHERE
	AND, OR, NOT
	field_1 BETWEEN value_1 AND value_2
	field_1 IN ('value_1', ...)
	--subqueries
	(SELECT
	FROM
	WHERE
	...)
GROUP BY
	field 
HAVING
	AGGREGATE_FUNCTION(field_for_grouping) boolean_expresion value
ORDER BY
	field DESC or ASC
LIMIT
	number;
```

Pattern search
- Used in WHERE, CASE WHEN
	- field LIKE '%value%'

Date functions
- Used in WHERE, can also be used in SELECT
- EXTRACT(date_fragment FROM col) AS output_col_name

**Python**

**Data Prep**
Read .csv files as a dataframe
- pd.read_csv()

Identify missing values
- df.isnull().sum(), df['column'].isnull()

Find and delete duplicate rows
- Number of duplicate rows: df.duplicated().sum()
- Delete duplicate rows: df.drop_duplicates().reset_index(drop = True)

Change data types
- df['columna'] = pd.to_datetime(df['columna'])

**Analysis**
Create df from sorted values
- df = df.sort_values(by = 'col', ascending = False).head(10)
- df_top_10 = pd.DataFrame(df)

**Graphs**
Bar plots
- graph_name = df.plot(kind = 'bar')
- graph_name.set_xticklabels(df['column']) - sets x tick labels with df column values

**Hypothesis testing**
Calculate Dispersion
- np.var(list)

Test using an independent samples t-test to test the equality of the eans of the two populations
- results = st.ttest_ind(list_1_values, list_2_values, equal_var = True or False)
- True if the dispersion is the same, False if it is not

Calculate p-value
- results.pvalue

Critical statistical significance level
- alpha = 0.05 (common to be between 0.01 - 0.05)

Null & Alternative Hypotheses
- if results < alpha then null hypothesis is rejected, there is a significant difference between the averages of the populations
if results > alpha then null hypothesis cant be rejected, there is not a significant difference between the averages of the populations