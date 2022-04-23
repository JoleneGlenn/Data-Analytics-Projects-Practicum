### Project title
13.3. Final Project: Analysis Project

### Project Description
Evaluate the new loyalty program of Home World, a building material retailer, to see if it has led to an increase in average purchase size and number of items.

The results and recommendations will be submitted to the Project Manager who is familiar with the loyalty program but not an analytics expert.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: There is a table of contents with Markdown links to assist in finding the desired information.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. Please see a visual of the project [here](http://htmlpreview.github.io/?https://github.com/JoleneGlenn/Data-Analytics-Projects-Practicum/blob/main/13.3_final_analysis_loyalty_program/13_3_final_accepted.html).**

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Carry out exploratory data analysis
4. Test Hypothesis
	- Customers who participate in the loyalty program make larger purchases by price on average
	- Customers who participate in the loyalty program buy more items on average
5. Write a general conclusion

### Libraries used
pandas as pd

numpy as np

matplotlib.pyplot as plt

datetime

seaborn as sns

scipy.stats as st

math as mth

**Error Handling**

sys 

warnings
```
if not sys.warnoptions:
    warnings.simplefilter("ignore")
```

**Display settings:**
```
sns.set_palette('bright')
pd.set_option('max_colwidth', 450)
```

### Project Conclusions
Summary for Project Manager
- The Customer Loyalty Program project manager wants to evaluate the new loyalty program to see if it has lead to an increase in the average purchase size and an increase in the number of items purchased
    - In summary, on average non-loyalty members make larger purchases, purchase more items, and make more purchases compared to loyalty members
    - However if you look at each date individually, on average the purchase prices and number of items purchased varies day to day, some days loyalty members are more on average, some days the non-loyalty members are more on average
- Possible reasons for this include:
    - loyalty members make lower priced purchases because the loyalty program has allowed them to maximize discounts and special offers
    - loyalty members purchase less items and make fewer purchases because in general they are savers - this may be why the signed up for the loyalty program in the first place
    - perhaps the promotions and specials are too restrictive, as in purchase limits and this is preventing the loyalty members from buying more items because then the will be full price
    
Recommendations
- To increase the number of items and purchase sizes, take a look at the way the discounts, specials, deals, promos, etc. are advertised, perhaps the requirements are too restrictive, for example, there is a limit to the number of items that can be used for that coupon and so this is preventing the loyalty member from buying more than the coupon allows.
- To increase the number of members using the loyalty program, re-evaluate the price of the program or increase advertisement along with its benefits

Other Recommendations
- Due to the large number of anomalies there is likely a default in the data collection system and the inventory system. The appropriate teams should be notified that negative and 0 orders are being made/collected and that some items have a price of 0, perhaps this is a typo or the items are discontinued and need to be removed from the inventory list.
- Roughly 34% of customer ids entries are missing from the original data, this could be a valuable metric to use in the future for many different evaluations

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Final Project: Analysis Project. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Data Prep**

Read .csv files as a dataframe
- pd.read_csv()

Identify missing values
- df.isnull().sum() - all rows, df['column'].isnull() - rows in a single column

Find and delete duplicate rows
- Number of duplicate rows: df.duplicated().sum()
- Delete duplicate rows: df.drop_duplicates().reset_index(drop = True)

Fill in missing values 
- df['col'] = df['col'].fillna(value)

Change data types
- df['col_a'] = df['col_a'].astype('object')

Rename columns
- df = df.rename(columns = {'old_col_name': 'new_col_name', ...})

Add a date column
- df['date_col'] = df['datetime_col'].astype('datetime64[D]')

Process Anomalies
- Merge dataframes
	- new_df = pd.merge(df_a, df_b, on = 'col')
- Filter data
	- query_df = df.query('col boolean_expression value')
- Evaluate stats with .describe() method
	- specific column: df['col'].describe()

**Analysis**

Evaluate percentiles
- Create dictionary of percentiles
	- percentile_dict = [#, #, #, ...]
- Find percentile values
	- percentile_values = np.percentile(df['col'], percentile_dict)
- Print the values of the percentiles using a for loop
	- for tile in range(0, len(percentile_dict)):
		- print(percentile_values[tile])
- Make calculations with pivot tables
	- table = df.pivot_table(index = 'col_a', values = 'col_b', aggfunc = 'calculation').reset_index()
	- rename columns
		- table.columns = ['col_a', 'col_b', ...]

**Graphs**

Histograms
- Created a function to graph histograms
- df['col'].hist()

Bar plots
- graph_name = df[['col_a', 'col_b']].plot(kind = 'bar')
- graph_name.set_xticklabels(df['col'], rotation = ##)

**Hypothesis Testing**

Evaluate dispersion of the populations being tested
- np.var(list_of_values)

Test using an independent samples t-test to test the equality of the eans of the two populations
- results = st.ttest_ind(list_1_values, list_2_values, equal_var = True or False)
- True if the dispersion is the same, False if it is not

Calculate p-value
- results.pvalue

Critical statistical significance level
- alpha = 0.05 (common to be between 0.01 - 0.05)

Hypothesis Outcomes
- if results < alpha then null hypothesis is rejected, there is a significant difference between the averages of the populations
- if results > alpha then null hypothesis cant be rejected, there is not a significant difference between the averages of the populations