USE [Online Shopping System];
CREATE TABLE Customers(
     ID INT IDENTITY PRIMARY KEY,
	 Name NVARCHAR(100) NOT NULL,
	 Email VARCHAR(100) UNIQUE NOT NULL,
	 Address NVARCHAR(100) NOT NULL,
	 PhoneNumber NVARCHAR(20) NOT NULL,
);

CREATE TABLE Products(
      ID INT IDENTITY PRIMARY KEY,
	  Name NVARCHAR(100) NOT NULL,
	  Description NVARCHAR(100) NOT NULL,
	  Category NVARCHAR (50) NOT NULL,
	  Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Suppliers(
     ID INT IDENTITY PRIMARY KEY,
	 Name NVARCHAR(100) NOT NULL,
	 ContactInfo NVARCHAR(100) NOT NULL,
);

CREATE TABLE Orders(
     ID INT IDENTITY PRIMARY KEY,
	 OrderStatus NVARCHAR(50) CHECK (OrderStatus IN
	 ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
	 DEFAULT 'Pending',
	 TotalAmount DECIMAL (10,2),
	 OrderDate DATETIME DEFAULT GETUTCDATE(),
	 CustomerID INT NOT NULL,
	 FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
);

CREATE TABLE OrderDetails(
      ID INT IDENTITY PRIMARY KEY,
      Quantity INT NOT NULL,
	  Price DECIMAL(10,2) NOT NULL,
);

CREATE TABLE ProductOrderDetails(
      ProductID INT NOT NULL,
	  OrderDetailsID INT NOT NULL,
	  PRIMARY KEY(ProductID, OrderDetailsID),
	  FOREIGN KEY (ProductID) REFERENCES Products(ID),
	  FOREIGN KEY (OrderDetailsID) REFERENCES OrderDetails(ID)
);

CREATE TABLE ProductOrder(
      ProductID INT NOT NULL,
	  OrderID INT NOT NULL,
	  PRIMARY KEY(ProductID, OrderID),
	  FOREIGN KEY (ProductID) REFERENCES Products(ID),
	  FOREIGN KEY (OrderID) REFERENCES Orders(ID)
);

CREATE TABLE ProductSuppliers(
      ProductID INT NOT NULL,
	  SupplierID INT NOT NULL,
	  PRIMARY KEY(ProductID, SupplierID),
	  FOREIGN KEY (ProductID) REFERENCES Products(ID),
	  FOREIGN KEY (SupplierID) REFERENCES Suppliers(ID)
);

INSERT INTO Customers(Name, Email, Address, PhoneNumber) VALUES
('Bruce Wayne', 'brucewayne@gmail.com', 'Gotham City', '123-456-789'),
('Tony Stark', 'tonystark@gmail.com', 'New York City', '123-456-789');

INSERT INTO Products(Name, Description, Category, Price) VALUES
('Armored Batmobile', 'Custom high-speed vehicle', 'Vehicles',99999999.99),
('AI Smart Assistant', 'Advanced AI-powered assisstant', 'Tech Gadgets', 9999999.99);

INSERT INTO Suppliers(Name, ContactInfo) VALUES 
('Wayne Tech', '123-456-789'),
('Stark Industries', '123-456-789');

INSERT INTO Orders(OrderStatus, TotalAmount, OrderDate) VALUES
('Pending', '10000.99', '2025-02-02 14:30:00'),
('Delivered', '10000.99', '2025-02-02 14:30:00');

INSERT INTO OrderDetails(Quantity, Price, CustomerID) VALUES
(2, 10000.99, 1),
(3, 10000.99, 2 );

INSERT INTO ProductOrderDetails(ProductID, OrderDetailsID)
VALUES (1, 1),
(2,2);

INSERT INTO ProductOrder(ProductID, OrderID)
VALUES (1, 1),
(2,2);

INSERT INTO ProductSuppliers(ProductID, SupplierID)
VALUES (1, 1),
(2,2);