-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `new_schema1` ;
USE `new_schema1` ;

-- -----------------------------------------------------
-- Table `new_schema1`.`stavka_narudzbe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`stavka_narudzbe` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `kolicina` INT NULL,
  `cijena_u_trenutku` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`wishlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`wishlist` (
  `korisnik_id` INT NOT NULL,
  `proizvod_id` INT NOT NULL,
  PRIMARY KEY (`korisnik_id`, `proizvod_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`recenzija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`recenzija` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tekst` VARCHAR(50) NULL,
  `ocjena` INT NULL,
  `datum_vrijeme` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`povijest_zaliha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`povijest_zaliha` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NULL,
  `kolicina_u_tome_trenutku` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`proizvod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`proizvod` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(50) NULL,
  `opis` VARCHAR(50) NULL,
  `cijena` DECIMAL(10,2) NULL,
  `kolicina_na_skladistu` INT NULL,
  `wishlist_korisnik_id` INT NOT NULL,
  `wishlist_proizvod_id` INT NOT NULL,
  `stavka_narudzbe_id` INT NOT NULL,
  `wishlist_korisnik_id1` INT NOT NULL,
  `wishlist_proizvod_id1` INT NOT NULL,
  `recenzija_id` INT NOT NULL,
  `povijest_zaliha_id` INT NOT NULL,
  PRIMARY KEY (`id`, `wishlist_korisnik_id`, `wishlist_proizvod_id`, `wishlist_korisnik_id1`, `wishlist_proizvod_id1`),
  INDEX `fk_proizvod_stavka_narudzbe1_idx` (`stavka_narudzbe_id` ASC) VISIBLE,
  INDEX `fk_proizvod_wishlist1_idx` (`wishlist_korisnik_id1` ASC, `wishlist_proizvod_id1` ASC) VISIBLE,
  INDEX `fk_proizvod_recenzija1_idx` (`recenzija_id` ASC) VISIBLE,
  INDEX `fk_proizvod_povijest_zaliha1_idx` (`povijest_zaliha_id` ASC) VISIBLE,
  CONSTRAINT `fk_proizvod_stavka_narudzbe1`
    FOREIGN KEY (`stavka_narudzbe_id`)
    REFERENCES `new_schema1`.`stavka_narudzbe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proizvod_wishlist1`
    FOREIGN KEY (`wishlist_korisnik_id1` , `wishlist_proizvod_id1`)
    REFERENCES `new_schema1`.`wishlist` (`korisnik_id` , `proizvod_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proizvod_recenzija1`
    FOREIGN KEY (`recenzija_id`)
    REFERENCES `new_schema1`.`recenzija` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proizvod_povijest_zaliha1`
    FOREIGN KEY (`povijest_zaliha_id`)
    REFERENCES `new_schema1`.`povijest_zaliha` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`kupon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`kupon` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `kod_kupona` VARCHAR(50) NULL,
  `tip` ENUM('fiksni', 'postotak') NULL,
  `datum_od` DATE NULL,
  `datum_do` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`transakcija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`transakcija` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datum_vrijeme` DATETIME NULL,
  `iznos` DECIMAL(10,2) NULL,
  `status` ENUM('aktivni', 'neaktivni', 'blokirani') NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`placanje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`placanje` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `iznos` DECIMAL(10,2) NULL,
  `datum_vrijeme` DATETIME NULL,
  `nacin` ENUM('kartica', 'paypal', 'pouzece') NULL,
  `status` ENUM('aktivni', 'neaktivni', 'blokirani') NULL,
  `transakcija_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_placanje_transakcija1_idx` (`transakcija_id` ASC) VISIBLE,
  CONSTRAINT `fk_placanje_transakcija1`
    FOREIGN KEY (`transakcija_id`)
    REFERENCES `new_schema1`.`transakcija` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`narudzba`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`narudzba` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datum_vrijeme` DATETIME NULL,
  `status` ENUM('aktivni', 'neaktivni', 'blokirani') NULL,
  `adresa_dostave` VARCHAR(50) NULL,
  `kupon_id` INT NOT NULL,
  `stavka_narudzbe_id` INT NOT NULL,
  `placanje_id` INT NOT NULL,
  `transakcija_id` INT NOT NULL,
  PRIMARY KEY (`id`, `stavka_narudzbe_id`),
  INDEX `fk_narudzba_kupon_idx` (`kupon_id` ASC) VISIBLE,
  INDEX `fk_narudzba_stavka_narudzbe1_idx` (`stavka_narudzbe_id` ASC) VISIBLE,
  INDEX `fk_narudzba_placanje1_idx` (`placanje_id` ASC) VISIBLE,
  INDEX `fk_narudzba_transakcija1_idx` (`transakcija_id` ASC) VISIBLE,
  CONSTRAINT `fk_narudzba_kupon`
    FOREIGN KEY (`kupon_id`)
    REFERENCES `new_schema1`.`kupon` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_narudzba_stavka_narudzbe1`
    FOREIGN KEY (`stavka_narudzbe_id`)
    REFERENCES `new_schema1`.`stavka_narudzbe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_narudzba_placanje1`
    FOREIGN KEY (`placanje_id`)
    REFERENCES `new_schema1`.`placanje` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_narudzba_transakcija1`
    FOREIGN KEY (`transakcija_id`)
    REFERENCES `new_schema1`.`transakcija` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`korisnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`korisnik` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(50) NULL,
  `prezime` VARCHAR(50) NULL,
  `email` VARCHAR(50) NULL,
  `telefon` VARCHAR(20) NULL,
  `adresa_dostave` VARCHAR(50) NULL,
  `status` ENUM('aktivni', 'neaktivni', 'blokirani') NULL,
  `narudzba_id` INT NOT NULL,
  `recenzija_id` INT NOT NULL,
  `wishlist_korisnik_id` INT NOT NULL,
  `wishlist_proizvod_id` INT NOT NULL,
  PRIMARY KEY (`id`, `wishlist_korisnik_id`, `wishlist_proizvod_id`),
  INDEX `fk_korisnik_narudzba1_idx` (`narudzba_id` ASC) VISIBLE,
  INDEX `fk_korisnik_recenzija1_idx` (`recenzija_id` ASC) VISIBLE,
  INDEX `fk_korisnik_wishlist1_idx` (`wishlist_korisnik_id` ASC, `wishlist_proizvod_id` ASC) VISIBLE,
  CONSTRAINT `fk_korisnik_narudzba1`
    FOREIGN KEY (`narudzba_id`)
    REFERENCES `new_schema1`.`narudzba` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_korisnik_recenzija1`
    FOREIGN KEY (`recenzija_id`)
    REFERENCES `new_schema1`.`recenzija` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_korisnik_wishlist1`
    FOREIGN KEY (`wishlist_korisnik_id` , `wishlist_proizvod_id`)
    REFERENCES `new_schema1`.`wishlist` (`korisnik_id` , `proizvod_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema1`.`kategorija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema1`.`kategorija` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(50) NULL,
  `opis` VARCHAR(50) NULL,
  `proizvod_id` INT NOT NULL,
  `proizvod_wishlist_korisnik_id` INT NOT NULL,
  `proizvod_wishlist_proizvod_id` INT NOT NULL,
  `proizvod_wishlist_korisnik_id1` INT NOT NULL,
  `proizvod_wishlist_proizvod_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_kategorija_proizvod1_idx` (`proizvod_id` ASC, `proizvod_wishlist_korisnik_id` ASC, `proizvod_wishlist_proizvod_id` ASC, `proizvod_wishlist_korisnik_id1` ASC, `proizvod_wishlist_proizvod_id1` ASC) VISIBLE,
  CONSTRAINT `fk_kategorija_proizvod1`
    FOREIGN KEY (`proizvod_id` , `proizvod_wishlist_korisnik_id` , `proizvod_wishlist_proizvod_id` , `proizvod_wishlist_korisnik_id1` , `proizvod_wishlist_proizvod_id1`)
    REFERENCES `new_schema1`.`proizvod` (`id` , `wishlist_korisnik_id` , `wishlist_proizvod_id` , `wishlist_korisnik_id1` , `wishlist_proizvod_id1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
