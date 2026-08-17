# Intel Data Center Siting Analysis

## Overview
Intel's Sustainability Team needed to identify the best U.S. region to site a new data center, with energy availability and renewable energy mix as key deciding factors. This project analyzes regional energy production and demand data to identify which regions produce a surplus of energy — and which of those surplus regions rely most heavily on renewable sources.

## Business Question
Which region offers the best balance of:
1. **Energy surplus** (net production high enough to reliably power a large new facility), and
2. **Renewable energy share** (aligning with Intel's sustainability goals)?

## Approach
- Queried daily energy production and demand data across U.S. regions using SQL (joins, CTEs, aggregations)
- Calculated net energy production by region, and renewable energy as both a raw total and a percentage of total generation
- Joined power plant–level data to evaluate renewable infrastructure density by region and state
- Investigated hourly renewable generation trends to understand production reliability throughout the day
- Built Tableau visualizations to communicate findings to a non-technical stakeholder audience

## Key Finding
At first glance, the **Mid-Atlantic** region looks like the strongest candidate - it has the highest net energy surplus (31.7M MW). But only 6.6% of that comes from renewable sources.

The **Northwest** region tells a different story: slightly lower net production (21.7M MW), but 52% renewable - by far the highest renewable share of any region with a meaningful surplus. Washington State specifically stands out for its renewable infrastructure.

**Recommendation:** The Northwest region (Washington State) is the strongest fit when weighing both energy reliability and sustainability goals. The Central region (notably Oklahoma) is a solid second option, balancing moderate surplus with a strong renewable share (~41%).

Texas and California, despite high renewable percentages, were ruled out - both currently run negative net energy production, meaning they consume more than they generate.

## Tools
SQL · Tableau · Data Aggregation & Joins · Regional Data Analysis

## Dashboard
![Net Production by Region](https://github.com/user-attachments/assets/f0d0c9d5-48cf-493c-850e-6200624b4f93)
![Renewable Energy Percentage by Region](https://github.com/user-attachments/assets/194d92a9-9edd-433d-aa70-adc305eda8b4)
