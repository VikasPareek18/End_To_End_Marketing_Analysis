SELECT
EngagementID,
ContentID,
UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) as ContentType,
CampaignID,
ProductID,
LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined)-1) as Views,
RIGHT(ViewsClicksCombined, len(ViewsClicksCombined)-CHARINDEX('-', ViewsClicksCombined)) as Clicks,
Likes,
FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') as EngagementDate
FROM dbo.engagement_data
WHERE ContentType != 'NEWSLETTER'
