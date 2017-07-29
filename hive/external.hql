
-- download zipcodes data from https://catalog.data.gov/dataset?tags=zip-code

-- hadoop fs -mkdir data/zipcodes
-- hadoop fs -mv data/2010_Census_Populations_by_Zip_Code.csv data/zipcodes

CREATE EXTERNAL TABLE zipcodes (
  zip INT,
  population BIGINT,
  medianage DOUBLE,
  males BIGINT,
  females BIGINT,
  households INT,
  avg_household DOUBLE
)
row format delimited fields terminated BY ','
LOCATION '/user/cloudera/data/zipcodes'
tblproperties("skip.header.line.count"="1"); 


