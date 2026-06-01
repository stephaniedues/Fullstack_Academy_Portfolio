# The Architecture of a Healthy Portfolio: Turning Raw Bank Data into Executive‑Ready Insight
## A Data Analytics Capstone

### 📌 Overview
This project is a prototype of a bank‑grade portfolio reporting system. It demonstrates how a financial institution can structure, calculate, and communicate the health of its loan portfolio using clean data models, transparent SQL, and executive‑ready visuals.

The goal is simple: show end‑to‑end thinking — from raw data to insight.

This project is based on a single‑point snapshot extract.

### 📂 What’s Included
- Data Model — normalized tables and analytical views

- SQL Logic — modular, documented queries for every metric

- Portfolio Composition Metrics — loan and DDA structure, balances, and exposure

- Risk Analysis — snapshot‑based credit quality distribution

- Fee Refund Analysis — operational discipline and customer‑facing behavior

- Officer Scorecard — quality, exposure, and operational discipline

- Visualizations — Python and Excel‑based analytical visuals

- Documentation — definitions, lineage, and governance

### 🎯 Key Features
1. Portfolio Composition
This section provides a point‑in‑time view of the bank’s portfolio using the single‑date snapshot extract. The analysis focuses on understanding the structure and distribution of loan and DDA accounts, along with their associated balances and exposure. It also incorporates limited officer‑level segmentation to highlight how relationships are distributed across the portfolio.

- Loan Portfolio Snapshot — counts, balances, and total exposure

- DDA Accounts — account counts and balance distribution

- Exposure Profile — commitments, outstanding balances, and utilization patterns

- Officer Segmentation (Limited) — basic grouping of accounts and exposure by assigned officer

2. Risk Analysis
The risk analysis provides a point‑in‑time view of the portfolio’s credit quality using the risk‑rating information available in the snapshot extract. Because the dataset represents a single moment rather than a time series, the analysis focuses on distribution and exposure, not movement or migration.

- Risk Rating Distribution — counts and balances grouped by assigned risk rating

- Exposure by Risk Tier — total commitments and outstanding balances within each rating category

- Portfolio Quality Snapshot — identification of higher‑risk segments based solely on the snapshot’s rating structure

- Officer‑Level Risk View (Limited) — grouping of risk ratings by officer

3. Fee Refund Analysis
This analysis examines fee refunds within the snapshot extract to understand operational discipline and customer‑facing behavior. Because refunds represent a reversal of earned fee income, they serve as a meaningful indicator of process consistency, expectation‑setting, and customer management.

- Refund Volume & Amounts — total refunded fees captured in the snapshot

- Refund Types — NSF fees, service charges, and other miscellaneous reversals

- Operational Interpretation — higher refund activity may signal inconsistent enforcement or reactive exception handling

- Officer‑Level Patterns (Limited) — segmentation to identify clustering of refund behavior

- Scorecard Integration — the normalized refund metric (norm_fees) contributes to the operational discipline component of the officer scorecard

4. Officer Scorecard
The officer scorecard provides a structured, snapshot‑based view of officer performance using the metrics available in the extract. It focuses on portfolio quality, operational discipline, and relationship activity as they appear in the single‑date snapshot.

- Portfolio Exposure — balances and commitments by officer

- Account Distribution — counts of loan and DDA relationships

- Operational Discipline — normalized fee refund behavior

- Portfolio Quality Indicators — risk ratings and other available fields

- Composite Score — a combined metric weighting the above components

### 🧱 Data Architecture
Designed for clarity and auditability:

- Staging → Clean → Analytical Views

- Consistent naming conventions

- Transparent calculation logic

- Reusable components for future reporting

### 🛠️ Tech Stack
- Excel — exploratory analysis and one supporting visual

- SQL — data cleaning, transformation, and metric logic

- Python — analytical processing and visualizations

- GitHub — version control and documentation

### 📊 Visualizations
The visual components of this capstone were created using Python and Excel, focusing on clarity, interpretability, and alignment with the snapshot‑based structure of the data. These visuals support the analytical narrative by highlighting key patterns in loan and DDA balances, exposure, fee refund behavior, and officer‑level segmentation.

- Python Visuals — charts illustrating portfolio composition, exposure patterns, and refund distributions

- Excel Visual — supplemental visual used for exploratory analysis and validation

- Design Priorities

   - Clear, minimal formatting

   - Consistent labeling and color use

   - Direct alignment with snapshot‑based metrics
 
   - Readability for non‑technical audiences

These visuals serve as the analytical surface of the project without requiring a full dashboarding environment.

### 📈 Future Applications With Recurring Data
While this capstone is built from a single snapshot, the architecture is intentionally designed to scale into a full time‑series reporting ecosystem once recurring monthly data becomes available. With continuous feeds, the same structure can support a richer set of analytics, including:

- Trend Modeling — growth, runoff, and portfolio velocity

- Risk Migration Analysis — upgrades, downgrades, and early‑warning patterns

- Vintage and Cohort Performance — behavior by origination period

- Time‑Series Profitability — RAROC, FTP, and relationship value

- Officer Performance Trends — production, quality, and discipline over time

- Concentration Drift — shifts in exposure across industries, geographies, or products

With recurring data, the snapshot view becomes the foundation of a true longitudinal reporting layer, enabling deeper insight, stronger governance, and more predictive analytics.

🚀 Outcome
This capstone brings together the pieces of how a modern financial institution understands itself: the precision of strong SQL engineering, the grounded insight of banking domain fluency, the calm structure of scalable reporting design, and the clarity of executive‑ready communication. It reflects the full arc of the work — from raw data to meaning — and shows how disciplined technical craft can become a story about the health, behavior, and direction of a portfolio.
