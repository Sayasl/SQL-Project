--Problem 1: Find the total number of crimes recorded in the CRIME table.

SELECT COUNT(*) AS TOTAL_NUMBER_OF_CRIMES FROM CHICAGOCRIMEDATA;

--Problem 2: List community areas with per capita income less than 11000.

SELECT Community_Area_Name,Per_Capita_Income FROM ChicagoCensusData
WHERE Per_Capita_Income < '11000';

--Problem 3: List all case numbers for crimes  involving minors?(children are not considered minors for the purposes of crime analysis).

SELECT CASE_NUMBER
FROM CHICAGOCRIMEDATA 
WHERE DESCRIPTION LIKE '%MINOR%';

--Problem 4: List all kidnapping crimes involving a child?

SELECT CASE_NUMBER, PRIMARY_TYPE, DESCRIPTION
FROM CHICAGOCRIMEDATA
WHERE PRIMARY_TYPE = 'KIDNAPPING';

--Problem 5: What kind of crimes were recorded at schools?

SELECT DISTINCT CASE_NUMBER, PRIMARY_TYPE
FROM CHICAGOCRIMEDATA
WHERE LOCATION_DESCRIPTION LIKE '%SCHOOL%';

--Problem 6: List the average safety score for all types of schools.

SELECT "Elementary, Middle, or High School",
AVG(SAFETY_SCORE) AS AVERAGE_SAFETY_SCORE
FROM CHICAGOPUBLICSCHOOLS
GROUP BY "Elementary, Middle, or High School";

--Problem 7: List 5 community areas with highest % of households below poverty line.

SELECT COMMUNITY_AREA_NAME,
PERCENT_HOUSEHOLDS_BELOW_POVERTY
FROM CHICAGOCENSUSDATA
ORDER BY PERCENT_HOUSEHOLDS_BELOW_POVERTY DESC
LIMIT 5 ;

--Problem 8: Which community area(number) is most crime prone?

SELECT CCD.COMMUNITY_AREA_NUMBER ,
COUNT(CCD.COMMUNITY_AREA_NUMBER) AS FREQUENCY
FROM CHICAGOCRIMEDATA AS CCD 
GROUP BY CCD.COMMUNITY_AREA_NUMBER
ORDER BY COUNT(CCD.COMMUNITY_AREA_NUMBER) DESC
LIMIT 1;

--Problem 9: Use a sub-query to find the name of the community area with highest hardship index.

SELECT COMMUNITY_AREA_NAME
FROM CHICAGOCENSUSDATA
WHERE HARDSHIP_INDEX = (SELECT MAX(HARDSHIP_INDEX)
FROM CHICAGOCENSUSDATA);

--Problem 10: Use a sub-query to determine the Community Area Name with most number of crimes?

SELECT COMMUNITY_AREA_NAME
FROM CHICAGOCENSUSDATA 
WHERE COMMUNITY_AREA_NUMBER = (    
    SELECT CCD.COMMUNITY_AREA_NUMBER 
    FROM CHICAGOCRIMEDATA AS CCD 
    GROUP BY CCD.COMMUNITY_AREA_NUMBER
    ORDER BY COUNT(CCD.COMMUNITY_AREA_NUMBER) DESC
    LIMIT 1)
LIMIT 1;