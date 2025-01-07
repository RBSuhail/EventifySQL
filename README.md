 

# Event Management System - SQL Queries 

Welcome to the **Event Management and Attendance Tracking System**. This repository contains SQL queries that manage events, members, and organisers in a structured way. This system tracks member participation, calculates revenue, updates membership types, and handles event-related information.

### **Scenario Overview**

This system allows organisers to create and manage events, while members can register and participate in those events. Based on the number of events attended, members' status can be upgraded to **gold membership**, which grants them special perks like discounts. Additionally, the system handles invoices, ensuring that each event's quota is respected and that members are invoiced accordingly.

---

## **SQL Queries:**

### **1) Find the events that will be hosted in New York.**
```sql
-- Find all events organised in New York City
SELECT *
FROM Organization
WHERE City = 'New York';
```
Explanation: Retrieves all events that are hosted in New York.

### **2) Find the event with the highest attendance and its total revenue (event name, category, and organiser’s name).**
```sql
-- Find the event with the highest attendance and calculate the total revenue
SELECT Organization.Name AS EventName,
Organization.Category AS CategoryName,
Organization.OrganizatorName,
COUNT(Members.EventID) AS Attendance,
(Organization.Price * COUNT(Members.EventID)) AS TotalRevenue
FROM Organization
JOIN Members ON Members.EventID = Organization.OrganizationID
GROUP BY Organization.Name, Organization.Category, Organization.OrganizatorName, Organization.Price
ORDER BY Attendance DESC
LIMIT 1;
```
Explanation: Finds the event with the highest attendance and calculates the total revenue based on the number of attendees.

### **3) Find the total number of events for each category in descending order.**
```sql
-- Count the number of events for each category, ordered by the number of events in descending order
SELECT Category, COUNT(*) AS EventCount
FROM Organization
GROUP BY Category
ORDER BY EventCount DESC;
```
Explanation: This query returns the number of events for each category and orders them in descending order.

### **4) Find the past events in which members aged between 18-25 participated.**
```sql
-- Find past events where members aged 18-25 participated
SELECT Organization.Name AS EventName,
Members.Name AS MemberName,
Members.SurName AS MemberSurName
FROM Organization
JOIN Members ON Organization.OrganizationID = Members.EventID
WHERE Organization.EndDate < CURDATE()
AND TIMESTAMPDIFF(YEAR, Members.BirthDate, CURDATE()) BETWEEN 18 AND 25;
```
Explanation: Filters past events where members are aged between 18 and 25.

### **5) Find the past events in which the total number of participants is less than 3.**
```sql
-- Find past events with fewer than 3 participants
SELECT Organization.Name AS EventName
FROM Organization
JOIN Members ON Organization.OrganizationID = Members.EventID
WHERE Organization.EndDate < CURDATE()
GROUP BY Organization.Name, Organization.OrganizationID
HAVING COUNT(Members.MembersID) < 3;
```
Explanation: This query returns past events where the total number of participants is less than 3.

### **6) List the members who attended at least 3 events and update their membership type to gold.**
```sql
-- List members who attended at least 3 events
SELECT MembersID, Name, SurName
FROM Members
GROUP BY MembersID
HAVING COUNT(EventID) >= 3;

-- Update the membership type to 'gold' for these members
UPDATE Members
SET Type = 'gold'
WHERE MembersID IN (SELECT MembersID FROM Members GROUP BY MembersID HAVING COUNT(EventID) >= 3);
```
Explanation: Identifies members who attended 3 or more events and updates their membership type to gold.

### **7) Delete "technology" events organised at Tech University on 19th May 2024.**
```sql
-- Delete "technology" events organised by Tech University on 19th May 2024
DELETE FROM Organization
WHERE Category = 'technology'
AND Address = 'Tech University'
AND StartDate = '2024-05-19'
AND EndDate = '2024-05-19';
```
Explanation: Deletes technology events organised by Tech University on 19th May 2024.

### **8) Return the member’s email address who paid the most for events.**
```sql
-- Find the email address of the member who paid the most for events
SELECT Members.Email
FROM Members
JOIN Organization ON Members.EventID = Organization.OrganizationID
WHERE Organization.Price = (SELECT MAX(Price) FROM Organization);
```
Explanation: Retrieves the email address of the member who paid the highest price for an event.

### **9) Update the discount rate of events in cities starting with 'L' as "30%".**
```sql
-- Apply a 30% discount to events held in cities starting with 'L'
UPDATE Organization
SET Description = 'Discount 30%', Price = Price - Price * 0.30
WHERE City LIKE 'L%';
```
Explanation: Applies a 30% discount to events held in cities starting with 'L'.

### **10) Delete the members who have not participated in any events.**
```sql
-- Delete members who have not participated in any events
DELETE FROM Members
WHERE MembersID NOT IN (SELECT DISTINCT MembersID FROM Members WHERE EventID IS NOT NULL);
```
Explanation: This query removes members who have not participated in any events (i.e., their EventID is NULL).
```
