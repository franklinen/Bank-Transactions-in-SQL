Create database Bank

--SQL statement to create table UserLogins--
Create Table UserLogins
(UserLoginID smallint Not Null Primary Key,
UserLogin char(15), UserPassword varchar(30))

--SQL statement to create table UserSecurityQuestions--
Create Table UserSecurityQuestions
(UserSecurityQuestionID tinyint Not Null Primary Key,
UserSecurityQuestion varchar(50))

--SQL statement to create table SavingsInterestRates--
Create Table SavingsInterestRates
(InterestSavingsRateID tinyint not Null Primary Key,
InterestRateValue numeric(9,9), InterestRateDescription varchar(20))

--SQL statement to create table LoginErrorLog--
Create Table LoginErrorLog
(ErrorLogID int Not Null Primary Key,
ErrorTime datetime, FailedTransactionXML varchar(30))

--SQL statement to create table Employee--
Create Table Employee
(EmployeeID int Not Null Primary Key,
EmployeeFirstName varchar(25), EmployeeMiddleInitial char(1), EmployeeLastName varchar(25), EmployeeIsManager bit)

--SQL statement to create table FailedTransactionErrorType--
Create Table FailedTransactionErrorType 
(FailedTransactionErrorTypeID tinyint Not Null Primary Key,
FailedTransactionDescription varchar(50))

--SQL statement to create table TransactionType--
Create Table TransactionType
(TransactionTypeID tinyint not Null Primary Key,
TransactionTypeName char(10), TransactionTypeDescription varchar(50), TransactionFeeAmount smallmoney)

--SQL statement to create table AccountStatusType--
Create Table AccountStatusType
(AccountStatusTypeID tinyint Not Null Primary Key, 
AccountStatusDescription varchar(30))

--SQL statement to create table AccountType--
Create Table AccountType
(AccountTypeID tinyint Not Null Primary Key,
AccountTypeDescription varchar(30))

--SQL statement to create table FailedTransactionLog--
Create Table FailedTransactionLog
(FailedTransactionID int Not Null Primary Key,
FailedTransactioErrorTypeID tinyint Foreign Key
references FailedTransactionErrorType(FailedTransactionErrorTypeID),
FailedTransactionErrorTime datetime, FailedTransactionXML varchar(30))

--SQL statement to create table Account--
Create Table Account
(AccountID int Not Null Primary Key,
CurrentBalance int, AccountTypeID tinyint Foreign Key references AccountType(AccountTypeID),
AccountStatusTypeID tinyint Foreign Key references AccountStatusType(AccountStatusTypeID), 
InterestSavingsRateID tinyint Foreign Key references SavingsInterestRates(InterestSavingsrateID))

--SQL statement to create table LoginAccount--
Create Table LoginAccount
(UserLoginID smallint Foreign Key
references UserLogins(UserLoginID),
AccountID int Foreign Key
references Account(AccountID))

--SQL statement to create table Customer--
Create Table Customer
(CustomerID int Not Null Primary Key, 
AccountID int Foreign Key references Account(AccountID), CustomerAddress1 varchar(30),
CustomerAddress2 varchar(30), CustomerFirstName varchar(30), CustomerMiddleInitial char(1), CustomerLastName varchar(30),
City varchar(20), State char(2), ZipCode char(2), EmailAddress varchar(40), Homephone char(10),
CellPhone char(10), WorkPhone char(10), SSN char(9), UserLoginID smallint Foreign Key references Userlogins(UserloginID))

--SQL statement to create table Transactionlog--
Create Table Transactionlog
(TransactionID int Not Null Primary Key,
TransactionDate datetime, TransactionTypeID tinyint Foreign Key references TransactionType(TransactionTypeID),
TransactionAmount money, NewBalance money, AccountID int Foreign Key references Account(AccountID), CustomerID int Foreign Key references Customer(CustomerID), 
EmployeeID int Foreign Key references Employee(EmployeeID), UserLoginID smallint Foreign Key references Userlogins(UserLoginID))

--SQL statement to create table CustomerAccount--
Create Table CustomerAccount
(AccountID int Foreign key references Account(AccountID),
CustomerID int Foreign Key references Customer(CustomerID))

