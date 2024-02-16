INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('PROCESS_STOCKPILE', 1);
-- A max of 30 hammers per era allows a city to stockpile between 15% and 30% of the total needed for a World Wonder
-- Choose this value based on costs in the Civ5Buildings.xml file, it will be scaled by the game speed in the same way.
INSERT OR REPLACE INTO CustomModOptions(Name, Value) VALUES('PROCESS_STOCKPILE_PER_ERA', 30);
	
