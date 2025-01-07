CREATE TABLE Organizator(
OrganizatorID INT PRIMARY KEY,
UserName TEXT NOT NULL,
Password TEXT NOT NULL
);
CREATE TABLE Organization(
OrganizationID INT PRIMARY KEY,
Category TEXT NOT NULL,
Name TEXT NOT NULL,
Address TEXT NOT NULL,
County TEXT NOT NULL,
City TEXT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
Price INT NOT NULL,
Quota INT NOT NULL,
Description TEXT NULL,
OrganizatorName TEXT NOT NULL,
OrganizatorID INT,
FOREIGN KEY (OrganizatorID) REFERENCES Organizator (OrganizatorID)
);
CREATE TABLE Members(
MembersID INT NOT NULL,
Name TEXT NOT NULL,
SurName TEXT NOT NULL,
MembersUserName TEXT NOT NULL,
MembersPassword TEXT NOT NULL,
BirthDate DATE NOT NULL,
Email TEXT NOT NULL,
EventID INT NULL,
FOREIGN KEY(EventID) REFERENCES Organization(OrganizationID),
Type TEXT NOT NULL
);

-- Inserting Data into Organizator
INSERT INTO Organizator (OrganizatorID, UserName, Password) VALUES
(1, 'FirstOrganizator', 'pass1'),
(2, 'SecondOrganizator', 'pass2'),
(3, 'ThirdOrganizator', 'pass3'),
(4, 'FourthOrganizator', 'pass4'),
(5, 'FifthOrganizator', 'pass5'),
(6, 'SixthOrganizator', 'pass6'),
(7, 'SeventhOrganizator', 'pass7'),
(8, 'EighthOrganizator', 'pass8'),
(9, 'NinthOrganizator', 'pass9'),
(10, 'TenthOrganizator', 'pass10');

-- Inserting Data into Organization
INSERT INTO Organization (OrganizationID, Category, Name, Address, County, City, StartDate, EndDate, Price, Quota, Description, OrganizatorName, OrganizatorID) VALUES
(1, 'academic', 'FirstConference', 'TechPark', 'Kadikoy', 'Istanbul', '2024-06-10', '2024-06-12', 150, 50, NULL, 'FirstOrganizator', 1),
(2, 'music', 'SummerFest', 'SeaSideArena', 'Besiktas', 'Istanbul', '2024-07-01', '2024-07-05', 300, 200, NULL, 'SecondOrganizator', 2),
(3, 'art', 'CityArt Expo', 'GalleryM', 'Fatih', 'Istanbul', '2024-05-10', '2024-05-15', 200, 100, NULL, 'ThirdOrganizator', 3),
(4, 'technology', 'TechExpo', 'TechCenter', 'Ankara', 'Ankara', '2024-06-15', '2024-06-20', 500, 300, NULL, 'FourthOrganizator', 4),
(5, 'theater', 'Broadway Show', 'OperaHouse', 'Konak', 'Izmir', '2024-08-01', '2024-08-10', 400, 150, NULL, 'FifthOrganizator', 5),
(6, 'math', 'Math Symposium', 'CulturalHall', 'Bagcilar', 'Istanbul', '2024-08-15', '2024-08-20', 250, 100, NULL, 'SixthOrganizator', 6),
(7, 'sports', 'Marathon2024', 'AtaturkStadium', 'Kadikoy', 'Istanbul', '2024-09-01', '2024-09-02', 100, 500, NULL, 'SeventhOrganizator', 7),
(8, 'academic', 'Medical Research Forum', 'MedicalCenter', 'Izmir', 'Izmir', '2024-06-25', '2024-06-30', 350, 80, NULL, 'EighthOrganizator', 8),
(9, 'music', 'Electronic Night', 'MainArena', 'Kadikoy', 'Istanbul', '2024-09-15', '2024-09-20', 600, 150, NULL, 'NinthOrganizator', 9),
(10, 'theater', 'Drama Workshop', 'ArtStudio', 'Esenler', 'Istanbul', '2024-10-01', '2024-10-05', 250, 60, NULL, 'TenthOrganizator', 10);