--SQL statement to create table UserSecurityAnswers--
Create Table UserSecurityAnswers
(UserLoginID smallint Not Null Primary Key Foreign Key references UserLogins(UserLoginID),
UserSecurityAnswer varchar(25), UserSecurityQuestionID tinyint Foreign Key references UserSecurityQuestions(UserSecurityQuestionID))

--SQL statement to create table OverDraftLog--
Create table OverDraftLog
(AccountID int Not Null Primary Key Foreign Key references Account(AccountID),
OverDraftDate datetime, OverdraftAmount money, OverDraftTransactionXML varchar(30))

--Insert data into UserLogins table
Insert into UserLogins values (1456,'Emmanuel','Emma2005')
Insert into UserLogins values (2003,'Frankline','Frank2006')
Insert into UserLogins values (3786,'Ndudiri','Ndudi2007')
Insert into UserLogins values (4123,'Professor','Prof2008')

select * from UserLogins


--Insert data into UserSecurityQuestions table
Insert into UserSecurityQuestions values (20,'your favorite sports')
Insert into UserSecurityQuestions values (23,'Your best friends name')
Insert into UserSecurityQuestions values (37,'Best Vacation City')
Insert into UserSecurityQuestions values (41,'Your favorite meal')

select * from UserSecurityQuestions

--Insert data into  SavingsInterestRates table
Insert into  SavingsInterestRates values (1, 0.78, 'Calculated daily')
Insert into  SavingsInterestRates values (2, 0.56, 'Calculated weekly')
Insert into  SavingsInterestRates values (3, 0.68, 'Calculated monthly')
Insert into  SavingsInterestRates values (4, 0.91, 'Calculated yearly')

select * from  SavingsInterestRates

--Insert data into LoginErrorLog table--
Insert into LoginErrorLog values (200, '06-10-2018 10:34:09 PM', 'wrong account number')
Insert into LoginErrorLog values (203, '08-10-2018 07:23:00 AM', 'Transaction failure')
Insert into LoginErrorLog values (376, '11-12-2018 02:45:50 PM', 'wrong password')
Insert into LoginErrorLog values (180, '07-18-2018 04:50:21 AM', 'Network problem')

select * from LoginErrorLog

--Insert data into Employee table--
Insert into Employee values (2078, 'Frankline', 'N','Ononiwu', 0)
Insert into Employee values (2069, 'Brown', 'I', 'Ononiwu', 1)
Insert into Employee values (2034, 'Nelson', 'U','Ononiwu', 1)
Insert into Employee values (2188, 'Kingsley','C','Ononiwu', 0)

select * from Employee

--Insert data into FailedTransactionErrorType table--
Insert into FailedTransactionErrorType values (02, 'Wrong Account Number')
Insert into FailedTransactionErrorType values (06, 'Wrong transaction Type')
Insert into FailedTransactionErrorType values (12, 'insufficient Balance')
Insert into FailedTransactionErrorType values (16, 'Maximum Withdrawal Exceeded')

select * from FailedTransactionErrorType

--Insert data into TransactionType table--
Insert into TransactionType values (02, 'Withdrawal', 'Cash withdrawal', $3)
Insert into TransactionType values (06, 'Deposit', 'Over the Counter Cash Deposit', $1)
Insert into TransactionType values (12, 'Transfer', 'Cash Electronic Transfer', $1)
Insert into TransactionType values (16, 'Overdraft','withdrawal below zero limit', $5)

select * from TransactionType

--Insert data into AccountStatusType table--
Insert into AccountStatusType values (2, 'Funded')
Insert into AccountStatusType values (6, 'Overdrawn')
Insert into AccountStatusType values (1, 'active')
Insert into AccountStatusType values (3, 'Dormant')

select * from AccountStatusType

--Insert data into AccountType table--
Insert into AccountType values (03, 'Savings')
Insert into AccountType values (09, 'Checking')
Insert into AccountType values (05, 'Credit')
Insert into AccountType values (07, 'Dormicilary')

select * from AccountType

