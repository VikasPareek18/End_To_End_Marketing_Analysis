WITH Duplicate_Records AS (
SELECT
JourneyID,
CustomerID,
ProductID,
VisitDate,
Stage,
Action,
Duration,
ROW_NUMBER() OVER(PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action ORDER BY JourneyID) as row_num
FROM dbo.customer_journey
)
SELECT
*
FROM Duplicate_Records
WHERE row_num > 1
ORDER BY JourneyID


SELECT
JourneyID,
CustomerID,
ProductID,
VisitDate,
Stage,
Action,
COALESCE(Duration, avg_duration) AS Duration
FROM (
SELECT 
JourneyID,
CustomerID,
ProductID,
VisitDate,
UPPER(Stage) AS Stage,
Action,
Duration,
Round(AVG(COALESCE(Duration, 0)) over(Partition by VisitDate), 2) as avg_duration,
ROW_NUMBER() OVER(PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action ORDER BY JourneyID) AS row_num
FROM dbo.customer_journey
) AS sub_query
Where row_num = 1
