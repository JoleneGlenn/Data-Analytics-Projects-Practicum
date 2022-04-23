### Project title
13.2. Final Project: SQL Project

### Project Description
Use a database that contains books, publishers, authors, and customer ratings, and reviews of books to generate information that will be used to generate a value proposition for a new product.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: There is a table of contents with Markdown links to assist in finding the desired information.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. If there is please see the HTML file for a visual of the project.**

### Instructions for completing the project (high level - see PDF file for more details)
1. Describe the goals of the study
2. Study the tables (print the rows)
3. Make a SQL query for each of the tasks
4. Output the results of each query
5. Write a general conclusion

### Libraries used
pandas as pd

create_engine from sqlalchemy	

### Project Conclusions
Based on the data queries being requested it looks like the value proposition being formulated will involve book ratings with a possible focus on popular books, publishers, and authors

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Final Project: SQL Project. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
Create a database connection
- db_config = {dictionary_of_parameters}
- create a connection string
- creaet_engine() method

Create a function to run SQL queries and read the first few rows
- def sql_query_print_five(database_table):
    - query = '''SELECT * FROM {}'''.format(database_table)
    - results = pd.io.sql.read_sql(query, con = engine)
    - return results.head()	

Create a function to read and provide results of each query
- def read_results(query_name):
	- results = pd.io.sql.read_sql(query_name, con = engine)
	- return results

**SQL**

Commands
```
SELECT
	AGGREGATE_FUCTION(field) AS output_col_name
		COUNT(table_a.col_a) AS output_col_name
		ROUND(AVG(table_b.col_a), #) AS output_col_name
		COUNT(DISTINCT(table_c.col_a)) AS output_col_name
	DISTINCT col
	Window functions -- sequence of rows on which calculations are made
		AGGREGATE_FUNCTION() OVER (parameter)
FROM 
	table_1
	LEFT JOIN table_2 ON table_2.col = table_1.col
	INNER JOIN table_2 ON table_2.col = table_1.col
	-- subquery
	(SELECT
	FROM) AS subquery
WHERE
GROUP BY
HAVING COUNT(col) boolean_expression value
ORDER BY
	output_col_name DESC
LIMIT
	#;
```

Subquery refactoring
```
WITH temp_table_name (col) AS (
	SELECT
	FROM
	...
	)
SELECT
FROM
...;
```