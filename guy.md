# 🎮 Video Games Performance & Sales Analytics

_Project Goal: Developed a full-scale ETL and analytics pipeline for a global video games dataset to uncover trends in user engagement, developer impact, and the correlation between ratings and global sales._

## 📋 Table of Contents
- <a href="#Overview">Overview</a>
- <a href="#business-problem">Business Problem</a>
- <a href="#dataset">Dataset</a>
- <a href="#Data-Validation--technologies">Data Validation & Cleaning</a>
- <a href="#ETL--Database-Modeling">ETL & Database Modeling (PostgreSQL)</a>
- <a href="#Data-Transformation--SQL-Views">Data Transformation & SQL Views</a>








<h2><a class="anchor" id="Overview"></a>Overview</h2>


🔍 **Project Overview**

This project focuses on building an end-to-end pipeline to analyze video game performance. The workflow covers the entire data lifecycle: validating and cleaning raw data using Python, modeling a relational database in PostgreSQL, and creating an analytical dashboard in Power BI.

<h2><a class="anchor" id="business-problem"></a>Business Problem</h2>


The project aims to analyze and visualize video game sales and engagement data to uncover trends in game popularity, user behavior, and platform performance. By merging sales and engagement data, we seek to offer insights into how game features, platforms, and genres influence sales, wishlists, and ratings.

<h2><a class="anchor" id="dataset"></a>Dataset</h2>

**Games Engagement** :contains  below data points


- Title,Release Date,Team,Rating,	Times Listed	
- Number of Reviews,Genres,Summary,Reviews,Plays,	Playing	Backlogs,Wishlist

**VGSales** : Contains below data points 

- Name, Platform, Year, Genre, Publisher, NA_Sales,
- EU_Sales, JP_Sales , Other_Sales,Global_Sales




<h2><a class="anchor" id="Data-Validation--technologies"></a>Data Validation & Cleaning</h2>


🧹 **Data Validation & Cleaning (Python)** 

- Before analysis, the raw dataset was processed to ensure accuracy:


**Data Type Standardization:** Converted columns like Release_Date to datetime and standardized numeric fields such as Rating, Plays, and Wishlist.


**Numeric Reformatting:** Created a custom Python function to convert strings like '2.5K' into actual integers (2500) for reliable aggregation.



**Handling Missing Data:** Replaced NaT values in Release_Date using a front-fill method.

-Imputed missing Rating values using the average rating of the corresponding developer (team).


**Deduplication:** Removed 382 duplicate rows where all key attributes were identical.

<h2><a class="anchor" id="ETL--Database-Modeling (PostgreSQL)"></a>ETL & Database Modeling (PostgreSQL)</h2>


⚙️ **ETL & Database Modeling (PostgreSQL)**

- The cleaned data was migrated to a postgresql environment:


**Connectivity:** Established a secure connection between VS Code and PostgreSQL using psycopg2.



**Schema Design:** Created the Games_Ds table with appropriate primary keys and data types.



**Date Enhancements:** Added R_Month and R_Year columns to the database for optimized time-series analysis.

<h2><a class="anchor" id="Data-Transformation--SQL-Views"></a>Data Transformation & SQL Views</h2>

**🛠 Data Transformation & SQL Views**

- Complex relationships were handled through advanced SQL:


**Genre Normalization:** Created a dedicated Genre table to unnest multi-genre strings into individual categories (e.g., Action, RPG, Shooter).



**Team View:** Created a Team view by normalizing the developer column, allowing for specific developer-wise performance tracking.



**Consolidated Data View:** Built the Combine_DataSG view, which joins internal game data with external sales records based on title and publisher.


