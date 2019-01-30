Create database BankF

--SQL statement to create table UserLogins--
Create Table UserLogins
(UserLoginID smallint Not Null Primary Key,
UserLogin char(15), UserPassword varchar(30))

--Insert data into UserLogins table
Insert into UserLogins values (1456,'Emmanuel','Emma2005')
Insert into UserLogins values (2003,'Frankline','Frank2006')
Insert into UserLogins values (3786,'Ndudiri','Ndudi2007')
Insert into UserLogins values (4123,'Professor','Prof2008')

select * from UserLogins

--SQL statement to create table UserSecurityQuestions--
Create Table UserSecurityQuestions
(UserSecurityQuestionID tinyint Not Null Primary Key,
UserSecurityQuestion varchar(50))

--Insert data into UserSecurityQuestions table
Insert into UserSecurityQuestions values (20,'your favorite sports')
Insert into UserSecurityQuestions values (23,'Your best friends name')
Insert into UserSecurityQuestions values (37,'Best Vacation City')
Insert into UserSecurityQuestions values (41,'Your favorite meal')

select * from UserSecurityQuestions

--SQL statement to create table SavingsInterestRates--
Create Table SavingsInterestRates
(InterestSavingsRateID tinyint not Null Primary Key,
InterestRateValue numeric(9,9), InterestRateDescription varchar(20))

--Insert data into  SavingsInterestRates table
Insert into  SavingsInterestRates values (10, 2, 'Normal Interest rate')
Insert into  SavingsInterestRates values (20, 3, 'Special Savings rate')
Insert into  SavingsInterestRates values (30, 1, 'Education savings account')
Insert into  SavingsInterestRates values (40, 1, 'Deposit Savings account')

select * from  SavingsInterestRates

--SQL statement to create table LoginErrorLog--
Create Table LoginErrorLog
(ErrorLogID int Not Null Primary Key,
ErrorTime datetime, FailedTransactionXML xml)

--Insert data into LoginErrorLog table
Insert into LoginErrorLog values (200, '06/10/2018', <wrong account number/>)
Insert into LoginErrorLog values (203, '08/10/2018', <Transaction failure/>)
Insert into LoginErrorLog values (376, '11/12/2018', <wrong password/>)
Insert into LoginErrorLog values (180, '18/07/2018', <Network problem/>)

select * from LoginErrorLog

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
FailedTransactionErrorTime datetime, FailedTransactionXML xml)

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

--Insert data into CustomerAccount table
Insert into CustomerAccount values (100234, 9807)
Insert into CustomerAccount values (100367, 7865)
Insert into CustomerAccount values (100654, 6754)
Insert into CustomerAccount values (100845, 4312)

select * from CustomerAccount

--SQL statement to create table UserSecurityAnswers--
Create Table UserSecurityAnswers
(UserLoginID smallint Not Null Primary Key Foreign Key references UserLogins(UserLoginID),
UserSecurityAnswer varchar(25), UserSecurityQuestionID tinyint Foreign Key references UserSecurityQuestions(UserSecurityQuestionID))

--Insert data into UserSecurityAnswers table
Insert into UserSecurityAnswers values (1456,'Football', 20)
Insert into UserSecurityAnswers values (2003,'James', 23)
Insert into UserSecurityAnswers values (3786,'Zurich', 37)
Insert into UserSecurityAnswers values (4123,'Rice', 41)

select * from UserSecurityAnswers

--SQL statement to create table OverDraftLog--
Create table OverDraftLog
(AccountID int Not Null Primary Key Foreign Key references Account(AccountID),
OverDraftDate datetime, OverdraftAmount money, OverDraftTransactionXML xml)


