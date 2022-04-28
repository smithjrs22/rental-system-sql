INSERT INTO rental_records VALUES(
NULL,
'SBA1111A',
(
SELECT customer_id
FROM customers
WHERE name = 'Angel'),
CURDATE(),
DATE_ADD(CURDATE(), INTERVAL 10 DAY),
NULL
)