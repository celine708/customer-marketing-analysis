# Customer Marketing Analysis

An end-to-end data analysis project that answers one business question: **which customer groups spend the most and respond best to marketing campaigns, and who should the company target next?**

The project uses **Excel** for data cleaning and exploration, **MySQL** for database design and analysis queries, and **Power BI** for an interactive dashboard.

![Power BI dashboard](Screenshot%202026-10-19%20172934.png)

## Dataset

- **Source:** Kaggle, [Customer Personality Analysis](https://www.kaggle.com/datasets/imakash3011/customer-personality-analysis)
- **Size:** 2,240 customers of a retailer, reduced to **2,030** after cleaning
- **Contains:** customer profile (birth year, education, marital status, income, children at home), spending by product category, purchase channels, and acceptance of 6 marketing campaigns

## Tools

| Tool | Used for |
| --- | --- |
| Excel | Data cleaning, calculated columns, PivotTables, PivotCharts, slicers, KPI dashboard |
| MySQL | Database design (4 tables, primary and foreign keys) and 6 analysis queries |
| Power BI | Interactive dashboard with KPI cards, charts, and slicers |

## Data Cleaning (Excel)

Every step is recorded in the Cleaning Log sheet of the workbook.

| Issue | Action | Rows removed |
| --- | --- | --- |
| Rows identical in every column except ID | Removed as probable duplicates | 182 |
| Impossible birth years (1893, 1899, 1900) | Removed rows | 3 |
| Income outlier (666,666) | Removed row | 1 |
| Missing income | Removed rows | 24 |
| Odd marital status labels (Absurd, YOLO, Alone) | Added a Relationship_Status column (Partnered / Single / Unknown), original kept | 0 |
| Constant columns (Z_CostContact, Z_Revenue) | Deleted | 0 |
| Mixed date formats | Rebuilt all dates as day-month-year and checked against the raw data | 0 |

**Calculated columns added:** Age, Age_Group, Children, Total_Spend, Total_Purchases, Campaigns_Accepted, Income_Group.

**Assumptions:** Age = 2014 minus birth year. Income groups: Low (under 40,000), Medium (40,000 to 79,999), High (80,000 and above).

## Database Design (MySQL)

The cleaned data was loaded into a database called `marketing_project` with 4 tables:

- `customers`: customer profile information
- `purchases`: spending by product category and purchase channel (one row per customer)
- `campaigns`: lookup table for the 6 campaigns
- `campaign_responses`: which customer accepted which campaign (12,180 rows)

Tables are linked with primary and foreign keys.

## SQL Analysis

The file `02_analysis_queries.sql` contains 6 queries using joins, `CASE`, subqueries, `UNION ALL`, and window functions:

1. Customers and total spend by income group
2. Average spend by number of children
3. Acceptance rate for each campaign
4. Share of total spend by product category
5. Top 10 customers by total spend
6. Last-campaign acceptance rate by relationship status

## Key Findings

- **High-income customers are the most valuable.** They are 9.7% of customers (197 of 2,030) but 24.0% of total spend, and 40.1% of them accepted the last campaign, versus 12.1% of low-income and 13.1% of medium-income customers.
- **Children at home reduce spending.** Customers with no children spend 1,119 on average, versus 474 for customers with one child (about 2.4 times more).
- **Single customers respond better.** They accepted the last campaign 22.5% of the time, versus 11.3% for partnered customers, at similar average spend (622 vs 599).
- **Wine and meat drive revenue.** Together they make up about 77.8% of total spend (wine 50.2%, meat 27.6%).
- **The last campaign performed best.** It reached a 15.4% acceptance rate, compared with 1.3% to 7.6% for the earlier campaigns.

## Recommendations

1. **Target high-income customers** with premium wine and meat offers. They combine the highest spend with the highest response rate.
2. **Reduce blanket mailings to low-income customers.** They are about a third of customers (32.6%) but only 5.1% of spend.
3. **Test new offers for the medium-income group.** They are 57.7% of customers and 70.9% of spend but respond at only 13.1%.

## Limitations

- The dataset has no advertising cost, so ROI and cost per acquisition cannot be calculated.
- Results show associations, not proof that an offer causes a response. Income and number of children overlap, so part of the children effect is an income effect.
- Some groups are small (45 customers with 3 children, 4 with unknown relationship status), so their numbers are less reliable.

## Repository Contents

| File | Description |
| --- | --- |
| `marketing_project_final (1).xlsx` | Cleaned data, Cleaning Log, PivotTables, PivotCharts, and Excel dashboard |
| `01_create_tables.sql` | Creates the database, 4 tables, and the campaigns lookup data |
| `02_analysis_queries.sql` | The 6 analysis queries |
| `powerbi_project.pbix` | Power BI dashboard |
| `Screenshot 2026-10-19 172934.png` | Dashboard screenshot |

## Author

Celine Hashem
