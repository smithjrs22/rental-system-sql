# rental-system-sql

--1) Customer 'Angel' has rented 'SBA1111A' from today for 10 days.

INSERT INTO rental_records 
VALUES(
NULL,
'SBA1111A',
(SELECT customer_id
FROM customers
WHERE name = 'Angel'),
CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY),
NULL)


--2) Customer 'Kumar' has rented 'GA5555E' from tomorrow for 3 months.

INSERT INTO rental_records 
(rental_id, veh_reg_no, customer_id, start_date, end_date)
VALUES
 (NULL,
    'GA5555E', 
    (SELECT customer_id FROM customers WHERE name='Kumar'),
    DATE_ADD(CURDATE(), INTERVAL 1 DAY),
    DATE_ADD(CURDATE(), INTERVAL 3 month),
    NULL); 


--3) List all rental records (start date, end date) with vehicle's registration number, brand, customer name, sorted by vehicle's categories followed by start date.
	
SELECT start_date, end_date, veh_reg_no, brand, name
FROM rental_records 
JOIN vehicles  USING (veh_reg_no)
JOIN customers USING (customer_id)
ORDER BY category, start_date;
	
	
--4) List all the expired rental records (end_date before CURDATE()).
	
 SELECT * FROM rental_records WHERE end_date < CURDATE();
	

--5) List the vehicles rented out on '2012-01-10' (not available for rental), in columns of vehicle registration no, customer name, start date and end date. 

SELECT veh_reg_no, name, start_date, end_date
FROM customers join rental_records using (customer_id)
WHERE start_date < '2012-01-10' and end_date > '2012-01-10';


--6) List all vehicles rented out today, in columns registration number, customer name, start date, end date.

SELECT  veh_reg_no, name, start_date, end_date
FROM rental_records
JOIN customers USING (customer_id)
WHERE CURDATE() BETWEEN start_date AND end_date;


--7) Similarly, list the vehicles rented out (not available for rental) for the period from '2012-01-03' to '2012-01-18'. 

SELECT veh_reg_no, name, start_date, end_date
FROM rental_records 
JOIN vehicles USING (veh_reg_no)
JOIN customers  USING (customer_id)
WHERE start_date BETWEEN '2012-01-03' AND '2012-01-18'
OR end_date BETWEEN '2012-01-03' AND '2012-01-18'
OR (start_date < '2012-01-03' AND end_date > '2012-01-18');

--8) List the vehicles (registration number, brand and description) available for rental (not rented out) on '2012-01-10' (

SELECT veh_reg_no, brand, vehicles.desc
FROM vehicles
WHERE
veh_reg_no NOT IN
(SELECT DISTINCT veh_reg_no FROM rental_records
WHERE '2012-01-10' BETWEEN start_date AND end_date);

--9) Similarly, list the vehicles available for rental for the period from '2012-01-03' to '2012-01-18'.

SELECT veh_reg_no, brand, vehicles.desc
FROM vehicles join rental_records using (veh_reg_no)
WHERE not (
(start_date >= '2012-01-03' and start_date <= '2012-01-18') 
OR (end_date >= '2012-01-03' and end_date <= '2012-01-18')
OR (start_date <= '2012-01-03' and end_date >= '2012-01-18')
);


--10) Similarly, list the vehicles available for rental from today for 10 days.

SELECT veh_reg_no, brand, vehicles.desc 
FROM vehicles 
WHERE veh_reg_no not in (
SELECT veh_reg_no 
FROM rental_records 
WHERE start_date >= curdate() and end_date > curdate() + 10);