-- Inserting Data into Members
INSERT INTO Members (MembersID, Name, SurName, MembersUserName, MembersPassword, BirthDate, Email, EventID, Type) VALUES
(1, 'Ali', 'Dogan', 'FirstMember', 'member1', '2000-01-20', 'ali@gmail.com', 2, 'Standard'),
(2, 'Veli', 'Sahin', 'SecondMember', 'member2', '1980-01-20', 'veli@gmail.com', 2, 'Standard'),
(3, 'Ahmet', 'Koc', 'ThirdMember', 'member3', '2004-01-20', 'ahmet@gmail.com', 3, 'Standard'),
(4, 'Hasan', 'Aslan', 'FourthMember', 'member4', '1985-01-20', 'hasan@gmail.com', 6, 'Standard'),
(5, 'Enes', 'Kartopu', 'FifthMember', 'member5', '1997-01-20', 'enes@gmail.com', NULL, 'Standard'),
(6, 'Omer', 'Guzel', 'SixthMember', 'member6', '1977-01-20', 'omer@gmail.com', 7, 'Standard'),
(7, 'Mehmet', 'Uctu', 'SeventhMember', 'member7', '1994-01-20', 'mehmet@gmail.com', 8, 'Standard'),
(8, 'Huseyin', 'Gel', 'EighthMember', 'member8', '2000-01-20', 'huseyin@gmail.com', 9, 'Standard'),
(9, 'Eren', 'Kacti', 'NinthMember', 'member9', '2005-01-20', 'eren@gmail.com', 10, 'Standard'),
(10, 'Burak', 'Sustu', 'TenthMember', 'member10', '2008-01-20', 'burak@gmail.com', NULL, 'Standard'),
(11, 'Baris', 'Kartal', 'EleventhMember', 'member11', '1999-01-20', 'baris@gmail.com', 10, 'Standard');


/*1) Find the events which will be host in Izmir. */
SELECT *FROM Organization WHERE City = 'izmir';

/*2) Find the event (event’s name, category name, 
organizators name) which was held 
with the highest attendance
and the total obtained revenue. */
SELECT DISTINCT Organization.Name,Organization.Category,
Organization.OrganizatorName,Organization.Price
FROM Organization,Members WHERE Members.EventID
IN(SELECT COUNT(EventID) AS SAYI FROM Members
 GROUP BY EventID) AND
 Organization.OrganizationID=Members.EventID;

/*3) Find the total number of events for each category in a descending order. */
SELECT Category,COUNT(*) AS SAYI FROM Organization
GROUP BY Category ORDER BY SAYI DESC;

/*4) Find the past events in which 
the members (whose age is between 18-25) 
participated. */
SELECT Organization.Name,Members.Name,Members.SurName
FROM Organization,Members WHERE 
Organization.OrganizationID=Members.EventID AND
Organization.EndDate<'2019-05-26' AND 
('now'-Members.BirthDate)/365 BETWEEN 18 AND 25; 

/*5) Find the past events in which the total number of participated members is less than
(not equal) 3. */
SELECT *FROM Organization,Members WHERE 
Members.EventID IN(SELECT EventID FROM Members
GROUP BY EventID HAVING COUNT(*)<3) AND
EndDate<'2019-05-26' AND 
Organization.OrganizationID=Members.EventID;

/*6) List the members who attended at least 
3 events and update these members’
membership type to gold. */
SELECT *FROM Members WHERE MembersID IN
(SELECT MembersID FROM Members GROUP BY MembersID
 HAVING COUNT(*)>2);
 UPDATE Members SET Type='gold' WHERE MembersID IN
(SELECT MembersID FROM Members GROUP BY MembersID
 HAVING COUNT(*)>2);
SELECT *FROM Members WHERE MembersID IN
(SELECT MembersID FROM Members GROUP BY MembersID
 HAVING COUNT(*)>2);

/*7) Delete the “academic” events which 
will be organized by Dokuz Eylül University at
19th May 2019. */
SELECT *FROM Organization ;
DELETE FROM Organization WHERE Category='academic'
AND Address='DokuzEylulUniversity' AND 
EndDate='2019-05-19' AND StartDate='2019-05-19';
SELECT *FROM Organization ;

/*8) Return the member’s email 
address who paid at most. */
SELECT Email FROM Members,Organization WHERE  
Price IN(SELECT MAX(Organization.Price) 
FROM Organization)
AND Members.EventID=Organization.OrganizationID;

/*9)Update the discount rate of events which will be
organized at cities whose name starts with"i" as 25*/
SELECT *FROM Organization;
UPDATE Organization SET Description='discount %25',
Price = Price - Price/4 WHERE City LIKE 'i%';
SELECT *FROM Organization;

/*10) Delete the members 
who have not participated in any events. */
SELECT *FROM Members;
DELETE FROM Members WHERE EventID IS NULL;
SELECT *FROM Members; 