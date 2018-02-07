CREATE VIEW vwNotPaid
AS
select m.*, t.TransactionDate, pc.CardID from members m
inner join
paymentcard pc
on pc.memberid = m.memberid
inner join
transactions t 
on t.cardid = pc.cardid
where t.transactiondate < GETDATE()
GO