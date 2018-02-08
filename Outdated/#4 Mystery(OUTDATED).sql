GO
ALTER PROCEDURE sp_Renewal

	AS
	BEGIN


	DECLARE @MonthlyRenewal date
	DECLARE @QuarterlyRenewal date
	DECLARE @YearlyRenewal date
	DECLARE @CardID int
	DECLARE @RenewalPrice smallmoney
	DECLARE @SelectedMember int
	DECLARE @TransactionDate date
	
	SET @TransactionDate =
	(
	select top 1 TransactionDate
	from vwNotPaid
	)
	
	SET @SelectedMember =
	(
	select top 1 MemberID
	from vwNotPaid
	)

	SET @RenewalPrice = 
	(
	select RenewalPrice
	from vwNotPaid
	where @SelectedMember = MemberID
	group by RenewalPrice
	
	)

	SET @CardID = 
	(
	select CardID
	from vwNotPaid
	where @SelectedMember = MemberID
	group by CardID
	
	)



	SET @MonthlyRenewal = 
	(select  max(dateadd(MONTH, 1 ,TransactionDate)) [Renewal Date]
		from vwNotPaid
		where RenewalID = 4 and @SelectedMember = MemberID
		group by MemberID

	)

	SET @QuarterlyRenewal = 
	(select  max(dateadd(MONTH, 3 ,TransactionDate)) [Renewal Date]
		from vwNotPaid
		where RenewalID = 3  and @SelectedMember = MemberID
		group by MemberID

	)

		SET @YearlyRenewal = 
	(select max(dateadd(Year, 1 ,TransactionDate)) [Renewal Date]
		from vwNotPaid
		where RenewalID = 2 and @SelectedMember = MemberID
		group by MemberID

	)

	IF @MonthlyRenewal <= GETDATE()
	BEGIN
	
	INSERT INTO Transactions (CardID, TransactionDate, Charge, Result)
		VALUES (@CardID, @MonthlyRenewal, @RenewalPrice, 'Approved')
END
	IF @QuarterlyRenewal <= GETDATE()
	BEGIN
	
	INSERT INTO Transactions
		VALUES (@CardID, @QuarterlyRenewal, @RenewalPrice, 'Approved')
END	
	IF @YearlyRenewal <= GETDATE()
	BEGIN

	INSERT INTO Transactions
		VALUES (@CardID, @YearlyRenewal, @RenewalPrice, 'Approved')


END

END
GO

	--select * from vwNotPaid

	--select * from Transactions