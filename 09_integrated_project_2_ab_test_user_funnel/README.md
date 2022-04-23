### Project title
09. Integrated Project 2: A/A/B Test Analysis of User Funnel - Font change test

### Project Description
A start up that sells food products has results of an A/A/B Test that need to be evaluated. Before the designers change the font for the entire app, the managers requested the test to ensure users do not find the new design intimidating. 

Use the sales funnel to investigate user behavior for the company's app to see which font produces better results.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: There is a table of contents with Markdown links to assist in finding the desired information.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. If there is please see the HTML file for a visual of the project.**

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Analyze the data
4. Write a general conclusion

### Libraries used
pandas as pd

numpy as np

matplotlib.pyplot as plt

datetime

seaborn as sns

graph_objects as go from plotly

scipy.stats as st

math as mth

**Error Handling:**

sys

warnings
```
if not sys.warnoptions:
    warnings.simplefilter("ignore")
```

**Display Settings**
```
sns.set_palette('bright')
pd.set_option('max_colwidth', 450)
```

### Project Conclusions
- User behavior on company app was examined in this report
- Sales/event funnel was evaluated
- A/A/B test on font styles were performed

General Information
- The data evaluates 3 groups: 2 controls, 1 test
	- the data covers 7 days: 2019-08-01 to 2019-08-07
	- the data accounts for 7551 unique users
		- the number of users per group are not quite evenly split (1% or less difference is preferred)
			- controls 246 and 247 have a 1.17 % difference
			- control 246 vs test 248 have a 2.1% difference
			- control 247 vs test 248 have a 0.96% difference
            
Sales/Event Funnel
- The data reveals a general sales/event funnel:
    - 1. MainScreenAppear
    - 2. OfferScreenAppear
    - 3. CartScreenAppear
    - 4. PaymentScreenSuccessful
    - Tutorial is optional
- 47% of users make it to PaymentScreenSuccessful
    - this is a little bit less than half of users, so there is room for improvement
    - however nearly 95% of users who add something to their cart end up making a purchase
- 38% of users leave before making it to the OfferScreenAppear page

A/A/B test on font styles
- The following tests were performed:
	- A/A
	- A1/B
	- A2/B
	- A1+A2/B
- Initially these test were performed without the Bonferroni Correction.
    - this resulted in 15 tests (excluding the A/A tests) 
    - and revealed that there are no statistical differences between the groups for any of the actions in the funnel
        - suggesting the font change does not affect user behavior
  
- The Bonferroni Correction was calculated:
    - 0.536708769840247
		- which suggests a 53.67% probability of at least one false positive result out of 15 tests
    - after performing the tests with the Bonferroni Correction:
		 - 8 out 15 were revealed to be false positives, i.e. the null hypothesis was rejected and there was a significant difference between the groups
		 - due to this one may think that the font actually does impact user behavior, ***however*** 7 of these false positives involved data between control group 246 vs test group 248 which has a 2% difference in amount of users:
            - 4 out of 5: 246 vs 248 (A1/B)
            - 3 out of 5: 246 +247 vs 248 (A1+A2/B) 
		 - the test comparing control group 247 vs test group 248 has only 1 false positive.
             - while this false positive does occur on the MainScreenAppear, which is likely the first page users see, it is likely not affecting user behavior since there is no difference in the amount of purchases being made between these groups

General Conclusion
- Ultimately I do not think the fonts are affecting user behavior
- However I think that one of the control groups was not collected properly for comparison against the test group
	- this is supported when the two control groups are tested with the Bonferroni Correction, this leads to 3 out of 5 false positives including the PaymentScreenSuccessful action
    
Recommendations
- one of two things can happen going forward
    - 1.  Accept the results of control group 247 vs test 248 suggesting that fonts do not change user behavior
    - 2. Redo the tests with A/A test data more accurately collected

Report conclusion update post completion of the DA program
- The reviewer from Project 12.1 (Final Project: A/B Test Project) explained that calculated the Bonferonni Correction incorrectly, which was similar to how I ran my calculations in this project.

