CREATE VIEW vwNotPaid
AS
select m.MemberID, max(t.TransactionDate) [TransactionDate], pc.CardID, max(r.RenewalPrice) [RenewalPrice], max(r.RenewalType) [RenewalType], max(r.RenewalID) [RenewalID] from members m
inner join
paymentcard pc
on pc.memberid = m.memberid
inner join
transactions t 
on t.cardid = pc.cardid
inner join
Renewal r
on r.RenewalID = m.RenewalID
where t.transactiondate < GETDATE() and NOT EXISTS (select TransactionDate
from Transactions
where TransactionDate = GETDATE()
				)
group by m.MemberID, pc.cardid
GO

	select * from vwNotPaid