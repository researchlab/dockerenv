CREATE TABLE IF NOT EXISTS tb8(
	id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(20) NOT NULL,
	password VARCHAR(22) NOT NULL,
	age TINYINT UNSIGNED NOT NULL DEFAULT 10,
	sex BOOLEAN
	);