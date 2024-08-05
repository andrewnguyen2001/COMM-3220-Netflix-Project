USE an2dgq_Netflix; 

-- Appendix A:

SELECT de.CustomerID, count(de.Country) as NotOriginCountry, t.NumofCountries, count(de.Country)/(t.NumofCountries) as PercentageNonOriginCountry
FROM Devices de, 
	(
		SELECT CustomerID, count(Country) as NumofCountries
        FROM Devices d
        GROUP By CustomerID
	)t
WHERE de.CustomerID = t.CustomerID AND EXISTS (SELECT *
FROM CustomerInfo c
WHERE de.CustomerID = c.customerID AND de.Country != c.Country)
GROUP BY de.CustomerID;

-- Appendix B: 

Select e.EmployeeID, e.salary, SUM(o.contractAmount) as TotalContracts, AVG(c.CostPerMonth) as AverageSubscription, SUM(l.StreamingDuration) as TotalStreamingDuration, AVG(c.CostPerMonth)*SUM(l.StreamingDuration) as EmployeeValue
	FROM employee e, customerinfo c, logging l, contract o, content n
WHERE e.employeeID = o.EmployeeID AND c.customerID = l.CustomerID AND l.StreamingContentID = o.ContentID
	GROUP BY e.EmployeeID
ORDER BY AVG(c.CostPerMonth)*SUM(l.StreamingDuration) DESC;

-- Appendix C: 

SELECT g.GenreName, AVG(co.contractAmount)
FROM Genres g, Content c, Contract co
WHERE g.GenreID = c.GenreID AND c.ContentID = co.ContentID
GROUP BY g.GenreName
ORDER BY contractAmount DESC; 

-- Appendix D:

SELECT avg(p.Age) as AverageAge, g.GenreName
FROM Profiles p, Content c, Genres g, Logging l
WHERE g.genreID = c.genreID AND l.StreamingContentID = c.ContentID AND p.ProfileID = l.ProfileID  AND p.ProfileID IN (SELECT profileID FROM Logging) 
GROUP BY g.GenreName
ORDER BY avg(p.age);

-- Appendix E: 

SELECT co.FilmStudio, AVG(c.contractAmount) as AverageContractAmount
FROM ContentOwner co, Contract c 
WHERE co.ContentID = c.ContentID
GROUP BY co.FilmStudio
ORDER BY contractAmount DESC; 

-- Appendix F:

SELECT avg(p.age) as AVG_Age, c.typeofcontent
FROM profiles p, logging l, content c
WHERE p.customerID = l.customerID and p.profileID = l.profileID and l.streamingcontentID = c.contentID
GROUP BY c.typeofcontent;

-- Appendix G:

SELECT l.TimeDate, c.contentID, c.title, g.genrename
FROM logging l, content c, genres g
WHERE l.StreamingContentID = c.ContentID and c.genreID = g.genreID
GROUP BY l.TimeDate
ORDER BY l.TimeDate DESC;

-- Appendix H: 

SELECT t.Country, t.GenreName, max(t.totalstream) as PopularGenre
FROM (
    SELECT I.Country, g.GenreName, sum(StreamingDuration) as totalstream
	FROM Profiles p, Content c, Genres g, Logging l, CustomerInfo I
	WHERE g.genreID = c.genreID AND l.StreamingContentID = c.ContentID
	AND p.ProfileID = l.ProfileID  AND p.customerID = I.customerID AND
	p.customerID IN (SELECT customerID FROM Logging) 
	GROUP BY I.Country, g.GenreName
	ORDER BY sum(StreamingDuration) DESC
    )t
GROUP BY t.Country
ORDER BY max(t.totalstream) DESC; 
