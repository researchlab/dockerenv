CREATE TABLE IF NOT EXISTS tb1(
	id MEDIUMINT(8) NOT NULL AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	type MEDIUMINT(1) NOT NULL,
	code TEXT,
	PRIMARY KEY (id),
	KEY type (type)
	);
