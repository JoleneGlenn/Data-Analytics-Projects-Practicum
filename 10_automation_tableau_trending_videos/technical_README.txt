Title
Trending YouTube Videos from November 14, 2017 to June 14, 2018 - Tableau Public Dashboard

Project Description
This dashboard was designed in Tableau Public and provides information on trending YouTube videos from November 14, 2017 to June 14, 2018. 
It is an interactive platform that shows the number of treding videos per video category, the percentage of those categories, the countries of the trending videos, and the popularity of the trending videos per country.

How to install and run the project
Use the following link to access the dashboard: https://public.tableau.com/app/profile/jolene.glenn/viz/TrendingYouTubeVideosNovember142017toJune142018/DashboardTredingYouTubeVideos

How to use the project
To use the dashboard, follow the link above. 
This will bring you to the dashboard, which is hosted on Tableau Public server. 
It will show 4 graphs, 4 filters, and 2 keys. All graphs are interactive and can be manipulated via the filters or the graphs themselves.
To reset selections either reset filters or refresh the page which should reset dashboard to select all dates, countries, and categories. 
The individual graphs worksheets are also provided in tabs above the dashboard. To view them, click on their tab.

The graphs:
Number of Videos per Category: shows the number of videos per category per day.
	Manipulate via the filters, or by clicking on a date or data point and hover, or dragging to select muliple dates or data points, while hovering additional options will be provided for selecting how to filter the data.
Percentage of Videos per Category: shows the percentage of videos per category per day.
	Manipulate via the filters, or by clicking on a date or data point and hover, or dragging to select muliple dates or data points, while hovering additional options will be provided for selecting how to filter the data.
Proportion of Videos per Country: shows the proportion of videos per country based on the selected data. The selected data is controlled by the filters.
	Manipulate via the filters, or by clicking on a country and hover, or dragging to select muliple countries and hover, or select multiple by clicking holding control and clicking on another, then hover, while hovering additional options will be provided for selecting how to filter the data.
Number of Videos per Category: shows the popularity of categories by country visualized via a color gradient.
	Manipulate via the filters, or by clicking on a category or country and hover, or individual cell and hover, while hovering additional options will be provided for selecting how to filter the data.

The filters:
Start Date: allows user to select a start date for analysis.
	Select a start date by sliding the circle below the date box left or right.
End Date: allows user to select an end date for analysis.
	Select an end date by sliding the circle below the date box left or right.
Region: allows user to select all, single, or multiple regions/countries for analysis.
	Select a region by using the drop down menu.
Category Title: allows user to select all, single, or multiple video categories for analysis.
	Select a category by using the drop down menu.

The keys:
# of Videos Selected: shows the number of videos being analyzed based on the filters.
Video Count Gradient: shows the 7 step color gradient used for the Number of Videos per Category per Country graph.

Credits
This project concept was designed by Practicum Data Analysis Bootcamp. It is a course project for the Automation sprint. 
Practicum provided the data set and the technical requirements. 
My role was to interpret the requirements and create the dashboard on Tableau Public. The project was submitted for a review process.

Technical Requirements:
Business goal: analyze trending-video history on YouTube
How often the dashboard will be used: at least once a day
Target dashboard user: video ads planning managers
Dashboard data content:
	Trending videos from the past, broken down by day and category
	Trending videos, broken down by countries
	A table of correspondence between categories and countries
Parameters according to which the data is to be grouped:
	Trending date and time
	Video category
	Country
The data:
	Trending history — absolute values with a breakdown by day (two graphs: absolute numbers and percentage ratio)
	Events, broken down by countries — relative values (% of events)
	The correspondence between the categories and countries — absolute values (a table)
Importance: all graphs are equally important
Data sources for the dashboard: the data engineers promised to create an aggregate table called trending_by_time.csv, its structure:
	record_id — primary key
	region — country/geographical region
	trending_date — date and time
	category_title — the video category
	videos_count — the number of videos in the trending section
The table is stored in the data-analyst-youtube-data. database, which was created especially for your needs
Data update interval: once every 24 hours, at midnight UTC
Graphs, dashboard controls, and their arrangement:
	dashboard title and description
	date and time filter
	country/region filter
	'Trending history' chart - trending videos split by trending time & category (absolute values, stacked area)
	'Trending vids by country' chart - trending videos split by country (relative values, pie chart)
	'Trending history, %' - split by trending time & category (% total, stacked area) 
	'Trending by country and category' columns = countries, rows = categories, table cells = absolute numbers of trending videos, table cells should be highlighted relative to their values (highlight table)
Special considerations for the graphs, dashboard controls, and their arrangement:
	date and time and country/region filter should modify all the dashboard graphs
	'Trending history' and 'Trending history %': x axis = date and time
	'Trending history': y axis = # of videos in trending section = the 'video_count' field
	'Trending history %': y axis = %
