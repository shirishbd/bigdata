-- Static Partitions

CREATE TABLE states (id INT, name STRING, age INT)
PARTITIONED BY (state STRING);

CREATE EXTERNAL TABLE temp_states(id INT, name STRING, age INT, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/user/cloudera/data/states/';

INSERT OVERWRITE TABLE states 
PARTITION (state = 'CA')
SELECT id, name, age
FROM temp_states
WHERE state = 'CA';

INSERT OVERWRITE TABLE states 
PARTITION (state = 'AZ')
SELECT id, name, age
FROM temp_states
WHERE state = 'AZ';


--- Dynamic Partitions

CREATE TABLE dyn_states (id INT, name STRING, age INT)
PARTITIONED BY (state STRING);

INSERT OVERWRITE TABLE dyn_states
PARTITION (state)
SELECT id, name, age, state
FROM temp_states;

-- External partitioned table

-- Create external table pointing to "already organized" data set
CREATE EXTERNAL TABLE dailysales (id INT, name STRING, category STRING, state STRING, amount DOUBLE)
PARTITIONED BY (sales_date DATE)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/user/cloudera/data/daily_sales';

-- Make HIVE aware of partitions
MSCK REPAIR TABLE dailysales;


