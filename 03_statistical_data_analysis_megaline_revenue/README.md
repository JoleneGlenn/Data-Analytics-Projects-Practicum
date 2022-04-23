### Project title
03. Statistical Data Analysis: Which Megaline plan brings in more revenue

### Project Description
The commercial department at Megaline wants to know which prepaid plan, Surf or Ultimate, brings in more revenue in order to adjust the advertising budget.

Perform preliminary analysis on 500 Megaline clients by analyzing their stats and behaviors.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: This is one my very first coding projects, it contains details on the project and the work I performed, however it does not have a table of contents and I was still learning the syntax of Markdown, so finding the desired information in the formatting may be difficult.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. Please see a visual of the project [here](http://htmlpreview.github.io/?https://github.com/JoleneGlenn/Data-Analytics-Projects-Practicum/blob/main/03_statistical_data_analysis_megaline_revenue/03_sda_telecom_research_accepted.html).**

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Analyze the data: Calculate statistics and plot histograms
4. Test the hypotheses
	- The average revenue from users of Ultimate and Surf calling plans differs.
	- The average revenue from users in NY-NJ area is different from that of the users from other regions.
5. Write an overall conclusion

### Libraries used
pandas as pd

numpy as np

matplotlib.pyplot as plt

datetime

math as mt

stats as st from scipy

reduce from functools

### Project Conclusions
Test 1: Null hypothesis is true: The average revenue from users of Ultimate and Surf calling plans is the same.
- Average Surf revenue: 8932.301666666666
- Average Ultimate revenue: 6386.333333333333
- While these averages are not exact, they may not be statistically different according to this test

Test 2: The alternative hypothesis is true: The average revenue from users in NY-NJ area is different from that of the users from other regions.
- Average NY-NJ revenue: 2368.295
- Average revenue from cities excluding NY-NJ: 12950.340000000002
- These averages are statistically different

According to this sample of data the Surf plan brings in more revenue
- It could be recommended that they focus on advertising the Surf plan
- Around July is when the monthly totals start to exceed that of the Ultimate plan
- Keep in mind that in this data set, Surf customers account for more than half of the data provided for this evaluation

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Statistical Data Analysis sprint. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Data Prep**

Read .csv files as a dataframe
- pd.read_csv()

Rename columns
- df.rename(columns={'orig_col_name' : 'new_col_name'}, inplace = True)

Identify missing values
df.isnull().sum(), df['column'].isnull()

Fill in missing or null values with .loc method
df.loc[df['column'].isnull(), 'column_to_fill'] = value_to_fill_null

Find and delete duplicate rows
Number of duplicate rows: df.duplicated().sum()
Delete duplicate rows: df.drop_duplicates().reset_index(drop = True)

Change data types
- df['col_a'] = df['col_a'].astype(int) Used .astype(int) method to convert float64 type to int64 type because float64 is a numeric data type.
- If the initial data type was a string, then .to_numeric() would be used which converts strings to floats and then .astype() to convert the float to int.
- df['columna'] = pd.to_datetime(df['columna'])

**Analysis**

Filter tables
- df.query('column boolean_statment column or @list')

Pivot Table
- pivot_table = df.pivot_table(index, columns, values, aggfunc, margins = True, margins_name = 'col_name')
- pivot_table.fillna(value, inplace = True)
- pivot_table = pivot_table.add_prefix('prefix')
	- when value = ['a', 'b', 'c',] must have comma after last item

Applymap()
- .applymap() to round values up
	- new_table = table.applymap(np.ceil)
- .applymap() with lambda function for conversion
	- new_table = table.applymap(lambda x: x / num)

Reduce
- reduce(function, sequence) with lambda function to join tables
	- new_table = reduce(lambda x, y: pd.merge(x, y, on='col_name', how='outer'), list_of_tables)

Remove null values
- df = df.dropna().reset_index(drop = True)

Date related columns added
- df['new_col_b'] = df['date_col'].dt.month

Functions created to calculate necessary information
- try, except and if, else and return methods used
- for loops and df.apply() methods used to apply function to table to make a new column from data in the table: df['new_col'] = df.apply(fxn_name, axis = 1)
- for loops required an args which requires a tuple in the df.apply() method: df.apply(fxn_name, args = (dict[for_loop_value],), axis = 1)

Calculated information
- totals ('sum'), averages ('mean'), standard  deviations('std'), dispersion (np.var) for each plan in pivot_tables

**Graphs**

2 histograms on one graph
```
	hist_a = df_a.hist(alpha = 0.7)
	hist_b = df_b.hist(ax = hist_a, alpha = 0.7)
```

bar plots

**Hypothesis Testing**

Test the equality of the means of two populations
- results = scipy.stats.ttest_ind(list_pop_1_values, list_pop_2_values, equal_var = True or False)
- True if the dispersion is the same, False if it is not

Calculate p-value
- results.pvalue

Critical statistical significance level
- alpha = 0.05 (common to be between 0.01 - 0.05)

Null & Alternative Hypotheses
- if results < alpha then null hypothesis is rejected, there is a significant difference between the averages of the populations
- if results > alpha then null hypothesis cant be rejected, there is not a significant difference between the averages of the populations