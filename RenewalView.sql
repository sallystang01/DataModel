CREATE VIEW vwRenewal
AS
select m.memberid, m.FirstName, m.LastName, m.StartDate, m.RenewalID, r.RenewalPrice, pc.CardID
from Members m
inner join
Renewal r
on m.RenewalID = r.RenewalID
inner join
PaymentCard pc
on pc.MemberID = m.MemberID
WHERE m.CurrentFlag <> 0 AND m.RenewalID = 4
	AND DATEPART(day, startdate) = DATEPART(day, getdate())

	UNION ALL
select m.memberid, m.FirstName, m.LastName, m.StartDate, m.RenewalID, r.RenewalPrice, pc.CardID
from Members m
inner join
Renewal r
on m.RenewalID = r.RenewalID
inner join
PaymentCard pc
on pc.MemberID = m.MemberID
WHERE m.CurrentFlag <> 0 AND m.RenewalID = 3
	AND DATEPART(day, startdate) = DATEPART(day, getdate())
	AND DATEPART(month, GETDATE()) IN
		((select (datepart(month, m.startdate) + 3)),
		(select (datepart(month, m.startdate) + 6)),
		(select (datepart(month, m.startdate) + 9)))
UNION ALL

select m.memberid, m.FirstName, m.LastName, m.StartDate, m.RenewalID, r.RenewalPrice, pc.CardID
from Members m
inner join
Renewal r
on m.RenewalID = r.RenewalID
inner join
PaymentCard pc
on pc.MemberID = m.MemberID
WHERE m.CurrentFlag <> 0 AND m.RenewalID = 2
	AND DATEPART(day, startdate) = DATEPART(day, getdate())
	AND DATEPART(month, startdate) = DATEPART(month, getdate())
UNION 
ALL
select m.memberid, m.FirstName, m.LastName, m.StartDate, m.RenewalID, r.RenewalPrice, pc.CardID
from Members m
inner join
Renewal r
on m.RenewalID = r.RenewalID
inner join
PaymentCard pc
on pc.MemberID = m.MemberID
WHERE m.CurrentFlag <> 0 AND m.RenewalID = 1
	AND GETDATE() IN
	((SELECT dateadd(month, 24, m.startdate)),
	(select dateadd(month, 48, m.startdate)),
	(select dateadd(month, 72, m.startdate)))
GO	

		