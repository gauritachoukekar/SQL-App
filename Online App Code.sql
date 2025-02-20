CREATE DATABASE OnlineApp;
USE OnlineApp;
-- User Table
CREATE TABLE User (
    userId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phoneNum VARCHAR(15) UNIQUE NOT NULL,
    role ENUM('buyer', 'seller') NOT NULL
);
INSERT INTO User (name, phoneNum, role) VALUES
('Alice', '123456789012', 'buyer'),
('Bob', '12345678910', 'seller'),
('Charlie', '12345678928', 'buyer'),
('David', '12345678937', 'seller'),
('Emma', '12345678940', 'buyer'),
('Frank', '12345678956', 'seller'),
('Grace', '12345678961', 'buyer'),
('Hannah', '12345678972', 'seller'),
('Ivy', '12345678983', 'buyer'),
('Jack', '123456789978', 'seller');
-- Order Table
CREATE TABLE Orders (
    orderNumber INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    creationTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    paymentStatus ENUM('pending', 'completed', 'failed') NOT NULL,
    totalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
    
);
INSERT INTO Orders (userId, paymentStatus, totalAmount) VALUES
( 1, 'Completed', 150.75),
(2, 'Pending', 200.50),
(3, 'Completed', 99.99),
(4, 'Completed', 175.00),   -- David's order  
(5, 'Pending', 120.25),     -- Emma's order  
(6, 'Completed', 300.00),   -- Frank's order  
(7, 'Pending', 80.99),      -- Grace's order  
(8, 'Completed', 220.45),   -- Hannah's order  
(9, 'Pending', 135.75),     -- Ivy's order  
(10, 'Completed', 250.60);  -- Jack's order  
-- Store Table
CREATE TABLE Store (
    sid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    startTime DATE NOT NULL,
    customerGrade VARCHAR(50),
    streetAddr VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL
);
INSERT INTO Store (name, startTime, customerGrade, streetAddr, city, province) VALUES
('Store A', '2020-01-01', 'Gold', '123 Main St', 'New York', 'NY'),
('Store B', '2019-05-15', 'Silver', '456 Elm St', 'Los Angeles', 'CA'),
('Store C', '2021-07-20', 'Gold', '789 Oak St', 'Chicago', 'IL'),
('Store D', '2018-09-30', 'Platinum', '101 Pine St', 'Houston', 'TX'),
('Store E', '2017-03-10', 'Silver', '202 Maple St', 'Miami', 'FL'),
('Store F', '2022-02-14', 'Gold', '303 Birch St', 'Boston', 'MA'),
('Store G', '2020-06-25', 'Bronze', '404 Cedar St', 'Seattle', 'WA'),
('Store H', '2021-11-05', 'Platinum', '505 Walnut St', 'San Francisco', 'CA'),
('Store I', '2019-12-12', 'Silver', '606 Spruce St', 'Denver', 'CO'),
('Store J', '2022-08-22', 'Gold', '707 Fir St', 'Austin', 'TX');
-- Product Table
CREATE TABLE Product (
    pid INT PRIMARY KEY AUTO_INCREMENT,
    sid INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(100),
    type VARCHAR(100),
    amount INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    colour VARCHAR(50),
    customerReview TEXT,
    modelNumber VARCHAR(100),
    FOREIGN KEY (sid) REFERENCES Store(sid) ON DELETE CASCADE
);
INSERT INTO Product (sid, name, brand, type, amount, price, colour, customerReview, modelNumber) VALUES
(1, 'Laptop', 'Brand A', 'Electronics', 50, 999.99, 'Black', 'Great laptop!', 'A123'),
(2, 'Phone', 'Brand B', 'Electronics', 100, 499.99, 'Silver', 'Amazing phone!', 'B456'),
(3, 'Headphones', 'Brand C', 'Accessories', 200, 79.99, 'Red', 'Superb sound!', 'C789'),
(4, 'TV', 'Brand D', 'Appliances', 30, 799.99, 'Black', 'Crystal clear display!', 'D321'),
(5, 'Washing Machine', 'Brand E', 'Appliances', 20, 599.99, 'White', 'Cleans well!', 'E654'),
(6, 'Refrigerator', 'Brand F', 'Appliances', 25, 899.99, 'Grey', 'Keeps food fresh!', 'F987'),
(7, 'Microwave', 'Brand G', 'Appliances', 40, 199.99, 'Silver', 'Works great!', 'G159'),
(8, 'Smartwatch', 'Brand H', 'Wearables', 150, 199.99, 'Black', 'Nice features!', 'H753'),
(9, 'Tablet', 'Brand I', 'Electronics', 70, 299.99, 'Gold', 'Very smooth!', 'I852'),
(10, 'Camera', 'Brand J', 'Photography', 60, 499.99, 'Black', 'High-quality pictures!', 'J951');
-- Manage Relationship (Seller - Store)
CREATE TABLE Manage (
    userId INT NOT NULL,
    sid INT NOT NULL,
    setupTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (userId, sid),
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE,
    FOREIGN KEY (sid) REFERENCES Store(sid) ON DELETE CASCADE
);
INSERT INTO Manage (userId, sid) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);
-- Order Item Table
CREATE TABLE OrderItem (
    itemid INT PRIMARY KEY AUTO_INCREMENT,
    pid INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    creationTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL,
    FOREIGN KEY (pid) REFERENCES Product(pid) ON DELETE CASCADE
);
INSERT INTO OrderItem (pid, price, quantity) VALUES
(1, 999.99, 2),  -- Laptop (2 units)
(2, 499.99, 3),  -- Phone (3 units)
(3, 79.99, 5),   -- Headphones (5 units)
(4, 799.99, 1),  -- TV (1 unit)
(5, 599.99, 2),  -- Washing Machine (2 units)
(6, 899.99, 1),  -- Refrigerator (1 unit)
(7, 199.99, 4),  -- Microwave (4 units)
(8, 199.99, 3),  -- Smartwatch (3 units)
(9, 299.99, 2),  -- Tablet (2 units)
(10, 499.99, 1); -- Camera (1 unit)
-- Contain Relationship (Order - Order Item)
CREATE TABLE Contain (
    orderNumber INT NOT NULL,
    itemid INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (orderNumber, itemid),
    FOREIGN KEY (orderNumber) REFERENCES Orders (orderNumber) ON DELETE CASCADE,
    FOREIGN KEY (itemid) REFERENCES OrderItem(itemid) ON DELETE CASCADE
);
INSERT INTO Contain (orderNumber, itemid, quantity) VALUES
(1, 1, 2),  -- Order 1 contains 2 Laptops
(1, 3, 5),  -- Order 1 contains 5 Headphones
(2, 2, 3),  -- Order 2 contains 3 Phones
(3, 4, 1),  -- Order 3 contains 1 TV
(3, 5, 2);  -- Order 3 contains 2 Washing Machines

