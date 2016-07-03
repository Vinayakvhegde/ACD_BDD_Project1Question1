Crime_Records = LOAD 'USA_Crime.csv' USING PigStorage(',') AS (ID:long, CaseNo:chararray, DatenTime:chararray, Block:chararray, IUCR:int, PrimaryType:chararray, Description:chararray, Location:chararray, Arrest:chararray, Domestic:chararray, Beat:int, District:int, Ward:int, CommunityArea:chararray, FBICode:chararray, XCoordinate:float, YCoordinate:float, Year:int, UpdatedOnTime:chararray, Latitude:double, Longitude:double, GeoLocation:chararray) ;
Crime_Selected = FOREACH Crime_Records GENERATE ID, PrimaryType, Arrest, District ;
Crime_Filtered = FILTER Crime_Selected BY PrimaryType == 'THEFT' AND Arrest =='true' ;
Crime_Grouped  = GROUP Crime_Filtered BY District ;
Crime_Count_District = FOREACH Crime_Grouped GENERATE group, COUNT(Crime_Filtered.ID) ;
DUMP Crime_Count_District ;

