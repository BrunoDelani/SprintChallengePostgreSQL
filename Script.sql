CREATE DATABASE IF NOT EXISTS `cleaning_management`;
USE `cleaning_management`;

CREATE TABLE `diarist` (
`id` INT AUTO_INCREMENT NOT NULL,
`cpf` VARCHAR(14) NOT NULL UNIQUE,
`name` VARCHAR(250) NOT NULL UNIQUE,
PRIMARY KEY (`id`),
INDEX (`name`)
);

CREATE TABLE `client` (
`id` INT AUTO_INCREMENT NOT NULL,
`cpf` VARCHAR(14) NOT NULL UNIQUE,
`name` VARCHAR(250) NOT NULL UNIQUE,
PRIMARY KEY (`id`),
INDEX (`name`)
);

CREATE TABLE `size` (
`id` INT AUTO_INCREMENT NOT NULL,
`size` VARCHAR(50) NOT NULL UNIQUE,
`value` NUMERIC(8,2) NOT NULL,
PRIMARY KEY (`id`)
);

CREATE TABLE `residence` (
`id` INT AUTO_INCREMENT NOT NULL,
`city` VARCHAR(255) NOT NULL,
`district` VARCHAR(255) NOT NULL,
`street` VARCHAR(255) NOT NULL,
`complement` VARCHAR(255) NOT NULL,
`number` INT UNSIGNED NOT NULL,
`id_size` INT NOT NULL,
`id_client` INT NOT NULL,
PRIMARY KEY (`id`),
FOREIGN KEY (`id_size`) REFERENCES `size`(`id`),
FOREIGN KEY (`id_client`) REFERENCES `client`(`id`)
);

CREATE TABLE `cleaning` (
`id` INT AUTO_INCREMENT NOT NULL,
`date` DATE NOT NULL,
`value` NUMERIC(8,2),
`payment` BOOLEAN NOT NULL,
`id_residence` INT NOT NULL,
PRIMARY KEY (`id`),
FOREIGN KEY (`id_residence`) REFERENCES `residence`(`id`)
);

DROP TRIGGER IF EXISTS `tr_update_value`;
DELIMITER $
CREATE TRIGGER `tr_update_value` BEFORE INSERT ON `cleaning` FOR EACH ROW
BEGIN
	IF (NEW.`value` IS NULL) THEN
			SET NEW.`value` = 
				(SELECT `size`.`value` FROM `residence`
				INNER JOIN `size` ON `residence`.`id_size` = `size`.`id`
				WHERE `residence`.`id` = NEW.`id_residence`);
	END IF;
END
$

CREATE TABLE `cleaning_diarist` (
`id_cleaning` INT NOT NULL,
`id_diarist` INT NOT NULL,
`presence` BOOLEAN NOT NULL,
FOREIGN KEY (`id_cleaning`) REFERENCES `cleaning`(`id`),
FOREIGN KEY (`id_diarist`) REFERENCES `diarist`(`id`)
);

CREATE TABLE `feedback` (
`id` INT AUTO_INCREMENT NOT NULL,
`score` TINYINT NOT NULL,
`comment` VARCHAR(500),
`id_cleaning` INT NOT NULL,
PRIMARY KEY(`id`),
FOREIGN KEY (`id_cleaning`) REFERENCES `cleaning`(`id`)
);

INSERT INTO `diarist` (`cpf`, `name`) VALUES ("229.001.574-12","Priscilla Serra Santana");
INSERT INTO `diarist` (`cpf`, `name`) VALUES ("286.501.627-70","Paula Annunziato Cunha");
INSERT INTO `diarist` (`cpf`, `name`) VALUES ("335.561.817-97","Maria Luiza Latin Ferreira");
INSERT INTO `diarist` (`cpf`, `name`) VALUES ("717.094.112-01","Cauê Brito Duarte");
INSERT INTO `diarist` (`cpf`, `name`) VALUES ("636.562.482-49","Maria Alice Amaral Prata");
INSERT INTO `diarist` (`cpf`, `name`) VALUES ("509.326.022-31","Rodrigo Rocha Vasconcellos");
INSERT INTO `diarist` (`cpf`, `name`) VALUES ("365.148.225-17","Benedito Carvalho Alfradique");
INSERT INTO `diarist` (`cpf`, `name`) VALUES ("814.376.152-52","Nilcea Leite Muniz");
INSERT INTO `diarist` (`cpf`, `name`) VALUES ("505.775.483-10","Rosiméri Vasconcellos Moreira");
INSERT INTO `diarist` (`cpf`, `name`) VALUES ("812.703.894-67","José Milton Malaquias Navega");

