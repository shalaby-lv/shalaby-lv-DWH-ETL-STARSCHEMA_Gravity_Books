CREATE DATABASE Gravity_books_DWH

use Gravity_books_DWH

CREATE TABLE CUSTOMER_DIM
(
	CUSTOMER_SK INT PRIMARY KEY IDENTITY(1,1), -- primary key
	CUSTOMER_ID INT NOT NULL, --business key
	FIRST_NAME VARCHAR(200),
	LASTNAME VARCHAR(200),
	EMAIL VARCHAR(350),
	STREET_NUMBER VARCHAR(10),
	STREET_NAME VARCHAR(200),
	CITY VARCHAR(100),
	COUNTRY_NAME VARCHAR(200),
	ADDRESS_STATUS VARCHAR(30),
	VALID_FROM DATETIME,
	VALID_TO DATETIME
)

CREATE TABLE BOOK_DIM
(
	BOOK_SK INT PRIMARY KEY IDENTITY(1,1),
	BOOK_ID INT NOT NULL,
	TITLE VARCHAR(400),
	ISBN13 VARCHAR(13),
	LANGUAGE_CODE VARCHAR(8),
	LANGUAGE_NAME VARCHAR(50),
	NUM_PAGES INT,
	PUBLICATION_DATE DATE,
	PUBLISHER_NAME VARCHAR(400),
	AUTHOR_NAME VARCHAR(400),
	VALID_FROM DATETIME,
	VALID_TO DATETIME
)

CREATE TABLE DATE_DIM
(
    Date_Key           INT          NOT NULL PRIMARY KEY,
    Full_Date          DATE         NOT NULL UNIQUE,
 
    Day_Number         INT,
    Day_Name           VARCHAR(20),
    Day_Of_Week        INT,
    Day_Of_Year        INT,
 
    Week_Number        INT,
    Month_Number       INT,
    Month_Name         VARCHAR(20),
 
    Quarter_Number     INT,
    Quarter_Name       VARCHAR(10),
 
    Year_Number        INT,
 
    Is_Weekend         BIT,
    Is_Month_Start     BIT,
    Is_Month_End       BIT,
    Is_Quarter_Start   BIT,
    Is_Quarter_End     BIT,
    Is_Year_Start      BIT,
    Is_Year_End        BIT
);


DECLARE @StartDate DATE = '20200101';
DECLARE @EndDate   DATE = '20301231';
DECLARE @Date      DATE = @StartDate;

SET DATEFIRST 7;

WHILE @Date <= @EndDate
BEGIN
    INSERT INTO dbo.DATE_DIM
    (
        Date_Key, Full_Date,
        Day_Number, Day_Name, Day_Of_Week, Day_Of_Year,
        Week_Number, Month_Number, Month_Name,
        Quarter_Number, Quarter_Name, Year_Number,
        Is_Weekend, Is_Month_Start, Is_Month_End,
        Is_Quarter_Start, Is_Quarter_End,
        Is_Year_Start, Is_Year_End
    )
    SELECT
        CONVERT(INT, CONVERT(CHAR(8), @Date, 112)),
        @Date,
        DAY(@Date),
        DATENAME(WEEKDAY, @Date),
        DATEPART(WEEKDAY, @Date),
        DATEPART(DAYOFYEAR, @Date),
        DATEPART(ISO_WEEK, @Date),
        MONTH(@Date),
        DATENAME(MONTH, @Date),
        DATEPART(QUARTER, @Date),
        CONCAT('Q', DATEPART(QUARTER, @Date)),
        YEAR(@Date),

        CASE WHEN DATEPART(WEEKDAY, @Date) IN (1, 7)
             THEN 1 ELSE 0 END,

        CASE WHEN DAY(@Date) = 1
             THEN 1 ELSE 0 END,

        CASE WHEN @Date = EOMONTH(@Date)
             THEN 1 ELSE 0 END,

        CASE WHEN MONTH(@Date) IN (1, 4, 7, 10)
                  AND DAY(@Date) = 1
             THEN 1 ELSE 0 END,

        CASE WHEN @Date = DATEADD(
             DAY, -1,
             DATEADD(QUARTER,
                 DATEDIFF(QUARTER, 0, @Date) + 1, 0))
             THEN 1 ELSE 0 END,

        CASE WHEN MONTH(@Date) = 1 AND DAY(@Date) = 1
             THEN 1 ELSE 0 END,

        CASE WHEN MONTH(@Date) = 12 AND DAY(@Date) = 31
             THEN 1 ELSE 0 END;

    SET @Date = DATEADD(DAY, 1, @Date);
END;

SELECT * FROM DATE_DIM

CREATE TABLE ORDER_FACT
(
    CUSTOMER_SK INT,
    BOOK_SK INT,
    DATE_KEY INT,
    COST DECIMAL(6,2),
    PRICE DECIMAL(5,2),
    CONSTRAINT FK_CUSTOMER FOREIGN KEY (CUSTOMER_SK) REFERENCES CUSTOMER_DIM(CUSTOMER_SK),
    CONSTRAINT FK_BOOK FOREIGN KEY (BOOK_SK) REFERENCES BOOK_DIM(BOOK_SK),
    CONSTRAINT FK_DATE FOREIGN KEY (DATE_KEY) REFERENCES DATE_DIM(DATE_KEY)
)
