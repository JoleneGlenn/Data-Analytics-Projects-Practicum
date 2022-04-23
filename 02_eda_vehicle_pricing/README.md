### Project Title
02. Exploratory Data Analysis: Determine Which Factors Influence Vehicle Price 

### Project Description
Crankshaft List publishes hundreds of free advertisements for vehicles on their site every day.

Studying data collected over the last few years, determine which factors influence the price of a vehicle.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: This is one my very first coding projects, it contains details on the project and the work I performed, however it does not have a table of contents and I was still learning the syntax of Markdown, so finding the desired information in the formatting may be difficult.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. Please see a visual of the project [here](http://htmlpreview.github.io/?https://github.com/JoleneGlenn/Data-Analytics-Projects-Practicum/blob/main/02_eda_vehicle_pricing/02_eda_vehicle_pricing_approved.html).**

### Instructions for completing the project (high level - see PDF for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Calculate and add information to the table
4. Carry out exploratory data analysis
5. Write an overall conclusion

### Libraries Used
pandas as pd

matplotlib.pyplot as plt

**Error Handling**

sys

warnings
```
if not sys.warnoptions:
	warnings.simplefilter("ignore")
```

### Project Conclusions
- removing the outliers gave more readable data
- most ads are posted for less than 53 days
- SUVs and sedans had the largest amount of ads
	- based on these two vehicle types:
		- there is a positive correlation between age and total mileage suggesting that these two parameters impact the price of a vehicle
	        
While it is out of the scope of this project/instructions, based on the data from these instructions, I would suggest the investigators take a closer look at the vehicle type. This may provide a stronger parameter to determine price.
        
Conclusions after code review
- most colors of SUVs and sedans have a similar median price
- yellow and orange SUVS and orange sedans have a higher median price compared to other colors, so while paint color in general may not impact price, specific colors do
- manual SUVS and automatic sedans have the highest median price with the highest priced outliers compared to other transmission types, suggesting that depending on the type of vehicle the transmission type could impact the price

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Exploratory Data Analysis sprint. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Data Prep**

Read .csv files as a dataframe
- pd.read_csv()

Identify missing values
- df.isnull().sum(), df['column'].isnull()

Fill in missing values with .loc method
- df.loc[df['column'].isnull(), 'column_to_fill'] = value_to_fill_null

Find and delete duplicate rows
- Number of duplicate rows: df.duplicated().sum()
- Delete duplicate rows: df.drop_duplicates().reset_index(drop = True)

Change data types
- df['col_a'] = df['col_a'].astype(int) Used .astype(int) method to convert float64 type to int64 type because float64 is a numeric data type.
- If the initial data type was a string, then .to_numeric() would be used which converts strings to floats and then .astype() to convert the float to int.
- df['columna'] = pd.to_datetime(df['columna'])

Date related columns added
- df['new_col_a'] = df['date_col'].dt.day_name()
- df['new_col_b'] = df['date_col'].dt.month
- df['new_col_c'] = df['date_col'].dt.year

Categorize the data
- Functions and .apply()

**Graphs**

Histograms
- df.hist()

Bar graphs
- df.plot()
- multiple graphs in one image:
	```
	for axis in unfilt_ax.flatten():
		axis.set_ylabel('frequency')
		```

Scatter plot
- pd.plotting.scatter_matrix(df, figsize = (#, #))

BoxPlot
- df[df['columna']].boxplot(column = 'columnb', by = 'value', figsize=(#,#))

**Analysis**

Statistics
- Describe method for numerical data - can also provide info on categorical data too
- df.describe(), categorical: df['column'].describe()

Quantiles
- df['column'].min()/max()/.quantile(0.25 or 0.75): Q1 or Q3 - describe gives 0.5
- IQR = Q3 - Q1
- min_whisker = Q1 - 1.5 * IQR
- max_whisker = Q3 + 1.5 * IQR

Filter tables
- df.query('column boolean_statment column or @list')

Correlation
- df.corr()

Pivot Table
- df.pivot_table(index, columns, values, aggfunc, fill_value = 0, margins = True)