-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema detenidos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `detenidos` ;

-- -----------------------------------------------------
-- Schema detenidos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `detenidos` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `detenidos` ;

-- -----------------------------------------------------
-- Table `detenidos`.`detenido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`detenido` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`detenido` (
  `iddetenido` INT NOT NULL AUTO_INCREMENT,
  `estado_civil` VARCHAR(45) NULL,
  `estatus_migratorio` VARCHAR(45) NULL,
  `edad` TINYINT(1) NULL,
  `sexo` VARCHAR(20) NULL,
  `nacionalidad` VARCHAR(20) NULL,
  `autoidentificacion_etnica` VARCHAR(40) NULL,
  `numero_detenciones` TINYINT(1) NULL,
  `nivel_de_instruccion` VARCHAR(45) NULL,
  `condicion` VARCHAR(95) NULL,
  `movilizacion` VARCHAR(15) NULL,
  PRIMARY KEY (`iddetenido`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`arma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`arma` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`arma` (
  `idarma` INT NOT NULL AUTO_INCREMENT,
  `nombre_arma` VARCHAR(20) NULL,
  `tipo_arma` VARCHAR(45) NULL,
  `detenido_iddetenido` INT NOT NULL,
  PRIMARY KEY (`idarma`),
  INDEX `fk_arma_detenido_idx` (`detenido_iddetenido` ASC) VISIBLE,
  CONSTRAINT `fk_arma_detenido`
    FOREIGN KEY (`detenido_iddetenido`)
    REFERENCES `detenidos`.`detenido` (`iddetenido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`infraccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`infraccion` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`infraccion` (
  `idinfraccion` INT NOT NULL AUTO_INCREMENT,
  `presunta_infraccion` VARCHAR(120) NULL,
  `presunta_subinfraccion` VARCHAR(170) NULL,
  `presunta_modalidad` VARCHAR(400) NULL,
  `codigo_iccs` VARCHAR(10) NULL,
  PRIMARY KEY (`idinfraccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`lugar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`lugar` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`lugar` (
  `idlugar` INT NOT NULL,
  `lugar` VARCHAR(45) NULL,
  `tipo_lugar` VARCHAR(55) NULL,
  PRIMARY KEY (`idlugar`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`zona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`zona` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`zona` (
  `idzona` INT NOT NULL AUTO_INCREMENT,
  `nombre_zona` VARCHAR(7) NULL,
  PRIMARY KEY (`idzona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`subzona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`subzona` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`subzona` (
  `idsubzona` INT NOT NULL AUTO_INCREMENT,
  `nombre_subzona` VARCHAR(35) NULL,
  `zona_idzona` INT NOT NULL,
  PRIMARY KEY (`idsubzona`),
  INDEX `fk_subzona_zona1_idx` (`zona_idzona` ASC) VISIBLE,
  CONSTRAINT `fk_subzona_zona1`
    FOREIGN KEY (`zona_idzona`)
    REFERENCES `detenidos`.`zona` (`idzona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`distrito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`distrito` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`distrito` (
  `codigo_distrito` VARCHAR(6) NOT NULL,
  `nombre_distrito` VARCHAR(20) NULL,
  `subzona_idsubzona` INT NOT NULL,
  PRIMARY KEY (`codigo_distrito`),
  INDEX `fk_distrito_subzona1_idx` (`subzona_idsubzona` ASC) VISIBLE,
  CONSTRAINT `fk_distrito_subzona1`
    FOREIGN KEY (`subzona_idsubzona`)
    REFERENCES `detenidos`.`subzona` (`idsubzona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`circuito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`circuito` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`circuito` (
  `codigo_circuito` VARCHAR(9) NOT NULL,
  `nombre_circuito` VARCHAR(20) NULL,
  `distrito_codigo_distrito` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`codigo_circuito`),
  INDEX `fk_circuito_distrito1_idx` (`distrito_codigo_distrito` ASC) VISIBLE,
  CONSTRAINT `fk_circuito_distrito1`
    FOREIGN KEY (`distrito_codigo_distrito`)
    REFERENCES `detenidos`.`distrito` (`codigo_distrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`subcircuito`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`subcircuito` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`subcircuito` (
  `codigo_subcircuito` VARCHAR(12) NOT NULL,
  `nombre_subcircuito` VARCHAR(25) NULL,
  `circuito_codigo_circuito` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`codigo_subcircuito`),
  INDEX `fk_subcircuito_circuito1_idx` (`circuito_codigo_circuito` ASC) VISIBLE,
  CONSTRAINT `fk_subcircuito_circuito1`
    FOREIGN KEY (`circuito_codigo_circuito`)
    REFERENCES `detenidos`.`circuito` (`codigo_circuito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`provincia` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`provincia` (
  `codigo_provincia` VARCHAR(3) NOT NULL,
  `nombre_provincia` VARCHAR(35) NULL,
  PRIMARY KEY (`codigo_provincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`canton`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`canton` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`canton` (
  `codigo_canton` VARCHAR(5) NOT NULL,
  `nombre_canton` VARCHAR(30) NULL,
  `provincia_codigo_provincia` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`codigo_canton`),
  INDEX `fk_canton_provincia1_idx` (`provincia_codigo_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_canton_provincia1`
    FOREIGN KEY (`provincia_codigo_provincia`)
    REFERENCES `detenidos`.`provincia` (`codigo_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`parroquia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`parroquia` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`parroquia` (
  `codigo_parroquia` VARCHAR(7) NOT NULL,
  `nombre_parroquia` VARCHAR(50) NULL,
  PRIMARY KEY (`codigo_parroquia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`detencion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`detencion` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`detencion` (
  `iddetencion` INT NOT NULL,
  `tipo_Detencion` VARCHAR(15) NULL,
  `fecha` DATE NULL,
  `hora` DATETIME NULL,
  `detenido_iddetenido` INT NOT NULL,
  `infraccion_idinfraccion` INT NOT NULL,
  `lugar_idlugar` INT NOT NULL,
  `zona_idzona` INT NOT NULL,
  `subzona_idsubzona` INT NOT NULL,
  `distrito_codigo_distrito` VARCHAR(6) NOT NULL,
  `circuito_codigo_circuito` VARCHAR(9) NOT NULL,
  `subcircuito_codigo_subcircuito` VARCHAR(12) NOT NULL,
  `provincia_codigo_provincia` VARCHAR(3) NOT NULL,
  `canton_codigo_canton` VARCHAR(5) NOT NULL,
  `parroquia_codigo_parroquia` VARCHAR(7) NOT NULL,
  PRIMARY KEY (`iddetencion`),
  INDEX `fk_detencion_detenido1_idx` (`detenido_iddetenido` ASC) VISIBLE,
  INDEX `fk_detencion_infraccion1_idx` (`infraccion_idinfraccion` ASC) VISIBLE,
  INDEX `fk_detencion_lugar1_idx` (`lugar_idlugar` ASC) VISIBLE,
  INDEX `fk_detencion_zona1_idx` (`zona_idzona` ASC) VISIBLE,
  INDEX `fk_detencion_subzona1_idx` (`subzona_idsubzona` ASC) VISIBLE,
  INDEX `fk_detencion_distrito1_idx` (`distrito_codigo_distrito` ASC) VISIBLE,
  INDEX `fk_detencion_circuito1_idx` (`circuito_codigo_circuito` ASC) VISIBLE,
  INDEX `fk_detencion_subcircuito1_idx` (`subcircuito_codigo_subcircuito` ASC) VISIBLE,
  INDEX `fk_detencion_provincia1_idx` (`provincia_codigo_provincia` ASC) VISIBLE,
  INDEX `fk_detencion_canton1_idx` (`canton_codigo_canton` ASC) VISIBLE,
  INDEX `fk_detencion_parroquia1_idx` (`parroquia_codigo_parroquia` ASC) VISIBLE,
  CONSTRAINT `fk_detencion_detenido1`
    FOREIGN KEY (`detenido_iddetenido`)
    REFERENCES `detenidos`.`detenido` (`iddetenido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_infraccion1`
    FOREIGN KEY (`infraccion_idinfraccion`)
    REFERENCES `detenidos`.`infraccion` (`idinfraccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_lugar1`
    FOREIGN KEY (`lugar_idlugar`)
    REFERENCES `detenidos`.`lugar` (`idlugar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_zona1`
    FOREIGN KEY (`zona_idzona`)
    REFERENCES `detenidos`.`zona` (`idzona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_subzona1`
    FOREIGN KEY (`subzona_idsubzona`)
    REFERENCES `detenidos`.`subzona` (`idsubzona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_distrito1`
    FOREIGN KEY (`distrito_codigo_distrito`)
    REFERENCES `detenidos`.`distrito` (`codigo_distrito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_circuito1`
    FOREIGN KEY (`circuito_codigo_circuito`)
    REFERENCES `detenidos`.`circuito` (`codigo_circuito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_subcircuito1`
    FOREIGN KEY (`subcircuito_codigo_subcircuito`)
    REFERENCES `detenidos`.`subcircuito` (`codigo_subcircuito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_provincia1`
    FOREIGN KEY (`provincia_codigo_provincia`)
    REFERENCES `detenidos`.`provincia` (`codigo_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_canton1`
    FOREIGN KEY (`canton_codigo_canton`)
    REFERENCES `detenidos`.`canton` (`codigo_canton`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detencion_parroquia1`
    FOREIGN KEY (`parroquia_codigo_parroquia`)
    REFERENCES `detenidos`.`parroquia` (`codigo_parroquia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`densidad_Poblacional`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`densidad_Poblacional` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`densidad_Poblacional` (
  `iddensidad_Poblacional` INT NOT NULL AUTO_INCREMENT,
  `superficie_km2` DOUBLE NULL,
  `densidad` DOUBLE NULL,
  `anio` INT NULL,
  `provincia_codigo_provincia` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`iddensidad_Poblacional`),
  INDEX `fk_densidad_Poblacional_provincia1_idx` (`provincia_codigo_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_densidad_Poblacional_provincia1`
    FOREIGN KEY (`provincia_codigo_provincia`)
    REFERENCES `detenidos`.`provincia` (`codigo_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`poblacion_total`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`poblacion_total` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`poblacion_total` (
  `idpoblacion_total` INT NOT NULL AUTO_INCREMENT,
  `poblacion_total` DOUBLE NULL,
  `anio` INT NULL,
  `provincia_codigo_provincia` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`idpoblacion_total`),
  INDEX `fk_poblacion_total_provincia1_idx` (`provincia_codigo_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_poblacion_total_provincia1`
    FOREIGN KEY (`provincia_codigo_provincia`)
    REFERENCES `detenidos`.`provincia` (`codigo_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`costo_canasta_basica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`costo_canasta_basica` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`costo_canasta_basica` (
  `idcosto_canasta_basica` INT NOT NULL AUTO_INCREMENT,
  `costo` DOUBLE NULL,
  `mes` VARCHAR(15) NULL,
  `anio` INT NULL,
  `provincia_codigo_provincia` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`idcosto_canasta_basica`),
  INDEX `fk_costo_canasta_basica_provincia1_idx` (`provincia_codigo_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_costo_canasta_basica_provincia1`
    FOREIGN KEY (`provincia_codigo_provincia`)
    REFERENCES `detenidos`.`provincia` (`codigo_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`tasa_desempleo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`tasa_desempleo` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`tasa_desempleo` (
  `idtasa_desempleo` INT NOT NULL AUTO_INCREMENT,
  `tasa_desempleo` DOUBLE NULL,
  `anio` INT NULL,
  `provincia_codigo_provincia` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`idtasa_desempleo`),
  INDEX `fk_tasa_desempleo_provincia1_idx` (`provincia_codigo_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_tasa_desempleo_provincia1`
    FOREIGN KEY (`provincia_codigo_provincia`)
    REFERENCES `detenidos`.`provincia` (`codigo_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detenidos`.`sector_informal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detenidos`.`sector_informal` ;

CREATE TABLE IF NOT EXISTS `detenidos`.`sector_informal` (
  `idsector_informal` INT NOT NULL AUTO_INCREMENT,
  `tasa_sector_informal` DOUBLE NULL,
  `anio` INT NULL,
  `provincia_codigo_provincia` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`idsector_informal`),
  INDEX `fk_sector_informal_provincia1_idx` (`provincia_codigo_provincia` ASC) VISIBLE,
  CONSTRAINT `fk_sector_informal_provincia1`
    FOREIGN KEY (`provincia_codigo_provincia`)
    REFERENCES `detenidos`.`provincia` (`codigo_provincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
