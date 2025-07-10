# Queries for Data Analysis

# 1. Decoding Transaction Dynamics on PhonePe
# Analyze transaction volume and value by state and quarter.
SELECT State, Year, Quarter, 
       SUM(Transaction_Count) AS Total_Transactions,
       SUM(Transaction_Amount) AS Total_Amount
FROM aggregated_transaction
GROUP BY State, Year, Quarter
ORDER BY Year, Quarter, Total_Amount DESC;

# 2. Device Dominance and User Engagement Analysis
# Checking most-used device brands across states.
SELECT Brand, State, Year, Quarter,
       SUM(Count) AS Total_Users,
       ROUND(AVG(Percentage), 2) AS Avg_Usage_Percentage
FROM aggregated_user
GROUP BY Brand, State, Year, Quarter
ORDER BY Total_Users DESC;

# 3. Insurance Penetration and Growth Potential Analysis
# State-wise insurance amount trend by year.
SELECT State, Year,
       SUM(Transaction_Count) AS Total_Insurance_Transactions,
       SUM(Transaction_Amount) AS Total_Insurance_Amount
FROM aggregated_insurance
GROUP BY State, Year
ORDER BY Total_Insurance_Amount DESC;

# 4. Transaction Analysis for Market Expansion
# Identify states with the highest overall transaction value.
SELECT State,
       SUM(Transaction_Amount) AS Total_Transaction_Amount,
       SUM(Transaction_Count) AS Total_Transactions
FROM aggregated_transaction
GROUP BY State
ORDER BY Total_Transaction_Amount DESC;

# 5.  User Engagement and Growth Strategy
# District-wise app usage and registration trend.
SELECT District, State, Year, Quarter,
       SUM(Registered_Users) AS Total_Users,
       SUM(App_Opens) AS Total_App_Opens
FROM map_user
GROUP BY District, State, Year, Quarter
ORDER BY Total_App_Opens DESC;

# 6. Insurance Engagement Analysis
# District-level insurance engagement insights.
SELECT District, State, Year, Quarter,
       SUM(Transaction_Count) AS Insurance_Transactions,
       SUM(Transaction_Amount) AS Insurance_Value
FROM map_insurance
GROUP BY District, State, Year, Quarter
ORDER BY Insurance_Value DESC;

# 7. Transaction Analysis Across States and Districts
# Top-performing states/districts/pincodes by transaction value.
SELECT Entity_Level, Entity_Name, 
       SUM(Transaction_Amount) AS Total_Transaction_Amount
FROM top_transaction
GROUP BY Entity_Level, Entity_Name
ORDER BY Total_Transaction_Amount DESC
LIMIT 15;

# 8. User Registration Analysis
# Top user registrations across locations.
SELECT Entity_Level, Entity_Name, Year, Quarter,
       SUM(Registered_Users) AS Total_Registrations
FROM top_user
GROUP BY Entity_Level, Entity_Name, Year, Quarter
ORDER BY Total_Registrations DESC
LIMIT 15;

# 9.  Insurance Transactions Analysis
# Top insurance transaction areas (state/district/pincode).
SELECT Entity_Level, Entity_Name, Year, Quarter,
       SUM(Transaction_Count) AS Insurance_Transactions,
       SUM(Transaction_Amount) AS Insurance_Amount
FROM top_insurance
GROUP BY Entity_Level, Entity_Name, Year, Quarter
ORDER BY Insurance_Amount DESC
LIMIT 20;
