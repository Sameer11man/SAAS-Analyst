CREATE DATABASE saas_analytics;
USE saas_analytics;

CREATE TABLE customers (
    customer_id VARCHAR(10)  PRIMARY KEY,
    signup_date DATE,
    segment VARCHAR(50),
    country VARCHAR(50),
    is_enterprise VARCHAR(5)
);


CREATE TABLE subscriptions (
    subscription_id VARCHAR(10)  PRIMARY KEY,
    customer_id VARCHAR(10),
    start_date DATE,
    end_date DATE,
    monthly_price DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE events(
    event_id VARCHAR(10)  PRIMARY KEY,
    customer_id VARCHAR(10) ,
    event_type VARCHAR(50),
    event_date DATETIME,
    source VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

# Import csv data using table data import wizard
