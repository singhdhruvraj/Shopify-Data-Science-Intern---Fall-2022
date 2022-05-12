/* a. How many orders were shipped by Speedy Express in total? */
SELECT COUNT(OrderID) AS No_of_Orders 
FROM Orders JOIN Shippers
ON Orders.ShipperID = Shippers.ShipperID 
AND Shippers.ShipperName = "Speedy Express"; 


/* b. What is the last name of the employee with the most orders? */
WITH temptable AS (
SELECT EmployeeID 
FROM Orders 
GROUP BY EmployeeID 
ORDER BY COUNT(EmployeeID) DESC 
LIMIT 1) 
SELECT LastName 
FROM Employees JOIN temptable 
ON Employees.EmployeeID = temptable.EmployeeID;

/* c. What product was ordered the most by customers in Germany? */
WITH temptable1 AS 
(SELECT CustomerID FROM Customers Where Country = 'Germany'), 
temptable2 as (SELECT OrderID FROM Orders JOIN temptable1 
ON Orders.CustomerID = temptable1.CustomerID), 
temptable3 as (SELECT ProductID, Quantity FROM OrderDetails JOIN temptable2 
ON OrderDetails.OrderID = temptable2.OrderID), 
temptable4 as (SELECT ProductID FROM temptable3 
GROUP BY ProductID 
ORDER BY COUNT(ProductID) DESC 
LIMIT 1)  
SELECT ProductName 
FROM Products JOIN temptable4 
ON Products.ProductID = temptable4.ProductID;
