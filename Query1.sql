-- Retrieve all orders with buyers details
SELECT o.orderNumber, u.name AS buyerName, u.phoneNum, o.creationTime, o.paymentStatus, o.totalAmount
FROM Orders o
JOIN User u ON o.userId = u.userId
WHERE u.role = 'buyer';
-- Retrieve all buyers
SELECT userId, name, phoneNum FROM User WHERE role = 'buyer';
-- Retrieve all sellers and their stores
SELECT U.userId, U.name, S.name AS storeName 
FROM User U 
JOIN Manage M ON U.userId = M.userId 
JOIN Store S ON M.sid = S.sid;
-- Retrieve all products with store details
SELECT P.pid, P.name AS productName, P.brand, P.price, S.name AS storeName, S.city 
FROM Product P 
JOIN Store S ON P.sid = S.sid;
-- Retrieve orders along with buyer details
SELECT O.orderNumber, U.name AS buyerName, O.creationTime, O.totalAmount, O.paymentStatus 
FROM Orders O 
JOIN Contain C ON O.orderNumber = C.orderNumber
JOIN OrderItem OI ON C.itemid = OI.itemid
JOIN Product P ON OI.pid = P.pid
JOIN Store S ON P.sid = S.sid
JOIN Manage M ON S.sid = M.sid
JOIN User U ON M.userId = U.userId
WHERE U.role = 'buyer';
-- Retrieve total sales per store
SELECT S.name AS storeName, SUM(O.totalAmount) AS totalSales 
FROM Orders O
JOIN Contain C ON O.orderNumber = C.orderNumber
JOIN OrderItem OI ON C.itemid = OI.itemid
JOIN Product P ON OI.pid = P.pid
JOIN Store S ON P.sid = S.sid
GROUP BY S.sid;
-- Retrieve top 10 highest-rated products
SELECT pid, name, brand, customerReview 
FROM Product 
ORDER BY customerReview DESC 
LIMIT 10;