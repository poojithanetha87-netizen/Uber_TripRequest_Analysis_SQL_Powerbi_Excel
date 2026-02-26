--Creating table to import the data from cvs file
Create Table Uber_data(
Request_id	Int,
Pickup_point Varchar(7),
Driver_id Int,
Status	Varchar(40),
Request_timestamp Text,
Drop_timestamp Text,
Request_Weekday Varchar(10),
Request_hour Int
);


select * from Uber_data
;

--converting request_timestamp&drop_timestamp columns data type text to timestamp 
Alter table Uber_data
Alter column request_timestamp type timestamp using to_timestamp(request_timestamp,'DD-MM-YYYY HH24:MI'),
Alter column drop_timestamp type timestamp using to_timestamp(drop_timestamp,'DD-MM-YYYY HH24:MI');

--adding column to table 
ALTER TABLE uber_data
ADD COLUMN duration_minutes numeric;

-- updating duration of each ride
UPDATE Uber_data
SET duration_minutes = EXTRACT(EPOCH FROM (drop_timestamp - request_timestamp)) / 60;

--number of drivers
select count(Distinct(driver_id)) as number_of_drivers
 from Uber_data
 where driver_id is not Null;

--number of driver pickup point wise 
 select pickup_point,count(Distinct(driver_id)) as number_of_drivers
 from Uber_data
 where driver_id is not Null
 group by pickup_point;


--driver wise overall week working hours
 SELECT driver_id,
       extract(EPOCH from(sum(duration_minutes)*interval '1 minute'))/3600 as working_time,
	   TO_CHAR( (SUM(duration_minutes) * INTERVAL '1 minute'), 'HH24:MI') AS working_time_HHMM
FROM uber_data
GROUP BY driver_id
ORDER BY driver_id;

--everyday working hours of drivers
SELECT driver_id,request_weekday,
       extract(EPOCH from(sum(duration_minutes)*interval '1 minute'))/3600 as working_time,
	   TO_CHAR( (SUM(duration_minutes) * INTERVAL '1 minute'), 'HH24:MI') AS working_time_HHMM
FROM uber_data
GROUP BY driver_id,request_weekday
ORDER BY driver_id ;

---Drivers count duration wise(overall week)
 Select 
 Case
     when working_hrs <4 then '<4hrs'
	 when working_hrs >4 and working_hrs <=6 then '4-6hrs'
	 when working_hrs >6 and working_hrs <=8 then '6-8hrs'
	 when working_hrs >8 and working_hrs <=10 then '8-10hrs'
	 else '>10hrs'
	 end as Working_hrs_dura,
count(driver_id) as Drivers_count
from (
select driver_id,
extract(EPOCH from(sum(duration_minutes)*interval '1 minute'))/3600 as working_hrs
from Uber_data
group by driver_id
) as t
group by Working_hrs_dura;


-- number of trips completed by each driver in a week
Select driver_id,count(status) as number_of_trips_completed
from Uber_data 
where status='Trip Completed'
group by driver_id;

-- Number of trip completed drivers by each day
Select driver_id,request_weekday,count(status) as number_of_trips_completed
from Uber_data 
where status='Trip Completed'
group by driver_id,request_weekday;


