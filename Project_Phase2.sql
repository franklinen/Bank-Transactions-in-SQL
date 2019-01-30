--view to show Ontario Customers with checking account--

Create View CheckONview 
as
Select Concat(CustomerFirstName, CustomerLastName) as CustomerName, State, AccountTypeDescription
from Customer
join Account
on Customer.AccountID = Account.AccountID
join AccountType
on Account.AccountTypeID = AccountType.AccountTypeID
where State='ON' and Account.AccountTypeID= 9

select * from CheckONview

--view to count number of Account types--
Create View TotalAccountTypecount
as 
select Customer.CustomerID, count(AccountType.AccountTypeID) as AccountTypeCount, AccountType.AccountTypeDescription
from Customer
Join Account
ON customer.AccountID=Account.AccountID
join AccountType
on Account.AccountTypeID=AccountType.AccountTypeID
where AccountType.accountTypeDescription like '%savings%' or AccountType.AccountTypeDescription like '%checking%'
Group by Customer.CustomerID, AccountType.AccountTypeDescription

select * from TotalAccountTypecount


--Account interest rate--
Create View AccountIntRateView
as 
select Account.AccountID, SavingsInterestRates.InterestRateValue
from Account
join SavingsInterestRates
on Account.InterestSavingsRateID=SavingsInterestRates.InterestSavingsRateID

select * from AccountIntRateView

--view for Account balance greater than 5000--
create View AccBalGreaterThan5000
as 
select CustomerID, (TransactionLog.NewBalance+(TransactionLog.NewBalance*AccountIntRateView.InterestRateValue)) as Total_balance
from AccountIntRateView, TransactionLog
where AccountIntRateView.AccountID = TransactionLog.AccountID

select * from AccBalGreaterThan5000
where Total_balance > 5000


--user login and password--
Create View Login_Password
as
Select UserLogin, UserPassword 
from UserLogins
join LoginAccount
on LoginAccount.UserLoginID = UserLogins.UserLoginID

select * from Login_Password


--overdraft ammount for customers--
Create View overdraft_amount
as
select OverdraftAmount
from OverDraftLog

select * from overdraft_amount


--create stored procedure to add user prefix to login--
create procedure login_prefix
as	
	begin
		update UserLogins set Userlogin = 'User_'+UserLogin
	End

Execute login_prefix

select * from UserLogins

--create stored procedure that takies in AccountId and returns customer's full name--

Create Procedure Cust_Name @AccID int
as 
	Begin
		Select Concat(CustomerFirstName, ' ', CustomerLastName) as CustomerFullName
		from Customer
		where AccountID=@AccID
	END

execute Cust_Name 30085 

-- create procedure that takes deposit and updates currentbalance for particular account--

Create Proc newbalance @DepositAMT money, @AccID int 
as	
	Begin
		update Account Set Currentbalance=CurrentBalance+@DepositAMT
		where AccountID=@AccID
	END

execute NewBalance 50000, 12984 

select * from Account

--procedure that takes a withdrawal amt and updates current balance

Create Procedure netBalance @withdrawAMT money, @AccID int 
as	
	Begin
		update Account Set Currentbalance=CurrentBalance-@withdrawAMT
		where AccountID=@AccID
	END

execute netBalance 300, 12984 

select * from Account

--Drop column from table Customer--
Alter Table Customer Drop SSN;
