SQL Project - SQL Code

```
Task 1
Write a code to parse the data on weather in Chicago in November 2017 from the website:
[https://code.s3.yandex.net/data-analyst-eng/chicago_weather_2017.html)
The name of the DataFrame should be weather_records, and it should be specified when you search: attrs={"id": "weather_records"} . 
Print the DataFrame in its entirety.
```

import requests
from bs4 import BeautifulSoup
import pandas as pd

# save url information
URL = 'https://code.s3.yandex.net/data-analyst-eng/chicago_weather_2017.html'
# make get request
data_req = requests.get(URL)
# parse the data
parse_data = BeautifulSoup(data_req.text, 'lxml')

# find the needed table information
weather_data = parse_data.find('table', attrs={"id": "weather_records"})

# Break the table info into chunks
# find the table headers
table_headers = []
for row in weather_data.find_all('th'):
    table_headers.append(row.text)

# find the table contents
table_contents = []
for row in weather_data.find_all('tr'):
    if not row.find_all('th'):
        table_contents.append([element.text for element in row.find_all('td')])

# create a dataframe with conents and headers
weather_records = pd.DataFrame(table_contents, columns=table_headers)
print(weather_records)

```
Task 2 (1 - 3: EDA)
Task 2 (4 - 6: Test the hypothesis that the duration of rides from the the Loop to OHare International Airport changes on rainy Saturdays)

Task 2 (1 of 6)

Print the company_name field. 
Find the number of taxi rides for each taxi company for November 15-16, 2017, name the resulting field trips_amount, and print it, too. 
Sort the results by the trips_amount field in descending order.
```

SELECT
    subq.company_name,
    COUNT(subq.company_name) AS trips_amount
FROM
    (SELECT
        cabs.cab_id AS cab_id,
        cabs.company_name AS company_name,
        CAST(trips.start_ts AS date) AS start_day
    FROM
        cabs
    INNER JOIN trips ON trips.cab_id = cabs.cab_id
    WHERE
        CAST(trips.start_ts AS date) IN ('2017-11-15', '2017-11-16'))
    AS subq
GROUP BY
    subq.company_name
ORDER BY
    trips_amount DESC

```
Task 2 (2 of 6)

Find the number of rides for every taxi company whose name contains the words "Yellow" or "Blue" for November 1-7, 2017. 
Name the resulting variable trips_amount. 
Group the results by the company_name field.
```

SELECT
	company_name,
	COUNT(company_name) AS trips_amount
FROM
	cabs
	INNER JOIN trips on cabs.cab_id = trips.cab_id
WHERE
	CAST(trips.start_ts AS date) BETWEEN '2017-11-01' AND '2017-11-07'
	AND company_name in (
		SELECT company_name
		FROM
			cabs
		WHERE
			company_name LIKE '%Yellow%'
		UNION
		SELECT company_name
		FROM
			cabs
		WHERE
			company_name LIKE '%Blue%'
		)
GROUP BY
	company_name

```
Task 2 (3 of 6)

For November 1-7, 2017, the most popular taxi companies were Flash Cab and Taxi Affiliation Services. 
Find the number of rides for these two companies and name the resulting variable trips_amount. 
Join the rides for all other companies in the group "Other." 
Group the data by taxi company names. Name the field with taxi company names company. Sort the result in descending order by trips_amount.
```

SELECT
    CASE 
        WHEN company_name != 'Flash Cab' AND company_name != 'Taxi Affiliation Services' THEN 'Other'
        ELSE company_name END AS company,
	COUNT(company_name) AS trips_amount
FROM
	cabs
	INNER JOIN trips on cabs.cab_id = trips.cab_id
WHERE
	CAST(trips.start_ts AS date) BETWEEN '2017-11-01' AND '2017-11-07'
GROUP BY
	company
ORDER BY trips_amount DESC

```
Task 2 (4 of 6)

Retrieve the identifiers of the O'Hare and Loop neighborhoods from the neighborhoods table.
```

SELECT
    *
FROM
    neighborhoods
WHERE
    name LIKE '%Hare' OR name LIKE 'Loop'

```
Task 2 (5 of 6)

For each hour, retrieve the weather condition records from the weather_records table. 
Using the CASE operator, break all hours into two groups: Bad if the description field contains the words rain or storm, and Good for others. 
Name the resulting field weather_conditions. 
The final table must include two fields: date and hour (ts) and weather_conditions.
```

SELECT
    ts,
    CASE
        WHEN description LIKE '%rain%' OR description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
        END AS weather_conditions
FROM
    weather_records

```
Task 2 (6 of 6)

Retrieve from the trips table all the rides that started in the Loop (pickup_location_id: 50) on a Saturday and ended at O'Hare (dropoff_location_id: 63). 
Get the weather conditions for each ride. Use the method you applied in the previous task. 
Also, retrieve the duration of each ride. 
Ignore rides for which data on weather conditions is not available.
The table columns should be in the following order:
start_ts
weather_conditions
duration_seconds
Sort by trip_id.
```

SELECT
    trips.start_ts AS start_ts,
    CASE
        WHEN description LIKE '%rain%' OR description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
        END AS weather_conditions,
    trips.duration_seconds
FROM
    trips
    INNER JOIN weather_records ON trips.start_ts = weather_records.ts
WHERE
    EXTRACT(DOW from trips.start_ts) = 6
    AND
    trips.pickup_location_id = 50
    AND
    trips.dropoff_location_id = 63
    AND
    weather_records.description IS NOT NULL
ORDER BY
    trips.trip_id