Updates to the summary above
	- The correct Bonferonni Correction value is:
	    - 0.0033333333333333335
	    - calculated by the desired_alpha / num_tests
	- The correct FWER (not the Bonferonni Correction) is 0.04885001789563237
	    - which suggests about a 5% probability of at least one false positive result out of 15 tests
	- With the correct significance leve the results of ALL the tests fail to reject the null hypothesis, there is not a significant difference between groups. The font change does not affect user behavior

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the How to Tell a Story Using Data sprint. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Data Prep**

Read .csv files as a dataframe
- df. = pd.read_csv('pathway')

Identify missing values
- df.isnull().sum(), df['column'].isnull()

Find and delete duplicate rows
- Number of duplicate rows: df.duplicated().sum()
- Delete duplicate rows: df.drop_duplicates().reset_index(drop = True)

Change unix timestamp to datetime
- df['date_col'] = pd.to_datetime(df['date_col'], unit = 's')

Create date and time columns
- df['col_a'] = df['col_a'].astype('datetime64[D]')
- df['col_b'] = df['col_b'].dt.time

Rename columns
- df = df.rename(columns = {'old_col_name': 'new_col_name', ...})

**Analysis**

Pivot Tables
- table = df.pivot_table(index = , columns = , values = , aggfunc = , margins = True, margins_name = 'name')

Min and Max dates
- df['date_col'].min().date()
- df['date_col'].max().date()

Filter data with queries
- df.query('col boolean_expression value').reset_index(drop = True)

Find unique values
- df['col'].nunique()
- filters/create a new series
	- new_df = df.groupby('col_a').agg('col_b': 'nunique'}).reset_index()

**Funnel Analysis**

It is better to use unique user data to evaluate the funnel, i.e. number of unique users per event / total number of unique users * 100 = % of users per event
- the evaluation of the total number of each event is incorrect because users could do each event multiple times

Calculate the ratio of users from stage to stage of the event funnel
- Order the funnel
	- df.sort_values(by = 'perc_users', ascending = False).reset_index(drop = True)
- Calculate percent change with .pct_change() method
	- df['perc_change'] = round(df['col_a'].sort_values(ascending = False).pct_change(periods = 1) * 100, 0).fillna(0).sort_values(by = col_a', ascending = False)

**A/A/B Test Analysis**

Create a function to run two proportions z-test
- iterate over each event (for loop)
- define the successes for tests a and b
- define the trials for tests a and b
- calculate proportions of success for each test 
	- success / trials
- success proportion in combined data set
	- success_a + success_b / trial_a + trial_b

Calculate the Bonferroni Correction
- bonferonni_correction = desired_alpha / num_tests
	- use this value as the alpha for multiple testing (Making several comparisons with the same data)

Calculate the FWER
- fwer = 1 - (1 - bonferonni_correction) ** num_tests

**Graphs**

Bar plots
- graph_name = sns.barplot(data = df, x = df['date_col'].dt.date, y = 'col_b')
- Add values above bars:
```
for bar in graph_name.patches:
    graph_name.annotate(format(bar.get_height(), '.0f'), 
                xy=(bar.get_x() + bar.get_width() / 2, bar.get_height()),
                ha = 'center', 
                va = 'center', 
                xytext = (0, 7), 
                textcoords = 'offset points')
plot with graph ordered:
graph_name = sns.barplot(data = df, x = 'col_a', y = 'col_b', order = df.sort_values(by = 'col_b', ascending = False).col_a)
```

Pie Charts
- plt.figure(figsize = (#, #))
- plt.pie(x = df['col_a'], labels = df['col_b'], autopct = '%.0f%%', textprops = {'fontsize': 15})

Funnel Charts
- funnel_graph = go.Figure(go.Funnel(y = list(df['col_a']), x = list(df['col_b'])))
- funnel_graph.update_layout(title = 'title')
- funnel_graph.show()