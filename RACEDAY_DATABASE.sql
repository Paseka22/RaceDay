/* =========================================================
   RACEDAY DATABASE
   PROG6212 - Programming 2B - PoE Part 1
   ========================================================= */

USE master;
GO

/* Remove old RaceDay database if it already exists */
IF DB_ID('RaceDay') IS NOT NULL
BEGIN
    ALTER DATABASE RaceDay
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE RaceDay;
END
GO

/* Create the RaceDay database */
CREATE DATABASE RaceDay;
GO

USE RaceDay;
GO


/* =========================================================
   1. USER TABLE
   ========================================================= */

CREATE TABLE [User]
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,

    FirstName VARCHAR(50) NOT NULL,

    LastName VARCHAR(50) NOT NULL,

    Email VARCHAR(100) NOT NULL UNIQUE,

    Password VARCHAR(255) NOT NULL,

    Role VARCHAR(20) NOT NULL
    CHECK (Role IN ('Organiser', 'Participant'))
);
GO


/* =========================================================
   2. EVENT TABLE
   ========================================================= */

CREATE TABLE Event
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,

    EventName VARCHAR(100) NOT NULL,

    Description VARCHAR(500),

    EventDate DATE NOT NULL,

    Location VARCHAR(150) NOT NULL,

    Distance DECIMAL(6,2) NOT NULL
    CHECK (Distance > 0),
    EventType VARCHAR(50) NOT NULL,

    OrganiserID INT NOT NULL,

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES [User](UserID)
);
GO


/* =========================================================
   3. CATEGORY TABLE
   ========================================================= */

CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,

    CategoryName VARCHAR(100) NOT NULL,

    Distance DECIMAL(6,2) NOT NULL,

    EventID INT NOT NULL,

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
);
GO


/* =========================================================
   4. ROUTE TABLE
   ========================================================= */

CREATE TABLE Route
(
    RouteID INT IDENTITY(1,1) PRIMARY KEY,

    RouteName VARCHAR(100) NOT NULL,

    StartLocation VARCHAR(150) NOT NULL,

    EndLocation VARCHAR(150) NOT NULL,

    Distance DECIMAL(6,2) NOT NULL,

    RouteDescription VARCHAR(500),

    EventID INT NOT NULL,

    CONSTRAINT FK_Route_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID)
);
GO


/* =========================================================
   5. ENROLMENT TABLE
   ========================================================= */

CREATE TABLE Enrolment
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,

    ParticipantID INT NOT NULL,

    EventID INT NOT NULL,

    CategoryID INT NOT NULL,

    CONSTRAINT FK_Enrolment_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES [User](UserID),

    CONSTRAINT FK_Enrolment_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    CONSTRAINT FK_Enrolment_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
);
GO


/* =========================================================
   6. RESULT TABLE
   ========================================================= */

CREATE TABLE Result
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,

    EnrolmentID INT NOT NULL UNIQUE,

    FinishTime TIME NOT NULL,

    FinishingPosition INT NOT NULL,

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (EnrolmentID)
        REFERENCES Enrolment(EnrolmentID)
);
GO


/* =========================================================
   SEED DATA
   ========================================================= */


/* ---------------------------------------------------------
   USERS
   2 Organisers + 2 Participants
   --------------------------------------------------------- */

INSERT INTO [User]
    (FirstName, LastName, Email, Password, Role)
VALUES
    ('Thabo', 'Mokoena', 'thabo@raceday.co.za', 'Password123', 'Organiser'),

    ('Lerato', 'Molefe', 'lerato@raceday.co.za', 'Password123', 'Organiser'),

    ('Sarah', 'Nkosi', 'sarah@gmail.com', 'Password123', 'Participant'),

    ('James', 'Dlamini', 'james@gmail.com', 'Password123', 'Participant');
GO


/* ---------------------------------------------------------
   EVENTS
   3 Events
   --------------------------------------------------------- */

INSERT INTO Event
    (EventName, Description, EventDate, Location,
     Distance, EventType, OrganiserID)
VALUES
    (
        'Johannesburg City Run',
        'Annual road running event in Johannesburg.',
        '2026-10-10',
        'Johannesburg',
        10.00,
        'Running',
        1
    ),

    (
        'Pretoria Cycling Challenge',
        'Road cycling challenge around Pretoria.',
        '2026-11-15',
        'Pretoria',
        50.00,
        'Cycling',
        2
    ),

    (
        'Limpopo Charity Run',
        'Community road running event supporting local charities.',
        '2026-12-05',
        'Polokwane',
        21.00,
        'Running',
        1
    );
GO


/* ---------------------------------------------------------
   CATEGORIES
   Categories for every event
   --------------------------------------------------------- */

INSERT INTO Category
    (CategoryName, Distance, EventID)
VALUES
    ('10 KM Open', 10.00, 1),
    ('10 KM Junior', 10.00, 1),

    ('50 KM Open', 50.00, 2),
    ('50 KM Veterans', 50.00, 2),

    ('21 KM Open', 21.00, 3),
    ('21 KM Veterans', 21.00, 3);
GO


/* ---------------------------------------------------------
   ROUTES
   --------------------------------------------------------- */

INSERT INTO Route
    (RouteName, StartLocation, EndLocation,
     Distance, RouteDescription, EventID)
VALUES
    (
        'Johannesburg 10 KM Route',
        'Nelson Mandela Square',
        'Sandton City',
        10.00,
        '10 KM city road running route.',
        1
    ),

    (
        'Johannesburg Junior Route',
        'Sandton City',
        'Nelson Mandela Square',
        10.00,
        'Junior 10 KM road running route.',
        1
    ),

    (
        'Pretoria 50 KM Route',
        'Union Buildings',
        'Menlyn',
        50.00,
        '50 KM road cycling route.',
        2
    ),

    (
        'Pretoria Veterans Route',
        'Menlyn',
        'Union Buildings',
        50.00,
        'Veterans cycling route.',
        2
    ),

    (
        'Limpopo 21 KM Route',
        'Polokwane Stadium',
        'City Centre',
        21.00,
        '21 KM charity running route.',
        3
    ),

    (
        'Limpopo Veterans Route',
        'City Centre',
        'Polokwane Stadium',
        21.00,
        'Veterans 21 KM running route.',
        3
    );
GO


/* ---------------------------------------------------------
   ENROLMENTS
   Sample participant enrolments
   --------------------------------------------------------- */

INSERT INTO Enrolment
    (ParticipantID, EventID, CategoryID)
VALUES
    (3, 1, 1),
    (3, 3, 5),
    (4, 1, 2),
    (4, 2, 3);
GO


/* ---------------------------------------------------------
   RESULTS
   Sample race results
   --------------------------------------------------------- */

INSERT INTO Result
    (EnrolmentID, FinishTime, FinishingPosition)
VALUES
    (1, '00:52:35', 8),
    (2, '01:48:20', 5),
    (3, '01:02:15', 15);
GO


/* =========================================================
   VERIFICATION
   ========================================================= */

SELECT * FROM [User];

SELECT * FROM Event;

SELECT * FROM Category;

SELECT * FROM Route;

SELECT * FROM Enrolment;

SELECT * FROM Result;
GO
