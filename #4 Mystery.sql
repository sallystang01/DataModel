
ALTER PROCEDURE sp_Renewal

	AS
	BEGIN

	DECLARE @MonthlyRenewalInitial date
	DECLARE @QuarterlyRenewalInitial date
	DECLARE @YearlyRenewalInitial date
	DECLARE @MonthlyRenewal date
	DECLARE @QuarterlyRenewal date
	DECLARE @YearlyRenewal date

	SET @MonthlyRenewalInitial = 
	(select MemberID,max(dateadd(MONTH, 1 ,StartDate)) [Renewal Date]
		from vwNotPaid
		where RenewalID = 4
		group by MemberID

	)

	SET @QuarterlyRenewalInitial = 
	(select MemberID,max(dateadd(MONTH, 3 ,StartDate)) [Renewal Date]
		from vwNotPaid
		where RenewalID = 3
		group by MemberID

	)

	SET @YearlyRenewalInitial = 
	(select MemberID,max(dateadd(Year, 1 ,StartDate)) [Renewal Date]
		from vwNotPaid
		where RenewalID = 2
		group by MemberID

	)

	SET @MonthlyRenewal = 
	(select MemberID,max(dateadd(MONTH, 1 ,TransactionDate)) [Renewal Date]
		from vwNotPaid
		where RenewalID = 4
		group by MemberID

	)

	SET @QuarterlyRenewal = 
	(select MemberID,max(dateadd(MONTH, 3 ,TransactionDate)) [Renewal Date]
		from vwNotPaid
		where RenewalID = 3
		group by MemberID

	)

		SET @YearlyRenewal = 
	(select MemberID,max(dateadd(Year, 1 ,TransactionDate)) [Renewal Date]
		from vwNotPaid
		where RenewalID = 2
		group by MemberID

	)

	select * from vwNotPaid