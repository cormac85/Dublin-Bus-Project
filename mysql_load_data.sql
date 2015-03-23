use dublinbus;

DROP TABLE IF EXISTS Table2;

CREATE TABLE Table2 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOLEAN
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130102.csv' 
  INTO TABLE Table2
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';

ALTER TABLE Table2
	DROP COLUMN Direction, 
	DROP COLUMN Operator;
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/


DROP TABLE IF EXISTS Table3;

CREATE TABLE Table3 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130103.csv' 
  INTO TABLE Table3
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';

  ALTER TABLE Table3
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table4;

CREATE TABLE Table4 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130104.csv' 
  INTO TABLE Table4
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
  ALTER TABLE Table4
	DROP COLUMN Direction,
	DROP COLUMN Operator;
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table5;

CREATE TABLE Table5 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130105.csv' 
  INTO TABLE Table5
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table5
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table6;

CREATE TABLE Table6 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130106.csv' 
  INTO TABLE Table6
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
 
    ALTER TABLE Table6
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table7;

CREATE TABLE Table7 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130107.csv' 
  INTO TABLE Table7
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table7
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table8;

CREATE TABLE Table8 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130108.csv' 
  INTO TABLE Table8
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table8
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table9;

CREATE TABLE Table9 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130109.csv' 
  INTO TABLE Table9
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';

    ALTER TABLE Table9
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table10;

CREATE TABLE Table10 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130110.csv' 
  INTO TABLE Table10
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table10
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table11;

CREATE TABLE Table11 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130111.csv' 
  INTO TABLE Table11
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table11
	DROP COLUMN Direction,
	DROP COLUMN Operator;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table12;

CREATE TABLE Table12 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOLEAN
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130112.csv' 
  INTO TABLE Table12
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';

ALTER TABLE Table12
	DROP COLUMN Direction,
	DROP COLUMN Operator;
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DROP TABLE IF EXISTS Table13;

CREATE TABLE Table13 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130113.csv' 
  INTO TABLE Table13
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';

  ALTER TABLE Table13
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table14;

CREATE TABLE Table14 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130114.csv' 
  INTO TABLE Table14
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
  ALTER TABLE Table14
	DROP COLUMN Direction,
	DROP COLUMN Operator;
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table15;

CREATE TABLE Table15 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130115.csv' 
  INTO TABLE Table15
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table15
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table16;

CREATE TABLE Table16 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130116.csv' 
  INTO TABLE Table16
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table16
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table17;

CREATE TABLE Table17 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130117.csv' 
  INTO TABLE Table17
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table17
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table18;

CREATE TABLE Table18 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130118.csv' 
  INTO TABLE Table18
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table18
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table19;

CREATE TABLE Table19 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130119.csv' 
  INTO TABLE Table19
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';

    ALTER TABLE Table19
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table20;

CREATE TABLE Table20 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130120.csv' 
  INTO TABLE Table20
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table20
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table21;

CREATE TABLE Table21 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130121.csv' 
  INTO TABLE Table21
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table21
	DROP COLUMN Direction,
	DROP COLUMN Operator;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DROP TABLE IF EXISTS Table22;

CREATE TABLE Table22 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOLEAN
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130122.csv' 
  INTO TABLE Table22
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';

ALTER TABLE Table22
	DROP COLUMN Direction,
	DROP COLUMN Operator;
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

DROP TABLE IF EXISTS Table23;

CREATE TABLE Table23 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130123.csv' 
  INTO TABLE Table23
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';

  ALTER TABLE Table23
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table24;

CREATE TABLE Table24 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130124.csv' 
  INTO TABLE Table24
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
  ALTER TABLE Table24
	DROP COLUMN Direction,
	DROP COLUMN Operator;
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table25;

CREATE TABLE Table25 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130125.csv' 
  INTO TABLE Table25
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table25
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table26;

CREATE TABLE Table26 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130126.csv' 
  INTO TABLE Table26
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table26
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table27;

CREATE TABLE Table27 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130127.csv' 
  INTO TABLE Table27
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table27
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table28;

CREATE TABLE Table28 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130128.csv' 
  INTO TABLE Table28
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table28
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table29;

CREATE TABLE Table29 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130129.csv' 
  INTO TABLE Table29
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';

    ALTER TABLE Table29
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table30;

CREATE TABLE Table30 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130130.csv' 
  INTO TABLE Table30
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table30
	DROP COLUMN Direction,
	DROP COLUMN Operator;
  
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
  
  DROP TABLE IF EXISTS Table31;

CREATE TABLE Table31 (
  Timestamp BIGINT UNSIGNED,
  LineID SMALLINT UNSIGNED,
  Direction BOOLEAN,
  JourneyPatternID VARCHAR(8),
  TimeFrame VARCHAR (15),
  VehicleJourneyID INT UNSIGNED,
  Operator VARCHAR (5),
  Congestion BOOL,
  LonWGS84 NUMERIC(10,8),
  LatWGS84 NUMERIC(10,8),
  Delay INT,
  BlockID INT UNSIGNED,
  VehicleID INT UNSIGNED,
  StopID INT UNSIGNED,
  AtStop BOOL
  );

LOAD DATA LOCAL INFILE 'C:/Users/King Mac/Google Drive/Coding/DIT/5. Project/Dublin-Bus-Project/siri.20130131.csv' 
  INTO TABLE Table31
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n';
  
    ALTER TABLE Table31
	DROP COLUMN Direction,
	DROP COLUMN Operator;

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/