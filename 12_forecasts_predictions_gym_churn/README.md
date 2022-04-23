### Project title
12. Forecasts and Predictions: Determine probability of customer churn

### Project Description
Model Fitness is developing a customer interaction strategy based on analytical data.

Model Fitness wants to:
- Learn to predict the probability of customer churn for the upcoming month
- Create customer groups/profiles
- Determine which factors impact churn the most
- Draw basic conclusions to identify target groups, measures to cut churn, and any customer interaction patterns.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: There is a table of contents with Markdown links to assist in finding the desired information.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.
4. **There may or may not be formatting issues with the notebook file (.ipynb). This is an artifact of Jupyter Notebooks having difficulty exporting custom HTML files. Please see a visual of the project [here](http://htmlpreview.github.io/?https://github.com/JoleneGlenn/Data-Analytics-Projects-Practicum/blob/main/12_forecasts_predictions_gym_churn/12_forecasts_predictions_accepted.html).**

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and study the general information
2. Preprocess the data
3. Build a model to predict user churn
4. Create user clusters
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
pd.set_option('display.max_columns', 100)
```

**Modeling**

train_test_split from sklearn.model_selection

StandardScaler from sklearn.preprocessing

LogisticRegression from sklearn.linear_model

Lasso, Ridge from sklearn.linear_model 

RandomForestClassifier from sklearn.ensemble 

DecisionTreeRegressor from sklearn.tree

accuracy_score, precision_score, recall_score, f1_score, roc_auc_score from sklearn.metrics

dendrogram, linkage from scipy.cluster.hierarchy 

KMeans from sklearn.cluster

### Project Conclusions
Conclusions
- The data was processed and analyzed (EDA)
- 2 models were used tested to forecast churn
    - Random Forest model was determined to be the best way to forecast churn
        - Accuracy: 0.93
        - Precision: 0.85
        - Recall: 0.85
- 5 clusters were created as profiles for the client features
- Clients likely to churn:
    - have a 1 month contract or 1 month left on their contract
    - visit the gym less than 2 times per week
    - are less likely:
		- to be an employee of a partner employer
		- to have a friend promo code
		- to attend group classes

Recommendations
- **Essentially make it as easy as possible for a client to go to the gym and know what to do**
- Especially engage with clients who have a 1 month contract or 1 month left on their contract
    - offer a 30 minute introduction to the gym and its resources for new clients
- However to decrease effort aim to engage all clients at some level, because all clients will eventually have 1 month left on their contract
    - Encourage them to visit more than 2 times per week and to participate in group classes
    - Offer general workout plans for beginners, intermediate, and seasoned clients with instructions on how to do the exercises, include group classes and additional services to support their health and fitness goals
    - Offer a complimentary smoothie if they provide their phone number
        - Use their phone number to send reminders to go to the gym, attend a class, or to promote special services
    - Continue to maintain and create relationships with current and future partner employers
    - Continue to offer friend promo code
    - Offer discounts on longer contract lengths to encourage sign up

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Forecasts and Predictions sprint. 

Practicum provided the data set and the project requirements. 

My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques
**Data Prep**

Read .csv files as a dataframe
- pd.read_csv()

Identify missing values
- df.isnull().sum(), df['column'].isnull()

Find and delete duplicate rows
- Number of duplicate rows: df.duplicated().sum()
- Delete duplicate rows: df.drop_duplicates().reset_index(drop = True)

Change letter case to lower
- df.columns = df.columns.str.lower()

**Analysis**

Use pivot tables for calculations
- df.pivot_table(index = ['col_a', 'col_b'], values = 'col_c', aggfunc = 'calculation').reset_index()
	- rename columns

Create dummy features
- pd.get_dummies(data = df, columns = ['col_to_split'])

Calculate stats with .describe() method & Transpose the results
- new_df = df.describe().T.reset_index() - transposes the stats results
- Need to rename the index column after transposing
	- new_df = new_df.rename(columns = {'index': 'new_col_name'})
	- can do the rest of the columns too if needed

Isolate necessary data via queries
- new_df = df.query('col_name boolean_expression value')

Create functions to graph data
- created a function to graph histograms for numerical data
- created a function to graph bar graphs categorical data

**Modeling**

- Remove features with multicollinearity for Logistic Regression models
	- new_df = df.drop(['col_a', 'col_b', ...], axis = 1)
- Logistic Regression
- Random Forest

Clustering
- Standardize the data
- Create links
	- links = linkage(X_scaler, method = 'ward')
- plot a dendrogram
- Train clustering model with K-means algorithm
	- km = KMeans(n_clusters = #)
	- labels = km.fit_predict(X_scaler, random_state =0)
		- reviewer said to include random_state to make reproducible code and prevent cluster centroids from randomizing each time the code is run

**Graphs**

Bar graphs - two values per feature
- graph_name = df[['col_a', 'col_b']].plot(kind = 'bar')
- graph_name.set_xticklables(df['col_c'], rotation = 45, ha = 'right')

Histograms with 2 value distributions per feature
- plt.figure(figsize = (#, #))
- sns.distplot(df['col_a'], label = 'label_name_a')
- sns.distplot(df['col_b'], label = 'label_name_b')
- plt.legend()

Correlation Matrix
- plt.figure(figsize = (#, #))
- sns.heatmap(df, annot = True, fmt = '.0%', linewidths = 1, linecolor = 'black', cmap = 'YlGnBu', yticklabels = True,)
- plt.show()
	
Dendrogram
- plt.figure(figsize = (#, #))
- dendrogram(links, orientation = 'top')
- plt.show()