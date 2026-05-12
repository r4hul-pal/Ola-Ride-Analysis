create database  if not exists ola ;
use ola;



CREATE TABLE ola_data (
    Date VARCHAR(20),
    Time VARCHAR(20),
    Booking_ID VARCHAR(50),
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(50),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT VARCHAR(20),
    C_TAT VARCHAR(20),
    Canceled_Rides_by_Customer VARCHAR(50),
    Canceled_Rides_by_Driver VARCHAR(50),
    Incomplete_Rides VARCHAR(50),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value VARCHAR(20),
    Payment_Method VARCHAR(50),
    Ride_Distance VARCHAR(20),
    Driver_Ratings VARCHAR(20),
    Customer_Rating VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ola100000.csv'
INTO TABLE ola_data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Date,
Time,
Booking_ID,
Booking_Status,
Customer_ID,
Vehicle_Type,
Pickup_Location,
Drop_Location,
V_TAT,
C_TAT,
Canceled_Rides_by_Customer,
Canceled_Rides_by_Driver,
Incomplete_Rides,
Incomplete_Rides_Reason,
Booking_Value,
Payment_Method,
Ride_Distance,
Driver_Ratings,
Customer_Rating);

#  Retrieve all successful bookings:
CREATE VIEW successfull_ride AS
    SELECT 
        *
    FROM
        ola_data
    WHERE
        Booking_status = 'Success';

select * from successfull_ride;

# Find the average ride distance for each vehicle type:
SELECT 
    vehicle_type, ROUND(AVG(ride_distance), 2) AS avg_distance
FROM
    ola_data
GROUP BY vehicle_type
ORDER BY avg_distance DESC;

 # Get the total number of cancelled rides by customers:
 SELECT 
    booking_status, COUNT(Booking_status) AS cancelled
FROM
    ola_data
WHERE
    Booking_status = 'Canceled by Customer'
GROUP BY booking_status;

# List the top 5 customers who booked the highest number of rides:
SELECT 
    customer_id, COUNT(booking_id) AS total_rides
FROM
    ola_data
GROUP BY customer_id
ORDER BY total_rides DESC
LIMIT 5;

# Get the number of rides cancelled by drivers due to personal and car-related issues 
SELECT 
    Canceled_Rides_by_Driver, COUNT(Canceled_Rides_by_Driver) as no_of_cancel
FROM
    ola_data
WHERE
    Canceled_Rides_by_Driver = 'Personal & Car related issue'
GROUP BY Canceled_Rides_by_Driver;

# Find the maximum and minimum driver ratings for Prime Sedan bookings:

SELECT 
    vehicle_type,
    MAX(Driver_Ratings) as maxrating,
    MIN(Driver_Ratings) AS minrating
FROM
    ola_data
WHERE
    vehicle_type = 'Prime Sedan'
GROUP BY vehicle_type;

# Retrieve all rides where payment was made using UPI :
SELECT 
    *
FROM
    ola_data
WHERE
    payment_method = 'UPI';
    
 #   Find the average customer rating per vehicle type:
 SELECT 
    vehicle_type,
    round(avg(Driver_Ratings),2) as rating
FROM
    ola_data

GROUP BY vehicle_type;

# Calculate the total booking value of rides completed successfully:
SELECT 
    SUM(booking_value) AS total_revenue
FROM
    ola_data
WHERE
    booking_status = 'Success';
    
# List all incomplete rides along with the reason: 
select * from ola_data limit 15;

select Booking_id , incomplete_rides_reason from ola_data where incomplete_rides = "yes" ;



 
