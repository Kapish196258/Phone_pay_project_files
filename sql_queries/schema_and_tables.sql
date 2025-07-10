CREATE DATABASE phonepe_data;
USE phonepe_data;

# Creating Aggregated Tables
CREATE TABLE aggregated_user (
    State VARCHAR(100),
    Year INT,
    Quarter VARCHAR(10),
    Brand VARCHAR(100),
    Count INT,
    Percentage FLOAT
);

CREATE TABLE aggregated_transaction (
    State VARCHAR(100),
    Year INT,
    Quarter VARCHAR(10),
    Transaction_Type VARCHAR(100),
    Transaction_Count INT,
    Transaction_Amount DOUBLE
);

CREATE TABLE aggregated_insurance (
    State VARCHAR(100),
    Year INT,
    Quarter VARCHAR(10),
    Insurance_Type VARCHAR(100),
    Transaction_Count INT,
    Transaction_Amount DOUBLE
);

# Creating Map Tables
CREATE TABLE map_user (
    State VARCHAR(100),
    Year INT,
    Quarter VARCHAR(10),
    District VARCHAR(100),
    Registered_Users INT,
    App_Opens INT
);

CREATE TABLE map_transaction (
    State VARCHAR(100),
    Year INT,
    Quarter VARCHAR(10),
    District VARCHAR(100),
    Transaction_Type VARCHAR(100),
    Transaction_Count INT,
    Transaction_Amount DOUBLE
);

ALTER TABLE map_transaction
DROP COLUMN Transaction_Type;

CREATE TABLE map_insurance (
    State VARCHAR(100),
    Year INT,
    Quarter VARCHAR(10),
    District VARCHAR(100),
    Transaction_Count INT,
    Transaction_Amount DOUBLE
);
# Creating top Tables
CREATE TABLE top_user (
    State VARCHAR(100),
    Year INT,
    Quarter VARCHAR(10),
    Entity_Level VARCHAR(20),
    Entity_Name VARCHAR(100),
    Registered_Users INT
);

CREATE TABLE top_transaction (
    State VARCHAR(100),
    Year INT,
    Quarter VARCHAR(10),
    Entity_Level VARCHAR(20),
    Entity_Name VARCHAR(100),
    Transaction_Count INT,
    Transaction_Amount DOUBLE
);

CREATE TABLE top_insurance (
    State VARCHAR(100),
    Year INT,
    Quarter VARCHAR(10),
    Entity_Level VARCHAR(20),
    Entity_Name VARCHAR(100),
    Transaction_Count INT,
    Transaction_Amount DOUBLE
);