-- Shopping Cart
CREATE TABLE ShoppingCart (
    userId INT NOT NULL,
    pid INT NOT NULL,
    quantity INT NOT NULL,
    addTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (userId, pid),
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES Product(pid) ON DELETE CASCADE
);
INSERT INTO ShoppingCart (userId, pid, quantity) VALUES
(1, 1, 2),  -- Alice adds 2 Laptops to her cart
(1, 2, 1),  -- Alice adds 1 Phone to her cart
(2, 3, 4),  -- Bob adds 4 Headphones to his cart
(2, 4, 1),  -- Bob adds 1 TV to his cart
(3, 5, 2),  -- Charlie adds 2 Washing Machines to his cart
(3, 6, 1);  -- Charlie adds 1 Refrigerator to his cart
-- Address Table
CREATE TABLE Address (
    addrid INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postalCode VARCHAR(20) NOT NULL,
    streetAddr VARCHAR(255) NOT NULL,
    province VARCHAR(100) NOT NULL,
    contactPhoneNumber VARCHAR(15) NOT NULL,
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);
INSERT INTO Address (userId, name, city, postalCode, streetAddr, province, contactPhoneNumber) VALUES
(1, 'Alice', 'New York', '10001', '123 Main St', 'New York', '555-1234'),
(2, 'Bob', 'Los Angeles', '90001', '456 Oak St', 'California', '555-5678'),
(3, 'Charlie', 'Chicago', '60601', '789 Pine St', 'Illinois', '555-9876'),
(4, 'David', 'Houston', '77001', '321 Elm St', 'Texas', '555-4321'),
(5, 'Emma', 'San Francisco', '94101', '654 Maple St', 'California', '555-8765'),
(6, 'Frank', 'Seattle', '98101', '987 Cedar St', 'Washington', '555-3456'),
(7, 'Grace', 'Boston', '02101', '159 Birch St', 'Massachusetts', '555-6543'),
(8, 'Hannah', 'Miami', '33101', '753 Palm St', 'Florida', '555-7890'),
(9, 'Ivy', 'Denver', '80201', '852 Aspen St', 'Colorado', '555-2345'),
(10, 'Jack', 'Atlanta', '30301', '951 Peachtree St', 'Georgia', '555-6789');
CREATE TABLE DeliverTo (
    addrid INT NOT NULL,
    orderNumber INT NOT NULL,
    timeDelivered DATETIME,
    PRIMARY KEY (addrid, orderNumber),
    FOREIGN KEY (addrid) REFERENCES Address(addrid) ON DELETE CASCADE,
    FOREIGN KEY (orderNumber) REFERENCES Orders(orderNumber) ON DELETE CASCADE
);
INSERT INTO DeliverTo (addrid, orderNumber, timeDelivered) VALUES
(1, 1, '2025-02-17 10:00:00'),  -- Alice's order 101 delivered at a specific time
(2, 2, '2025-02-17 11:30:00'),  -- Bob's order 102 delivered at a specific time
(3, 3, '2025-02-17 12:00:00'),  -- Charlie's order 103 delivered at a specific time
(4, 4, '2025-02-17 13:15:00'),  -- David's order 104  
(5, 5, '2025-02-17 14:00:00'),  -- Emma's order 105  
(6, 6, '2025-02-17 14:45:00'),  -- Frank's order 106  
(7, 7, '2025-02-17 15:30:00'),  -- Grace's order 107  
(8, 8, '2025-02-17 16:00:00'),  -- Hannah's order 108  
(9, 9, '2025-02-17 16:45:00'),  -- Ivy's order 109  
(10, 10, '2025-02-17 17:30:00'); -- Jack's order 110  
CREATE TABLE BankCard (
    cardNumber VARCHAR(20) PRIMARY KEY,
    userId INT NOT NULL,
    bank VARCHAR(100) NOT NULL,
    expiryDate DATE NOT NULL,
    cardType ENUM('credit', 'debit') NOT NULL,
    organization VARCHAR(100),
    FOREIGN KEY (userId) REFERENCES User(userId) ON DELETE CASCADE
);
INSERT INTO BankCard (cardNumber, userId, bank, expiryDate, cardType, organization) VALUES
('01111-2222-3333-4444', 1, 'Bank A', '2026-12-31', 'credit', 'Visa'),
('62222-3333-4444-5555', 3, 'Bank B', '2025-10-30', 'debit', NULL),
('83333-4444-5555-6666', 5, 'Bank C', '2027-05-15', 'credit', 'MasterCard'),
('42444-5555-6666-7777', 7, 'Bank D', '2026-07-20', 'debit', NULL),
('55855-6666-7777-8888', 9, 'Bank E', '2028-11-25', 'credit', 'Visa'),
('66696-7777-8888-9999', 2, 'Bank F', '2026-09-14', 'debit', NULL),
('77776-8888-9999-0000', 4, 'Bank G', '2025-08-05', 'credit', 'MasterCard'),
('88883-9999-0000-1111', 6, 'Bank H', '2027-03-18', 'debit', NULL),
('99992-0000-1111-2222', 8, 'Bank I', '2026-06-22', 'credit', 'Visa'),
('00001-1111-2222-3333', 10, 'Bank J', '2025-04-12', 'debit', NULL);
-- Payment Table
CREATE TABLE Payment (
    paymentId INT PRIMARY KEY AUTO_INCREMENT,
    cardNumber VARCHAR(20) NOT NULL,
    orderNumber INT NOT NULL,
    payTime DATETIME NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cardNumber) REFERENCES BankCard(cardNumber),
    FOREIGN KEY (orderNumber) REFERENCES Orders(orderNumber)
);
INSERT INTO Payment (cardNumber, orderNumber, payTime, amount) VALUES
('01111-2222-3333-4444', 1, '2024-02-01 10:20:00', 150.75),  
('66696-7777-8888-9999', 2, '2024-02-02 14:35:00', 200.50),  
('62222-3333-4444-5555', 3, '2024-02-03 09:50:00', 99.99),  
('77776-8888-9999-0000', 4, '2024-02-04 11:15:00', 175.00),  
('83333-4444-5555-6666', 5, '2024-02-05 16:45:00', 120.25),  
('88883-9999-0000-1111', 6, '2024-02-06 12:30:00', 300.00),  
('42444-5555-6666-7777', 7, '2024-02-07 13:20:00', 80.99),  
('99992-0000-1111-2222', 8, '2024-02-08 15:10:00', 220.45),  
('55855-6666-7777-8888', 9, '2024-02-09 17:05:00', 135.75),  
('00001-1111-2222-3333', 10, '2024-02-10 19:00:00', 250.60);  
