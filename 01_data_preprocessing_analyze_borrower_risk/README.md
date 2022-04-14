### Project Title
01. Data Preprocessing: Analyze Borrower's Risk of Defaulting on a Loan

### Project Description
Prepare a report for the bank's loan division.
In the report, evaluate if a customer's marital status and number of children has an impact on whether they will default on a loan.
The report will be considered when building a credit score for a potential customer. The credit score is used to evaluate the ability of a potential borrower to repay their loan.

### How to use this project
1. The project shows the steps I took to answer the provided requirements and questions, it acts as a report but also a way to see my organization and thought processes to a business analytics problem with the tools I have learned at the time of the project.
2. Special notes: This is my very first coding project, it contains details on the project and the work I performed, however it does not have a table of contents and I was still learning the syntax of Markdown, so finding the desired information in the formatting may be difficult.
3. There may be work from multiple versions based on reviewers requests/comments. I left all work for reference but the work done for each version may not be clear.

### Instructions for completing the project (high level - see PDF file for more details)
1. Open the data file and review general information
2. Preprocess the data
3. Answer the questions
	Is there a connection between having kids and repaying a loan on time?
	Is there a connection between marital status and repaying a loan on time?
	Is there a connection between income level and repaying a loan on time?
	How do different loan purposes affect on-time loan repayment?
4. Write an overall conclusion

### Libraries Used
pandas as pd
nltk
WordNetLemmatizer from nltk.stem
Counter from collections
SnowballStemmer from nltk.stem

### Project Conclusions
The investigation wanted to evaluate if the number of children and marital status impact the chance of defaulting on a loan, while also evaluating income level and purpose for the loan.

Possible indicators of defaulting
- The number of children a client has appears to be a good indicator of the chance of defaulting because the more children a client has the higher their chance of defaulting
- Income level also appears to be a good indicator because as income increases from 0 to <125,000 the chance of default goes down, 125,000 or more and it goes up.

Unlikely indicators of defaulting
- Marital status does not appear to be a good indicator because there is no obvious trend based on the relationship status of a client. It might be assumed that those with civil partnerships and married status would have a similar chance because there are potentially two contributing incomes, while those divorced, unmarried, and widowed would have a similar chance because they have potentially one contributing income. However this is not the case according to this data set.
- The purpose of the loan also did not have a clear trend. The results varied slightly but they all have about the same chance of defaulting.

### Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Data Preprocessing sprint. 
Practicum provided the data set and the project requirements. 
My role was to interpret the requirements and create a report using jupyter notebook. The project was submitted for a review process.

### Applied Techniques

Read .csv files as a dataframe
- pd.read_csv()
Identify missing values
- df.isnull().sum(), df['column'].isnull()
Change data types
- df['col_a'] = df['col_a'].astype(int) Used .astype(int) method to convert float64 type to int64 type because float64 is a numeric data type.
- If the initial data type was a string, then .to_numeric() would be used which converts strings to floats and then .astype() to convert the float to int.
Find and delete duplicate rows
- Number of duplicate rows: df.duplicated().sum()
- Delete duplicate rows: df.drop_duplicates().reset_index(drop = True)
Categorize the data
- Functions and .apply()
- Single line for loops?
- for loops
- Tokenization of words
	- allwords = ' '.join(df['column'])
	- wordnet_lemma = WordNetLemmatizer()
	- words = nltk.word_tokenize(allwords)
Lemmatization
- lemmas = [wordnet_lemma.lemmatize(w, pos = 'n') for w in allwords]
- print(Counter(lemmas), '\n') # print number of each word
Stemmer
- create list of words to stem
- english_stemmer = SnowballStemmer('english')
Analysis
- Absolute values
	- df['column'].abs()
- Groupby and value counts
	- df.groupby('column1')['column2'].value_counts(dropna=False)
- Lowercase letters
	- df['column'].str.lower()
- Pivot Tables
	- df.pivot_table(index, columns, values, aggfunc, fill_value = 0, margins = True)
