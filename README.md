Global Layoffs During COVID-19
SQL Data Cleaning & Analysis

📂 Project Description
This project presents a SQL-based exploration and cleaning of a dataset that records global layoffs during the COVID-19 pandemic. Using structured queries, the project uncovers key trends by company, location, industry, funding stage, and time. The analysis provides meaningful insights into how different sectors and regions were impacted during one of the most disruptive economic periods in recent history.
This project also includes a Power BI dashboard to visualize the results interactively, making it easier to spot trends and patterns across different countries, industries and time.

🔍 Objectives
•	Clean and prepare the layoff data for reliable analysis.
•	Identify trends in layoffs across companies, countries, industries, and time periods.
•	Provide meaningful business insights using SQL queries.
•	Creating a Dashboard using Power BI to visualize the results.

📂 Dataset
Source: 
Layoffs_original.csv (via Kaggle or similar public sources)
Data Format:
CSV imported into a SQL database
Key Columns:
•	company 
•	location
•	industry
•	country
•	total_laid_off
•	percentage_laid_off
•	date
•	stage
•	funds_raised_millions

⚖️ Tools & Technologies
•	SQL (MySQL): Data cleaning, transformation and analysis.
•	Power BI: Power BI dashboard files and screenshots.
•	GitHub: Version Control and documentation. 

📂 Project Structure
•	data/– Raw dataset and cleaned versions.
•	SQL scripts/ –   SQL queries for cleaning, transformation, and analysis.
•	visualizations/ – Power BI dashboard files and screenshots.
•	README.md – Project documentation.

🚀 Key Steps

📃 Data Cleaning 
      Performed in a staging table (layoffs_original):
•	Removed Duplicates:
      Used ROW_NUMBER() window function to filter out duplicate rows.
•	Standardized Columns:
               Trimmed whitespace, handled case sensitivity, and cleaned inconsistent values from columns (company,   
               industry and location names)
•	Handled Null and Blank Values:
               Filtered out or replaced missing entries in critical fields such as total_laid_off and date.
•	Dropped Irrelevant Columns:
               Columns not needed for analysis were excluded to reduce noise.
📊 Exploratory Analysis with SQL
•	Identified industries and countries with the highest layoffs.
•	Analyzed layoffs over time (monthly trends).
•	Found top 10 companies with the most workforce reductions.
•	Compared funding vs layoff patterns.
📊 Visualization with Power BI
Built an interactive dashboard showing:
•	Location-wise layoffs
•	Country-wise layoffs
•	Industry impact
•	Layoffs over time (trend line)
•	Funding vs Layoff Percentage
•	% of workforce laid off by company

📈 Insights Gained
•	The United States was the most impacted country in terms of layoffs.
•	Technology, Retail, and Consumer industries had the highest workforce cuts.
•	Layoffs peaked around 2022–2023, aligning with post-COVID economic uncertainty.
•	Some companies with high funding rounds still laid off large portions of their workforce.

📊 Sample Dashboard (Power BI)

 ![Power BI Dashboard Screenshot](https://github.com/Gurkirat2021/SQL-Exploratory-Project/blob/main/global_layoff_powerbi_visualization.pbix)

✅ Future Improvements
•	Add Tableau visualizations for cross-tool comparison.
•	Automate data refresh for Power BI dashboard.
•	Expand analysis with predictive modeling (future layoff risk).


