### Project title
06. Business Analytics: Optimize Yandex.Afisha's marketing expenses

### Project Description
Using the server logs of user visits from January 2017 - December 2018, the dump files with user orders, and marketing expenses statistics examine how users use the product, conversion rates (when they start to buy), lifetime value, LTV (how much money each customer brings), customer acquisition cost, CAC, and return on marketing investment, ROMI (when the user pays off)

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: There is a table of contents, however it does not have links as I was still learning the syntax of Markdown, so finding the desired information in the formatting may be difficult.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Analyze the data
	- Product
	    - DAU, WAU, MAU (daily, weekly, monthly active users)
	    - Sticky factors
	    - Retention rates
	- Sales
		-Conversion rates
		- LTV (lifetime value)
	- Marketing
		- CAC (Customer Acquisition Cost)
		- ROMI (Return on Marketing Investment)
4. Write a general conclusion and advise the marketing experts how much money to invest and where

### Libraries used
pandas as pd

numpy as np

matplotlib.pyplot as plt

datetime

seaborn as sns

**Error Handling**
sys

warnings
```
if not sys.warnoptions:
    warnings.simplefilter("ignore")
```

### Project Conclusions
- monthly retention rate is low (cohort user retention rate per month)
- cumulative cohort ltv is quite low, it takes several months for a customers value to double with the exception of a few cohorts in this study (cohort ltv (cumulative) - cohorts based on first order month)
- ad source 3 costs the most followed by 4, 5 and 2, least 1, 10 and 9 (ad cost per source)
- ads cost the most between Oct - Dec, followed by Jan - Mar (ad cost per month), least from late spring through summer
- ad source 3 and 2 cost the most per customer acquisition, followed by 5, 1, and 4 (ad cost per customer acquisition - based on buyers vs users - Version 3)
- ad sources 1, 2, 9, 5, and 4 have the highest ROMI, 3 has the least (ROMI for each ad source)
- only 2 cohorts have had a ROMI, the 1st and the 4th (ROMI for each cohort based on first order month)
    - considering the 2nd and 3rd have not had a return on investment but the 4th has, the marketing strategy may need to be re-evaluated
- the desktop device is used more than the touch device, both are used the most during Oct - Mar (device type usage per month)
- ad sources 4, 3, and 5 get the most attention from users (number of ads from each ad source per month) and follow a similar trend as the desktop device usage
    -  this is shown more clearly in this graph: ad source used by customers per device type
    
Suggestions based on information:
- ad source 3 costs the most monetarily and per CAC and yet has the worst ROMI, consider evaluating this source for removal
- while ad source 9 has a low cost per CAC and brings a profit (ROMI), it doesn't get much attention by users, while this may be an attractive option at first, it may not pay out well in the end
- ad sources 4, 5, 2, and 1 get a lot of attention, although they cost a bit more ($ and CAC), they also bring in a profit (ROMI), maintain focus on these sources for both device types (desktop and touch)

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Business Analytics sprint. 
Practicum provided the data set and the project requirements. 
My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Data Prep**
Read .csv files as a dataframe with parse_dates
	pd.read_csv('file.csv', parse_dates = ['date_col'])

Identify missing values
	df.isnull().sum(), df['column'].isnull()

Find and delete duplicate rows
	Number of duplicate rows: df.duplicated().sum()

Rename columns
	df = df.rename(columns = {'col_orig_name': 'col_new_name'})

