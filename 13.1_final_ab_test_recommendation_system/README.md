### Project title
13.1. Final Project: A/B Testing Project

### Project Description
Analyze the results of an A/B test for an international online store using the technical specifications and test results are provided.

Test changes related to the introduction of an improved recommendation system to see if within 14 days of signing up there is at least a 10% conversion increase at each stage of the the funnel: `product_page → product_card → purchase` 

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: There is a table of contents with Markdown links to assist in finding the desired information.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. There may have been several ways to interpret the data provided based on the technical requirements. I interpreted the data/results to not match with the technical requirements. Due to the nature of the coding program I did not have a manager or team-lead to discuss these discrepancies and it was encouraged to create a report and wait for the code reviewer to provide feedback. If this was a project I had been assigned in a real life situation, I would have discussed these issues with my manager before moving forward to save time and effort and to make sure the data and technical requirements were correct.
5. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. Please see a visual of the project [here](https://nbviewer.org/github/JoleneGlenn/Data-Analytics-Projects-Practicum/blob/main/13.1_final_ab_test_recommendation_system/13_1_ab_test_accepted.html).**

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Carry out exploratory data analysis
4. Evaluate the A/B test results
5. Write a general conclusion

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

**Display settings:**
```
sns.set_palette('bright')
pd.set_option('max_colwidth', 450)
```

### Project Conclusions
Project Description and Goal
- Evaluate the results of an A/B test that is testing the changes related to the introduction of an improved recommendation system to see if within 14 days of signing up there is at least a 10% conversion increase at each stage of the the funnel
- The following hypotheses were tested: 
    - Null Hypothesis:
        - The conversion rate in the funnel stages are statistically the same between test groups
    - Alternative Hypothesis:
        - The conversion rate in the funnel stages are statistically different between test groups

Review of the Technical description
- **There are several errors in the original technical description**

- **Update** Test name: `interface_eu_test` 
    - It is likely that using `recommender_system_test` is a typo because very few users came from this test group and this test has a mix of users from different regions where as below the target audience is for the EU region, which is where most of the users are from in the `interface_eu_test` data set
- Groups: 
    - А (control)
    - B (new payment funnel)
- **Updated** date information
    - Launch date: 2020-12-07
    - Last appropriate day to evaluate new users: 2020-12-16 (vs 2020-12-21)
        - Ultimately the due to the last day of data collection being the 30th, the cut off to evaluate new users had to be the 16th to have a full 14 days of data collection, any user collected after th 16th did not have enough days of data collection
    - End date: 2020-12-30 (vs 2021-01-01)
- Audience: 15% of the new users from the EU region
- Purpose of the test: testing changes related to the introduction of an improved recommendation system
- **Updated** Expected result: within 14 days of signing up, users will show better conversion into login page views (the `login` event), product page views (`product_page`) and purchases (`purchase`). At each of the stage of the funnel `login → product_page → purchase`, there will be at least a 10% increase.
    - These are likely the stages in the funnel with a optional `product_cart` stage
    - **These stages are not appropriate for the data we were given**: `product_page → product_card → purchase`
    - V2: Likely funnel: login page views (the `login` event), product page views (`product_page`), product cart views ('product_cart'), and purchases (`purchase`). At each of the stage of the funnel `login → product_page → product_cart → purchase`
- Expected number of test participants: 6000
    - After data processing and clean up 5711 users were evaluated in the `interface_eu_test`

Project Conclusions
- The data was processed and analyzed (EDA)
- Through analysis several errors in the technical description were found - updated above
    - due to errors in the collection methods 43% of the users in the tests were removed and several days worth of event data
- A z-criterion test was performed to check the statistical difference between the proportions
    - 2 different tests were run
        - 1 for the mix of tests: `interface_eu_test` and `recommender_system_test`
        - 1 for the `interface_eu_test` only
        - ***Results*** both tests had the same result for all event stages - there is not a significant difference between the proportions of experiments
            - this implies that the new recommendation service being offered by the online store is not creating a difference in conversion between stages of the event funnel
            
Recommendations
- It may be appropriate to re-evaluate the `interface_eu_test` because of the poor data collection methods
    - if the correct data is provided and for a long enough collection period for all of the users in the correct test, the results may be different
- If a re-evaluation is not desired then the results show that the new recommendation system is not performing as expected by increasing conversion. It is, however, performing statistically the same as the current system
    - so you could continue with the current system or switch to the new system with no change
    - if an improvement is still desired, then a different model for the recommendation system should be designed and tested

-  V2: After performing tests with the Bonferroni Correction method, it was determined that there is a statistically significant difference between Groups A and B in the `purchase` stage, but not in the other stages. 
    - However I believe it is not in desired direction, i.e. Group A is performing better in this stage.
    - My original recommendations remain the same

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Final Project: A/B Testing Project. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Data Prep**

Read .csv files as a dataframe
- pd.read_csv()

Identify missing values
- df.isnull().sum(), df['column'].isnull()

Remove missing or null values
- df.dropna(subset = ['col_a', 'col_b', 'col_c', ...]).reset_index(drop = True)

Find duplicate rows
- Number of duplicate rows: df.duplicated().sum()

Change data types
- df['columna'] = pd.to_datetime(df['columna'])

Rename columns
- df = df.rename(columns = {'orig_col_name': 'new_col_name', ...})

Fill in missing values
- df['col'] = df['col'].fillna(value)

**Analysis**

Filter data using queries
- df.query('col boolean_expression values')

Queries using data from another table or list
- df.query('col boolean_expression @df.col_name')

Merge dataframes
- new_df = pd.merge(df_a, df_2, on = 'col')

Find min and max values
- df['col'].min() or .max()

Calculate the percent change from stage to stage in the event funnel
- df['perc_change'] = round(df['event_occurance'].sort_values(ascending = False).pct_change(periods = 1) * 100, 0).fillna(0)

Create a date column
- df['date_col'] = df['datetime_col'].dt.date

Make calculations using pivot tables
- df.pivot_table(columns = 'col_a', index = 'col_b', values = 'col_c', aggfunc = 'calculation').reset_index()
	- rename columns

Create a new table by transposing a df with the row of interest only
- new_df = df.head(1).T

Filter out the first row (column name & value from untransposed table)
- new_df = new_df.iloc[#:, :].reset_index()

Reset the index
- new_df.reset_index(drop = True)

Rename the columns
- new_df.columns = ['col_a', ...]

Rename the values in the rows
- new_df['col_a'] = new_df['col_b'].replace({'old_val_a': 'new_val_a', ...})

**Hypothesis Testing**

- Create a function to run two proportions z-test
- Multiple-comparison correction for the alpha value
	- Bonferroni Correction - use as alpha in multiple testing situations
		- bon_correction = desired_alpha / num_tests
	- FWER = 1 - (1 - bon_correction) ** num_tests

**Graphs**
Bar plots
- graph_name = df.plot(kind = 'bar')
- graph_name.set_xticklabels(df['col'], rotation = 45, ha = 'right')

Label bars with data
```
for bar in graph_name.patches:
    graph_name.annotate(format(bar.get_height(), '.0f'), 
                xy=(bar.get_x() + bar.get_width() / 2, bar.get_height()), 
                ha = 'center', 
                va = 'center', 
                xytext = (0, 7), 
                textcoords = 'offset points')
```

Funnel charts
- funnel_chart = go.Figure(go.Funnel(y = list(df['col_a']), x = list(df['col_b'])))
- Display multiple funnel charts in same graph
```
fig = go.Figure()
fig.add_trace(go.Funnel(name = 'name_a', y = list(df['col_a']), x = list(df['col_b'])))
fig.add_trace(go.Funnel(name = 'name_b', y = list(df['col_a']), x = list(df['col_c'])))
fig.show()
```

Line graphs
- graph_name = df.plot()
- manually set the x ticks: 
	- plt.xticks(np.arange(df.shape[0])[::1]) - this set one tick for each row in the df
- graph_name.set_xticklabels(list(df['date_col']), rotation = 45, ha = 'right')