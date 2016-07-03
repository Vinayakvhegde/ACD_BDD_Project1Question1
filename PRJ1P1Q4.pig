Crime_Records = LOAD 'USA_Crime.csv' USING PigStorage(',') AS (ID:long, CaseNo:chararray, DatenTime:chararray, Block:chararray, IUCR:int, PrimaryType:chararray, Description:chararray, Location:chararray, Arrest:chararray, Domestic:chararray, Beat:int, District:int, Ward:int, CommunityArea:chararray, FBICode:chararray, XCoordinate:float, YCoordinate:float, Year:int, UpdatedOnTime:chararray, Latitude:double, Longitude:double, GeoLocation:chararray) ;
Crime_Selected = FOREACH Crime_Records GENERATE Arrest, (int)SUBSTRING(DatenTime, 0, 2) AS MonthMM, (int)SUBSTRING(DatenTime, 6, 10) AS YearYY ;
Crime_Filtered = FILTER Crime_Selected BY ((MonthMM >= 10 AND YearYY == 2014) OR (MonthMM <= 10 AND YearYY == 2015)) AND Arrest =='true' ;
Crime_Grouped  = GROUP Crime_Filtered ALL ;
Crime_Count_Arrests = FOREACH Crime_Grouped GENERATE COUNT(Crime_Filtered) ;
DUMP Crime_Count_Arrests ;