--Insert data into FailedTransactionLog table--
Insert into FailedTransactionLog values (202, 02, '06-10-2018 11:40:10 PM', 'Wrong Account Number')
Insert into FailedTransactionLog values (406, 06, '08-20-2018 02:34:09 PM', 'Wrong transaction Type')
Insert into FailedTransactionLog values (128, 12, '11-02-2018 12:24:44 PM', 'insufficient Balance')
Insert into FailedTransactionLog values (506, 16, '03-24-2018 09:17:08 PM', 'Maximum Withdrawal Exceeded')

select * from FailedTransactionLog

--Insert data into Account table--
Insert into Account values (12490, 40, 03, 2, 1)
Insert into Account values (29081, 70, 09, 6, 2)
Insert into Account values (12984, 20, 05, 1, 3)
Insert into Account values (30085, 150, 07, 3, 4)

select * from Account

--Insert data into LoginAccount table--
Insert into LoginAccount values (1456, 12490)
Insert into LoginAccount values (2003, 29081)
Insert into LoginAccount values (3786, 12984)
Insert into LoginAccount values (4123, 30085)

select * from LoginAccount

--Insert data into Customer table
Insert into Customer values (9807, 12490, '5 Bellevue Crescent', 'North York', 'Frank', 'N', 'Ononiwu', 'Toronto', 'ON', 'M9', 'manflat83@gmail.com', '42223390', '5677348', '7866543', '143789659', 1456)
Insert into Customer values (7865, 29081, '5 Maple Leaf Drive', 'East York', 'James', 'C', 'Okwe', 'Toronto', 'ON', 'EH', 'james.c@yahoo.com', '5667333', '8766537', '6543327','887752101', 2003)
Insert into Customer values (6754, 12984, '8 kennedy crescent', 'Queens', 'Elliot', 'J', 'Walker', 'New York', 'NY', 'QD','elliot.j@gmail.com','6744328', '7654329', '7654320','976643221', 3786)
Insert into Customer values (4312, 30085, '9 Simpson Road', 'Southfield', 'Nelson', 'I', 'Emeh', 'Detroit', 'MI', 'SO', 'nelson.i@yahoo.com', '8766543', '6543295', '8945994', '765432090', 4123) 

select * from Customer

--Insert data into Transactionlog table
Insert into Transactionlog values (98, '06-10-2018 11:40:10 PM', 02, 50, 1000, 12490, 9807, 2078, 1456)
Insert into Transactionlog values (78, '07-12-2018 06:45:00 PM', 06, 120, 300, 29081, 7865, 2069, 2003)
Insert into Transactionlog values (67, '04-19-2017 08:44:00 PM', 12, 100, 1200, 12984, 6754, 2034, 3786)
Insert into Transactionlog values (43, '11-27-2016 02:24:01 PM', 16, 80, 800, 30085, 4312, 2188, 4123) 

select * from Transactionlog

--Insert data into CustomerAccount table
Insert into CustomerAccount values (12490, 9807)
Insert into CustomerAccount values (29081, 7865)
Insert into CustomerAccount values (12984, 6754)
Insert into CustomerAccount values (30085, 4312)

select * from CustomerAccount

--Insert data into UserSecurityAnswers table
Insert into UserSecurityAnswers values (1456,'Football', 20)
Insert into UserSecurityAnswers values (2003,'James', 23)
Insert into UserSecurityAnswers values (3786,'Zurich', 37)
Insert into UserSecurityAnswers values (4123,'Rice', 41)

select * from UserSecurityAnswers

--Insert data into OverDraftLog table
Insert into OverDraftLog values (12490, '09-30-2017 11:59:59 PM', 500, 'Max allowed for new Accounts')
Insert into OverDraftLog values (29081, '07-10-2018 02:40:10 PM', 1000, 'Max Limit')
Insert into OverDraftLog values (12984, '06-10-2018 11:40:10 PM', 250, 'Min Overdraft Allowed')
Insert into OverDraftLog values (30085, '05-23-2016 05:45:50 PM', 750, 'Max Limit for All Accounts')

select * from OverDraftLog

