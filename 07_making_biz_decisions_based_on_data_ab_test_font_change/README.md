### Project title
07. Making Business Decisions Based on Data: A/B Test Analysis to boost revenue

### Project Description
A big online store's marketing department has a list of hypotheses to test that may help boost revenue. 

These hypotheses need to be prioritized, an A/B test launched, and the results analyzed.
	 
### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: There is a table of contents, however it does not have links as I was still learning the syntax of Markdown, so finding the desired information in the formatting may be difficult.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. Please see a visual of the project [here](http://htmlpreview.github.io/?https://github.com/JoleneGlenn/Data-Analytics-Projects-Practicum/blob/main/07_making_biz_decisions_based_on_data_ab_test_font_change/07_biz_decisions_accepted.html).**

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Prioritize the hypotheses
	- ICE framework (Impact, Confidence, Effort/Ease)
	- RICE framework (Reach, Impact, Confidence, Effort/Ease)
4. A/B Test Analysis
	- Cumulative calculations (revenue and orders)
	- Relative difference in cumulative average order size for group B compared to group A
	- Conversion rates as the ratio of orders to the number of visits for each day
	- 95th and 99th percentiles
	- Hypothesis Testing for Raw data and Filtered data
		- Find the statistical significance of the difference in conversion between the groups
		- Find the statistical significance of the difference in average order size between the groups
5. Write a general conclusion and advise the marketing team how to proceed based on the test results.

### Libraries used
pandas as pd

numpy as np

matplotlib.pyplot as plt

datetime

seaborn as sns

stats as st from scipy

**Error Handling:**

sys

warnings
``` 
if not sys.warnoptions:
    warnings.simplefilter("ignore")
```

**Display settings:**
```
pd.set_option('max_colwidth', 450)
```

### Project Conclusions
- 9 hypotheses were prioritized using the RICE method, which accounts for Reach, Impact, Confidence, and Effort of the test
    - hypothesis # 7 scored the highest and tests: 'Add a subscription form to all the main pages.'
- Assuming the data supplied were based on this results of hypothesis # 7, I believe the results of the test are positive because it increased conversion rates by 17%
    - The data provided accounted for a one month test and evaluated conversion rates and average orders size
        - The analysis reveals that there is a significant difference in the conversion rates of a user to a buyer (17%), but not in average order size.
        - There may be a loss in average order size (3%), once outliers are removed, but a longer test may reveal this to be untrue
        	- Based on the unfiltered data, there is no loss, but a gain of 28%

Make a decision based on the test results. The possible decisions are: 1. Stop the test, consider one of the groups the leader. 2. Stop the test, conclude that there is no difference between the groups. 3. Continue the test.

- Recommendation based on the results:
	- If the goal of the test was to increase conversion rate:
		- Stop the test, the results for Group B can be considered positive because the conversion rate is higher (17% based on filtered data) than Group A
	   	- while there is no statistical difference in the average order size, the increase in conversion may not be paying off yet
	- If the goal of the test was to increase average order size:
	   	- Continue the test to see if the average order size improves for Group B 
	    	- with the results from one month and the filtered data, it appears that Group B may be bringing in less than Group A (about 3% less based on filtered data). However, orders tend to occur once per month per user, so two or three months of the test may provide more information for the long term order size

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Making Business Decisions Based on Data sprint. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Data Prep**

Read .csv files as a dataframe with parse_dates
- pd.read_csv('file.csv', parse_dates = ['date_col'])

Identify missing values
- df.isnull().sum(), df['column'].isnull()

Find and delete duplicate rows
- Number of duplicate rows: df.duplicated().sum()

Rename columns
- df = df.rename(columns = {'col_orig_name': 'col_new_name'})
- df = df.rename(columns = str.lower)

Create a series to find users in both groups
- group_count_df = df.groupby('col_a').agg({'col_b': 'nunique'}).reset_index()
- users in with a unique value > 1 are in more than one group
	- use df.query() to isolate the users in both groups
	- determine their impact on the total to decide on removal or processing

Optimize numeric data - suggested by reviewer
- downcast parameter for to_numeric() method will automatically determine the most compatible regime to numeric data:
	- df['col'] = pd.to_numeric(df['col'], downcast = 'integer')

**Analysis**

Calculate ICE score (Impact, Confidence, Effort/Ease)
- df['ice'] = (df['impact'] * df['confidence'] / df['effort']).round(2)

Calculate RICE score (Reach, Impact, Confidence, Effort/Ease)
- df['rice'] = (df['reach'] * df['impact'] * df['confidence'] / df['effort']).round(2)

Cumulative calculations
- df.pivot_table().cumsum()

Calculate Relative difference in cumulative average order size
- df['relative_diff_b'] = (df['cum_rev_b'] / df['cum_orders_b'])  / (df['cum_rev_a'] / df['cum_orders_a']) - 1

Calculate Conversion rates - user to buyer
- df['conversion_a'] = df['cum_orders_a'] / df['cum_visits_a']

Calculate the 95th and 99th percentiles
- outliers = np.percentile(df['col'], [95, 99])

**Hypothesis Testing**
Test the raw and filtered data

Remove the anomalies/outliers to test the filtered data

Group users by test group

Create a series with the order value for all visits (could be 0 or >0)

Run the Mann-Whitney U test
- results = st.mannwhitneyu(x, y)[1] # returns the second value, which is the p-value

Calculate the conversion gain for Group B
- (coversion_b.mean() / conversion_a.mean() - 1) * 100

**Graphs**

Bar graphs
- graph = df[['col_a', 'col_b']].plot(kind = 'bar')
- graph.set_xticklabels(df['col_c'])

Line graphs
```
	df.plot()
	plt.legend()
	plt.grid() - adds lines to the graphs for easier visualization
	add x axis: plt.axhline(y = 0 or #, color = 'black', linestyle = '--')
		when graphed for conversion rates, can change x axis line color to match the data it applies to and the line style to be different '--' vs '-.' for example
		Suggestion from Reviewer - use the average of the conversion values as the x-axis/stabilization value for each group
			ex: plt.axhline(y=cum_data.query('date > "2019-08-14"')['conversion_b'].mean(), color='orange', linestyle='-.', label = 'stabilization value for Group B')
				plt.axhline(y=cum_data.query('date > "2019-08-14"')['conversion_a'].mean(), color='blue', linestyle='--', label = 'stabilization value for Group A')
```

Scatter Plots
- split the groups via .query() method and calculate desired info for both separately
- create x values for each group the graph based on the length of the df
	- x_values_a or x_values_b = pd.Series(range(0, len(df)))
- plot both sets on same graph each with slightly different size dots to see overlapping dots better
	- plt.scatter(x_values_a, y = df_a['col'], c = 'coral', alpha = 0.7, s = 50, label = 'Group A')
	- plt.scatter(x_values_b, y = df_b['col'], c = 'lightblue', alpha = 0.7, s = 35, label = 'Group B')