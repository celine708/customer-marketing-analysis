-- Marketing Project: database setup
-- Creates the database, 4 tables, and the campaigns lookup data.

CREATE DATABASE IF NOT EXISTS marketing_project;
USE marketing_project;

-- Customer profile information
CREATE TABLE customers (
    customer_id         INT PRIMARY KEY,
    year_birth          INT,
    education           VARCHAR(30),
    marital_status      VARCHAR(30),
    relationship_status VARCHAR(20),
    income              INT,
    kidhome             INT,
    teenhome            INT,
    signup_date         DATE,
    recency             INT
);

-- Spending by product category and purchase channel (one row per customer)
CREATE TABLE purchases (
    customer_id     INT PRIMARY KEY,
    mnt_wines       INT,
    mnt_fruits      INT,
    mnt_meat        INT,
    mnt_fish        INT,
    mnt_sweets      INT,
    mnt_gold        INT,
    num_deals       INT,
    num_web         INT,
    num_catalog     INT,
    num_store       INT,
    num_web_visits  INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Lookup table for marketing campaigns
CREATE TABLE campaigns (
    campaign_id   INT PRIMARY KEY,
    campaign_name VARCHAR(50)
);

-- Which customer accepted which campaign (1 = accepted, 0 = not accepted)
CREATE TABLE campaign_responses (
    customer_id INT,
    campaign_id INT,
    accepted    TINYINT,
    PRIMARY KEY (customer_id, campaign_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id)
);

INSERT INTO campaigns (campaign_id, campaign_name) VALUES
(1, 'Campaign 1'),
(2, 'Campaign 2'),
(3, 'Campaign 3'),
(4, 'Campaign 4'),
(5, 'Campaign 5'),
(6, 'Last Campaign');
