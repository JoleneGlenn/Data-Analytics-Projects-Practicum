### Project title
08. How to tell a story using data: Market Research on Los Angeles Restaurants

### Project Description
A group of partners wants to open a small robot-run cafe in Los Angeles. The project is promising but expensive.

Using open-source data on restaurants in LA prepare a report and presentation on current market conditions to show the chance of success and attract investors.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: There is a table of contents, however it does not have links as I was still learning the syntax of Markdown, so finding the desired information in the formatting may be difficult.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. If there is please see the HTML file for a visual of the project.**

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Analyze the data
4. Prepare a presentation with conclusions and suggestions

### Libraries used
pandas as pd

numpy as np

matplotlib.pyplot as plt

datetime

seaborn as sns

stats as st from scipy

graph_objects as go from plotly


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
```

### Project Conclusions
- Market research was performed on open-source data on restaurants in LA
- The team is investigating opening a cafe with robot servers with an interest in creating a chain establishment

- Establishment types, chain/non-chain establishments, and number of seats were evaluated
- The top 10 streets with the most establishments were investigated specifically

General Conclusions
- There are 6 types of establishments in this data set
	- 75% are restaurants
	- 4.51% are cafes
- The data consists of chains and non-chain establishments
	- 38% are chains, 62% are not chains
	- 61% of cafes are a part of chains
	- Most chains have 50 seats or less
		- Cafes on average have 25 seats
- The top 10 streets 
    - have 155 - 305 establishments per street
        - 35.6% of them are chains
        - Most of them have 50 seats or less
	- 4% of these are cafes (82)
		- each street has between 2 - 21 cafes
	- W Sunset Blvd and W Pico Blvd have the two highest amount of establishments of 305 each, followed by Wilshire Blvd with 223
		- These three streets also have the most cafes on them 21, 11, and 11 respectively

Overall
- There is not a lot of competition for cafes
- Most cafes are chains and have on average 25 seats
- The streets with the most cafes also have the most establishments in general
    - this suggests that there is a high demand for food places on these streets perhaps due to tourism, shopping, or business needs

Recommendations
- According to this data set, cafes do not have a lot of competition (compared with restaurants), so this may be a safe type to begin with 
- Focus on locations that have a lot of foot traffic, shopping, or other popular places to visit
    - For example: Google says Sunset Blvd is a 'Legendary road for nightlife and landmarks', suggesting there is a lot of people that visit the area
    - Similarly W Pico and Wilshire Blvds also have major shopping and attraction centers
- Look for or build locations that can accomodate 30 - 50 people
- Most cafes are not a part of a chain, however due to the interesting nature of a cafe with robots, this may be feasible after a pilot with one location

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the How to Tell a Story Using Data sprint. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Data Prep**

Read .csv files as a dataframe
- pd.read_csv()

Identify missing values
- df.isnull().sum() - all rows, df['column'].isnull() - rows in a single column, could also do multiple columns df.[['col_a', 'col_b']].isnull().sum()

Find and delete duplicate rows
- Number of duplicate rows: df.duplicated().sum()

Find missing values
- null_query = df.loc[df['col'].isnull()]

Fill in missing values
- df.loc[df['col'].isnull, 'col_to_fill'] = value_to_fill_in 

Change data types
- df['col_a'] = df['col_a'].astype('category'/'bool')
- df['col_b'] = pd.to_numeric(df['col_b'], downcast = 'integer')

Rename columns
- df = df.rename(columns = {'old_col_name': 'new_col_name'})
- df.columns = ['col_a', 'col_b', ...]

**Analysis**

Create series using .groupby and .agg()
- new_df = df.groupby('col_a').agg({'col_b': 'calculation'}).reset_index()

Combine tables
- new_df = pd.merge(df_1, df_2, on = 'col')

Reviewers Suggestion to get around calculating separate series and merging
- cafe_data.replace({'True': 1, 'False':0}).groupby('location_type')['chain'].agg(['sum','count', lambda x: '{:.2%}'.format(x.mean())]).rename(columns={'sum':'Chain', 'count': 'All Establishments'})

Create queries
- new_df = df.query('col boolean_expression value')

Describe method for stats
- df['col'].describe()
- df.describe()

Isolate sections of strings
- df[['new_col_x', 'new_col_y']] = df['col_a'].str.split(n = 1, expand = True)
- df['new_col_y'] = df['new_col_y'].str.rstrip('letters or numbers')
- df['new_col_y'] = df['new_col_y'].str.lstrip('"letters or numbers"')

Create a sorted df
- sorted_df = df.sort_values('col', ascending = True or False).reset_index()

**Graphs**

Bar plots
- plt.figure(figsize = (#, #))
- graph_name = sns.barplot(data = df, x = 'col_a', y = 'col_b', order = df.sort_values('col_b').col_a)
- graph_name.set_xticklabels(labels = df['col'], rotation = #)
	- reviewer suggestion: plt.xticks(rotation = #)

Bar plots with 2 data points
Include hue parameter
- plt.figure(figsize = (#, #))
- graph_name = sns.barplot(data = df, x = 'col_a', y = 'col_b', hue = ' col_c', edgecolor = 'w')

Include counts above bars
```
	for bar in graph_name.patches:
	    graph_name.annotate(format(bar.get_height(), '.0f'), 
            xy=(bar.get_x() + bar.get_width() / 2, bar.get_height()), 
            ha = 'center', 
            va = 'center', 
            xytext = (0, 7), 
            textcoords = 'offset points')
```

Pie Charts
- graph_labels = df['col_a']
- graph_values = df['col_b']
- pie_graph = go.Figure(data = [go.Pie(labels = graph_labels, values = graph_values)])
- pie_graph.update_layout(title = 'title')
- pie_graph.show()

Distribution plot - shows distribution/density
- plt.figure(figsize = (#, #))
- sns.distplot(df['col'], bins = #)

Scatter plots
- plt.figure(figsize = (#, #))
- sns.scatterplot(data = df, x = 'col_a', y = 'col_b', label = 'col_c')

Correlation Graph
- graph_name = sns.jointplot(data = df, x = 'col_a', y = 'col_b', kind = 'reg')