CREATE DATABASE Hotel;
USE  Hotel ;


CREATE TABLE Guests (
    GuestID INT  PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);


CREATE TABLE Rooms (
    RoomID INT  PRIMARY KEY,
    RoomNumber INT NOT NULL UNIQUE,
    RoomType VARCHAR(50),
    Capacity INT,
    PricePerNight DECIMAL(10, 2),
    Status VARCHAR(50) 
);


CREATE TABLE Reservations (
    ReservationID INT  PRIMARY KEY,
    GuestID INT,
    RoomID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalCost DECIMAL(10, 2),
    Status VARCHAR(50), 
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);


CREATE TABLE Employees1 (
    EmployeeID INT  PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);


CREATE TABLE Services2 (
    ServiceID INT  PRIMARY KEY,
    ServiceName VARCHAR(50),
    Description VARCHAR(255),
    Price DECIMAL(10, 2)
);


CREATE TABLE ServiceUsage2 (
    ServiceUsageID INT  PRIMARY KEY,
    GuestID INT,
    ServiceID INT,
    UsageDate DATE,
    Quantity INT,
    TotalCost DECIMAL(10, 2),
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID),
    FOREIGN KEY (ServiceID) REFERENCES Services2(ServiceID)
);

INSERT INTO Guests (GuestID,FirstName, LastName, Email, Phone, Address) VALUES
(1,'ali', 'aslam', 'ali@gmail.com', '03297828', 'wapda town'),
(2,'asma', 'ali', 'asma@gmail.com', '03276558', 'johar town'),
(3,'nahin', 'nasir', 'nahin@gmail.com', '03286558', 'model town'),
(4,'aysha', 'ashraf', 'aysha@gmail.com', '03276098', 'faisal town'),
(5,'kiran', 'ali', 'kiran@gmail.com', '03293558', 'johar town');

INSERT INTO Rooms (RoomID,RoomNumber, RoomType, Capacity, PricePerNight, Status) VALUES
(101,23,'Single', 1, 100.00, 'Available'),
(102,24, 'Double', 2, 150.00, 'Occupied'),
(103,25, 'Suite', 4, 300.00, 'Available'),
(104,26, 'single', 2, 150.00, 'Occupied'),
(105,27, 'Double', 2, 150.00, 'Occupied');


INSERT INTO Employees1 (EmployeeID,FirstName, LastName, Position, Email, Phone, Address) VALUES
(401,'Aliza', 'Jafar', 'Manager', 'aliza@gmail.com', '0328964384', 'link Road'),
(402,'Asma', 'kadeer', 'Receptionist', 'asma@gmail.com', '0328996884', 'johar town'),
(403,'hasan', 'farooq', 'Manager', 'hasan@gmail.com', '03286392549', 'cantt'),
(404,'mirha', 'sheikh', 'house keeper', 'mirha@gmail.com', '0328034384', 'model town'),
(405,'minahil', 'safdar', 'Manager', 'minahil@gmail.com', '03289274384', 'link Road');

INSERT INTO Services2 (ServiceID,ServiceName, Description, Price) VALUES
(5001,'Spa', 'Relaxation and beauty treatments', 50.00),
(5002,'Fitness Center', 'Access to gym facilities', 10.00),
(5003,'Airport Shuttle', 'Transportation to and from the airport', 25.00),
(5004,'Breakfast Buffet', 'All-you-can-eat breakfast', 15.00),
(5005,'WiFi', 'High-speed internet access', 5.00);

INSERT INTO Reservations (ReservationID,GuestID, RoomID, CheckInDate, CheckOutDate, TotalCost, Status) VALUES
(201,1, 102, '2024-07-01', '2024-07-03', 300.00, 'Confirmed'),
(202,2, 101, '2024-07-05', '2024-07-10', 500.00, 'Checked-Out'),
(203,1, 103, '2024-07-15', '2024-07-20', 1500.00, 'Confirmed'),
(204,3, 101, '2024-07-22', '2024-07-25', 300.00, 'Confirmed'),
(205,4, 102, '2024-07-25', '2024-07-28', 450.00, 'Cancelled');


INSERT INTO ServiceUsage2 (ServiceUsageID,GuestID, ServiceID, UsageDate, Quantity, TotalCost) VALUES
(301,1, 5001, '2024-07-01', 2, 40.00),   
(302,2, 5003, '2024-07-06', 1, 25.00),   
(303,1, 5004, '2024-07-02', 3, 45.00),   
(304,3, 5005, '2024-07-23', 5, 25.00),   
(305,4, 5002, '2024-07-27', 1, 15.00);   
select* from Guests;

select* from Rooms;
select* from Reservations;
select* from Services2;
select* from ServiceUsage2;
select* from Employees1;
SELECT * FROM Rooms WHERE Status = 'Available';
SELECT * FROM Reservations WHERE GuestID = 1;
SELECT SU.ServiceUsageID, S.ServiceName, SU.UsageDate, SU.Quantity, SU.TotalCost
FROM ServiceUsage2 SU
JOIN Services2 S ON SU.ServiceID = S.ServiceID
WHERE SU.GuestID = 1;
SELECT SUM(TotalCost) AS TotalRevenue FROM Reservations WHERE Status = 'Confirmed' OR Status = 'Checked-Out';
SELECT * FROM Employees WHERE Position = 'Manager';
SELECT R.RoomType, COUNT(*) AS NumberOfReservations
FROM Reservations Res
JOIN Rooms R ON Res.RoomID = R.RoomID
GROUP BY R.RoomType;
SELECT Res.*, G.FirstName, G.LastName
FROM Reservations Res
JOIN Guests G ON Res.GuestID = G.GuestID
WHERE Res.Status = 'Cancelled';
SELECT TOP 2 SU.ServiceID, S.ServiceName, COUNT(*) AS UsageCount
FROM ServiceUsage2 SU
JOIN Services2 S ON SU.ServiceID = S.ServiceID
GROUP BY SU.ServiceID, S.ServiceName
ORDER BY UsageCount DESC;
SELECT SU.GuestID, G.FirstName, G.LastName, SUM(SU.TotalCost) AS TotalSpent
FROM ServiceUsage2 SU
JOIN Guests G ON SU.GuestID = G.GuestID
GROUP BY SU.GuestID, G.FirstName, G.LastName;
SELECT SU.ServiceUsageID, G.FirstName, G.LastName, S.ServiceName, SU.UsageDate, SU.Quantity, SU.TotalCost
FROM ServiceUsage2 SU
JOIN Guests G ON SU.GuestID = G.GuestID
JOIN Services2 S ON SU.ServiceID = S.ServiceID;
UPDATE Employees1
SET Phone = '0376543210', Address = 'dha'
WHERE EmployeeID = 403;
SELECT * FROM Employees WHERE Email LIKE 'hasan@gmail.com';







