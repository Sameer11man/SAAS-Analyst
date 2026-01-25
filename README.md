# SAAS-Analyst


Dataset

customers.csv – customer profile and signup information

subscriptions.csv – subscription lifecycle and revenue

events.csv – product usage and funnel events

## Tools & Technologies

MySQL – data storage and analytical queries

Python (pandas, numpy, mysql-connector) – data validation and sanity checks

Power BI – dashboard and visualization

## Workflow

Load CSV files into MySQL tables

Perform data validation using data_validation.ipynb

Clean data (duplicates, missing values, inconsistent records)

Calculate key SaaS metrics using SQL

Perform funnel analysis

Build Power BI dashboard

Derive insights and recommendations

Key Metrics

Monthly Recurring Revenue (MRR)

Annual Recurring Revenue (ARR)

Customer (Logo) Churn Rate

Revenue Churn Rate

Average Revenue per Customer (ARPC)

Funnel

Signup → Trial → Activated → Paid → Churned

Funnel stages are derived from the events and subscriptions tables and used to calculate conversion rates and drop-offs.

Data Validation

Performed using Python:

Duplicate detection

Missing value checks

Date consistency checks (end_date after start_date)

Foreign key integrity between tables

Revenue sanity checks

Dashboard

Power BI dashboard includes:

MRR trend over time

Funnel conversion visualization

Churn overview

Segment-level performance

Assumptions

One active subscription per customer at a time

Paid stage is inferred from subscription start_date

Churn is defined by non-null subscription end_date

Missing signup dates are excluded from time-based analysis