INSERT INTO `client` (`cpf`, `name`) VALUES ("526.547.291-68","Telmo Debossam Calixto");
INSERT INTO `client` (`cpf`, `name`) VALUES ("469.335.563-10","Regina da Cunha Xavier");
INSERT INTO `client` (`cpf`, `name`) VALUES ("951.342.643-25","Alisson Barboza Camara");
INSERT INTO `client` (`cpf`, `name`) VALUES ("255.085.431-47","Hevelyn Vilela Cardoso");
INSERT INTO `client` (`cpf`, `name`) VALUES ("075.641.869-09","Rachel Couto Gouveia");
INSERT INTO `client` (`cpf`, `name`) VALUES ("179.621.994-07","João Gonçalves Borges");
INSERT INTO `client` (`cpf`, `name`) VALUES ("610.868.681-29","Lívia Caldas Montilla");
INSERT INTO `client` (`cpf`, `name`) VALUES ("385.317.406-06","Dalva Amorim Bragança");
INSERT INTO `client` (`cpf`, `name`) VALUES ("569.795.505-78","Leonardo Leite Castilho");
INSERT INTO `client` (`cpf`, `name`) VALUES ("407.551.022-07","Maria Cristina Pina Bonimo");

INSERT INTO `size` (`size`, `value`) VALUES ("small",50.00);
INSERT INTO `size` (`size`, `value`) VALUES ("medium",100.00);
INSERT INTO `size` (`size`, `value`) VALUES ("big",150.00);

INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","Jardim Eldorado","Afonso Juca de Oliveira","Casa","4998","2","1");
INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","Jardim Eldorado","Afonso Juca de Oliveira","Casa","4860","2","2");
INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","Jardim Primavera","Av. Vitória Régia","Casa","2123","3","3");
INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","Jardim Primavera","Av. Vitória Régia","Casa","2001","1","4");
INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","Centro","Av. Capitão Castro","Casa","5342","1","5");
INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","Jardim América","Afonso Juca de Oliveira","Casa","3678","1","6");
INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","Jardim América","Afonso Juca de Oliveira","Casa","3597","3","7");
INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","Centro","Av. Barão do Rio Branco","Casa","5532","2","8");
INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","Centro","Av. José do Patrocínio","Casa","5001","2","9");
INSERT INTO `residence` (`city`, `district`, `street`, `complement`, `number`, `id_size`, `id_client`) VALUES ("Vilhena","R. das Rosas","Afonso Juca de Oliveira","Casa","998","1","10");

INSERT INTO `cleaning` (`date`, `payment`, `id_residence`) VALUES ("2022-07-31", FALSE, 1);
INSERT INTO `cleaning` (`date`, `payment`, `id_residence`) VALUES ("2022-07-31", FALSE, 2);
INSERT INTO `cleaning` (`date`, `payment`, `id_residence`) VALUES ("2022-07-31", FALSE, 3);
INSERT INTO `cleaning` (`date`, `payment`, `id_residence`) VALUES ("2022-07-30", FALSE, 4);
INSERT INTO `cleaning` (`date`, `payment`, `id_residence`) VALUES ("2022-07-29", FALSE, 5);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-12", 100, TRUE, 6);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-11", 125, TRUE, 7);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-13", 100, TRUE, 8);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-12", 50, TRUE, 9);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-11", 75, TRUE, 10);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-10", 75, TRUE, 1);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-09", 75, TRUE, 2);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-08", 75, TRUE, 3);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-05", 75, TRUE, 4);
INSERT INTO `cleaning` (`date`, `value`, `payment`, `id_residence`) VALUES ("2022-07-04", 75, FALSE, 4);

INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (6, 1, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (6, 2, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (7, 3, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (7, 4, FALSE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (8, 5, FALSE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (8, 6, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (9, 7, FALSE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (9, 8, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (10, 9, FALSE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (10, 10, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (11, 1, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (12, 2, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (13, 3, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (14, 4, TRUE);
INSERT INTO `cleaning_diarist` (`id_cleaning`, `id_diarist`, `presence`) VALUES (15, 5, FALSE);

INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (10, "Atenciosa(o) com a limpeza!", 6);
INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (8, "Limpa bem!", 7);
INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (5, "Esqueceu um cômodo :(", 8);
INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (2, "Muito mal educado(a)", 9);
INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (9, "Show de bola!", 10);
INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (10, "Muito bom!", 11);
INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (9, "Gostei!", 12);
INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (0, "Péssimooo!!", 13);
INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (8, "Razoavelmente bom", 14);
INSERT INTO `feedback` (`score`, `comment`, `id_cleaning`) VALUES (0, "Diarista não compareceu ;/", 14);
