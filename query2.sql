-- Retrieve All Orders With Buyer Details
SELECT o.orderNumber, u.name AS buyerName, u.phoneNum, o.creationTime, o.paymentStatus, o.totalAmount
FROM Orders o
JOIN User u ON o.userId = u.userId
WHERE u.role = 'buyer';
-- List Products Available in a Specific Store
SELECT p.pid, p.name AS productName, p.brand, p.price, s.name AS storeName
FROM Product p
JOIN Store s ON p.sid = s.sid
WHERE s.name = 'Store A';
-- Show Order History for a Specific User
SELECT o.orderNumber, o.creationTime, o.totalAmount, o.paymentStatus
FROM Orders o
JOIN User u ON o.userId = u.userId
WHERE u.name = 'Alice';
-- Calculate Total Sales Per Store
SELECT s.sid, s.name AS storeName, SUM(o.totalAmount) AS totalSales
FROM Orders o
JOIN User u ON o.userId = u.userId
JOIN Product p ON u.userId = p.sid
JOIN Store s ON p.sid = s.sid
GROUP BY s.sid, s.name;
--  Find Most Popular Product Based on Orders
SELECT p.pid, p.name, COUNT(oi.itemid) AS totalOrders
FROM OrderItem oi
JOIN Product p ON oi.pid = p.pid
GROUP BY p.pid, p.name
ORDER BY totalOrders DESC
LIMIT 1;
-- Retrieve Unpaid Orders
SELECT orderNumber, userId, creationTime, totalAmount
FROM Orders
WHERE paymentStatus = 'Pending';
-- Count the Total Number of Buyers and Sellers
SELECT role, COUNT(*) AS totalUsers
FROM User
GROUP BY role;
-- List Products in Shopping Cart for a User
SELECT sc.userId, u.name, p.name AS productName, sc.quantity, p.price
FROM ShoppingCart sc
JOIN User u ON sc.userId = u.userId
JOIN Product p ON sc.pid = p.pid
WHERE u.name = 'Charlie';
-- Show Delivery Addresses for Orders
SELECT a.addrid, a.name, a.streetAddr, a.city, a.province, a.contactPhoneNumber, d.orderNumber, d.TimeDelivered
FROM DeliverTo d
JOIN Address a ON d.addrid = a.addrid;
-- Find Orders Paid Using a Specific Bank
SELECT p.paymentId, p.orderNumber, p.amount, b.bank, u.name AS userName
FROM Payment p
JOIN BankCard b ON p.cardNumber = b.cardNumber
JOIN User u ON b.userId = u.userId
WHERE b.bank = 'Bank A';








