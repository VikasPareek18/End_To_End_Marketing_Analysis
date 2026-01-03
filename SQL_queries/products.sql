SELECT
ProductID,
ProductName,
Price,
CASE
	WHEN Price < 50 THEN 'Low'
	WHEN Price Between 50  and 200 THEN 'Medium'
	ELSE 'High'
END AS PriceCategory
FROM dbo.products