Remove row of data out of scope of analysis
	df.drop(df.index[#], inplace = True)
		ex: remove last row of df
		df.drop(df.index[-1], inplace = True)

**Analysis**
**Product**
Create needed datetime columns
- df['col_b'] = pd.to_datetime(df['col_a'].dt.date)
	- alternative for a complete date: df['col_b'] = df['col_a'].astype('datetime64[W]')
- df['col_c'] = df['col_a'].dt.week
	- alternative for a complete date: df['col_c'] = df['col_a'].astype('datetime64[W]')
- df['col_d'] = df['col_a'].astype('datetime64[M]')

DAU, WAU, MAU (daily, weekly, monthly active users with calculation 'nunique')
Aggregate functions 
- df.groupby('col_a').agg({'col_b': 'calculation'}).reset_index()
	- ex 'calculation's: 'nunique', 'mean', 'sum' etc.
	- could also be a dict with list: .agg({'col_b': ['nunique', 'mean', 'sum']})

Round values
- int(df['col'].mean().round())

Describe method
- df.describe()

Datetime seconds
- df['seconds_col'] = (df['end'] - df['start']).dt.seconds / 60

Filter tables
- df.query()

Sticky factors = how often do users come back
- weekly % return: (dau_avg / wau_avg * 100).round(2)
- monthly % return: (dau_avg / mau_avg * 100).round(2)

Retention rates
```
# Find first session date per user
	session_min = df.groupby('user_id').agg('session_date': 'min').reset_index()
# Rename columns
	session_min.columns = ['user_id', 'first_session_date']
# Change min date column to month column
	session_min['first_session_month'] = session_min['first_session_date'].astype('datetime64[M]')
# Merge with user info dataframe
	user_info = pd.merge(df, df_min, on = 'user_id')
# Calculate cohort age
	user_info['cohort_age'] = user_info['session_month'] - user_info['first_session_month']
	user_info['cohort_age'] = ((new_df['cohort_age'] / np.timedelta64(1, 'M')).round()).astype('int')
# Calculate cohort size
	cohort_size = user_info.groupby(['first_session_month', 'cohort_age']).agg({'user_id': 'nunique'}).reset_index()
# Calculate number of initial users at the beginning of each cohort
	start_cohort_size = cohort_size[cohort_size['cohort_age'] == 0][['first_session_month', 'cohort_users']]
	Rename columns:
		start_cohort_size = start_cohort_size.rename(columns = {'cohort_users': 'initial_cohort_size'})
# Merge with user info dataframe
	retention_df = pd.merge(cohort_size, start_cohort_size, on = 'first_session_month')
# Calculate the retention
	retention_df['retention'] = retention_df['cohort_users'] / retention_df['initial_cohort_size']
# Create table of retention rates
	retention_table = retention_df.pivot_table(index='first_session_month', columns = 'cohort_age', values = 'retention', aggfunc = 'sum').fillna('')
```
		
**Sales**
Find the conversion time in minutes
- Create df with first session date and create df wtih first order date, merge into one table.
- Create new column with conversion date
	- df['conversion_day'] = (df['first_order_date'] - df['first_session_date']).dt.total_seconds() / 60

LTV (lifetime value)
- Create a series (new df using .groupby() and .agg().reset_index()) of first order month and calculate the number of unique buyers in each first order month, merge with order info.
- Create a series of to calculate the cohort revenue based on the first order month.
- Join tables.
- Calculate the cohort age: order month - first order month 
- Calculate the LTV for each month per cohort: cohort revenue / number of original/unique buyers
- Create a table of the cumulative sum of the cohort
	- ltv_table = df.pivot_table(index = 'first_session_month', columns = 'cohort_age_month', values = 'ltv', aggfunc = 'mean').cumsum(axis = 1).fillna('')

**Marketing**
CAC (Customer Acquisition Cost)
- create a series or new df of the first session date of a user
- first_session_date = df.loc[df.groupby('user_id').session_start.idxmin()].reset_index()
- Create a new df with the ad source, user id and first session date
- Calculate total revenue per user
- Merge ad source/first session per user with revenue per user (pd.merge())
- Calculate the number of buyers per ad source
	- Add to cost per source table

Calculate CAC
- cost per source / # buyers per source

ROMI (Return on Marketing Investment)
- Calculate revenue per ad source
- Merge with cost per ad source
- Calculate the ROMI: revenue per source / cost per source
	- Value of 1 means company broke even, above 1 means profits, below 1 means losses.

**Graphs**
Histogram
- df['col'].hist(bins = #)

Heatmap of retention rates and cohort ltv (cumulative)
- plt.figure(figsize = (#, #))
- sns.heatmap(retention_table, annot = True, fmt = '.1%', linewidths = 1, linecolor = 'gray', vmin = 0, vmax = 0.1)

Bar graphs
- bar_graph = df['col'].plot(kind = 'bar')
- bar_graph.set_xticklabels(df['col_a'])

Line graphs
- table.plot()