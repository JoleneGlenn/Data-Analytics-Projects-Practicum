### Project title
04. Integrated Project 1: Identify patterns that determine game success

### Project Description
Ice, an online store, sells video games all over the world. Identify patterns that determine whether a game succeeds or not using open source data on user and expert reviews, genres, platforms, and historical data on game sales.

The evaluation of the data will be used to plan an advertisement campaign for the following year.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: This is one my very first coding projects, it contains details on the project and the work I performed, however it does not have a table of contents and I was still learning the syntax of Markdown, so finding the desired information in the formatting may be difficult.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. Please see a visual of the project [here](http://htmlpreview.github.io/?https://github.com/JoleneGlenn/Data-Analytics-Projects-Practicum/blob/main/04_integrated_project_1_video_game_patterns/04_ip1_accepted.html).**

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Analyze the data
4. Create a user profile for each region
5. Test the hypotheses
	- Average user ratings of the Xbox One and PC platforms are the same.
	- Average user ratings for the Action and Sports genres are different.
6. Write a general conclusion

### Libraries used
pandas as pd

numpy as np

matplotlib.pyplot as plt

datetime

math as mt

stats as st from scipy

reduce from functools

**Error Handling**

sys

warnings
```
if not sys.warnoptions:
    warnings.simplefilter("ignore")
```

### Project Conclusions
Hypothesis Results
- Average user ratings of the Xbox One and PC platforms are statistically the same. XOne: 6.60 vs PC: 6.31 
- Average user ratings for the Action and Sports genres are different. Action: 6.75 vs Sports: 5.29

Patterns
- From 2014 - 2016: 
- Platforms: 
    - the following platforms had the greatest sales:
        - PS4, XOne, 3DS, PS3, X360
    - the least sales were for:
        - WiiU, PC, PSV, Wii, PSP
    - NA, EU, and JP share the same top 3 sales: PS4, 3DS, PS3: playstation and nintendo
    - NA & EU had different platforms perform well
        - NA and EU have the same top 4 sales: PS4, XOne, 3DS, PS3
            - X360 and PC are in NA and EU top 5, respectively
            - these regions have top sales in a range of companies: playstation, xbox, pc, nintendo
    - JP sales top sales also include PSV and WiiU (including PS4, 3DS, PS3)
        - this region has top sales in 2 companies, playstation and nintendo
- Genres:
    - Based on average sales, Shooter genre makes the most, with Sports genre in second (about 1/2 of Shooter), all others are under 0.6 million
    - the following genres had the greatest sales (NA, EU & JP regions):
        - Action and Role Playing genres have the most sales
        - NA, EU have the same top 4 genres: Action, Shooter, Sports, Role Playing
            - shooter and sports do not do well in JP
        - JP has 2 top selling genres: action and role playing
    - There doesn't appear to be a life span for genres, however there does appear to have peaks, this could be due to specific game releases and popularity
    - there may be a correlation between platform and genre performance because certain platforms may be known and popular for specific genres

- 2017 campaign
	- I recommend to focus on:
	    - Focus on the top popular genres and next generation platforms (which havent reached their peak sales or lifespan) for each region:
	        - NA & EU: 
	            - genres: action, shooter, sports, role playing
	            - platforms: PS4, XOne, 3DS
	        - JP: 
	            - genres: action and role playing
	            - platforms: PS4 and 3DS

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for Integrated Project 1. 

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

Find and delete duplicate rows
- Number of duplicate rows: df.duplicated().sum()
- Delete duplicate rows: df.drop_duplicates().reset_index(drop = True)

Change data types
- df['col_a'] = df['col_a'].astype(int/float)
- df['columna'] = pd.to_datetime(df['columna'])

Change letter case to lower
- df.columns = df.columns.str.lower()

Replace out of place value
- df['col'] = df['col'].replace('value_to_replace', new_value)
	- ex: games['user_score'] = games['users_score'].replace('tbd', None)

**Analysis**

Create new columns with requested calculation

Filter data
- df.query('col boolean_expression value')
- df.query('col in @list_of_col_values')

Remove rows with specific requirements
- df.drop(df[df['col'] == val].index, inplace = True)

Examine stats of a column
- df['col'].describe()

Create pivot tables
- pivot_table = df.pivot_table(index, columns, values, aggfunc)

Correlation
- df['col_a'].corr(df['col_b']) - helpful when using scatter plots to show linear dependency between variables (positive or negative or 0/none)

Make list from a df column
- list_a = list(df['col'])

**Graphs**

Bar plots
- table.plot(kind = 'bar')

Box plots
- df.boxplot(column = 'col_a', by = 'col_b')
- plt.ylim(#, #) - zooms in to see the box details more closely

Scatter plots
- df.plot(kind = 'scatter', x = 'col_a', y = 'col_b')

**Hypothesis Testing**

Calculate Dispersion
- np.var(list)

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