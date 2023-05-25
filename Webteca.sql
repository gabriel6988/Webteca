-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Webteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Webteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Webteca` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema webteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema webteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `webteca` DEFAULT CHARACTER SET utf8mb3 ;
USE `Webteca` ;

-- -----------------------------------------------------
-- Table `Webteca`.`Leitores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Webteca`.`Leitores` (
  `ID_Leitor` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `CPF_Leitor` BIGINT(11) NOT NULL,
  `Nome_Leitor` VARCHAR(45) NOT NULL,
  `Email_Leitor` VARCHAR(45) NOT NULL,
  `Senha_Leitor` VARCHAR(45) NOT NULL,
  `Método de Pagamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Leitor`),
  UNIQUE INDEX `ID_Leitor_UNIQUE` (`ID_Leitor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Webteca`.`Avaliadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Webteca`.`Avaliadores` (
  `ID_Avaliador` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `CPF_Avaliador` BIGINT(11) NOT NULL,
  `Nome_Avaliador` VARCHAR(45) NOT NULL,
  `Email_Avaliador` VARCHAR(45) NOT NULL,
  `Senha_Avaliador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Avaliador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Webteca`.`Currículo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Webteca`.`Currículo` (
  `ID_Currículo` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `Status` TINYINT NULL,
  `Avaliadores_ID_Avaliador` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`ID_Currículo`),
  INDEX `fk_Currículo_Avaliadores1_idx` (`Avaliadores_ID_Avaliador` ASC) VISIBLE,
  UNIQUE INDEX `Avaliadores_ID_Avaliador_UNIQUE` (`Avaliadores_ID_Avaliador` ASC) VISIBLE,
  CONSTRAINT `fk_Currículo_Avaliadores1`
    FOREIGN KEY (`Avaliadores_ID_Avaliador`)
    REFERENCES `Webteca`.`Avaliadores` (`ID_Avaliador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Webteca`.`Narradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Webteca`.`Narradores` (
  `ID_Narrador` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `CPF_Narrador` BIGINT(11) NOT NULL,
  `Nome_Narrador` VARCHAR(45) NOT NULL,
  `Email_Narrador` VARCHAR(45) NOT NULL,
  `Senha_Narrador` VARCHAR(45) NOT NULL,
  `Currículo_ID_Currículo` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`ID_Narrador`, `Currículo_ID_Currículo`),
  INDEX `fk_Narradores_Currículo1_idx` (`Currículo_ID_Currículo` ASC) VISIBLE,
  UNIQUE INDEX `ID_Narrador_UNIQUE` (`ID_Narrador` ASC) VISIBLE,
  UNIQUE INDEX `Currículo_ID_Currículo_UNIQUE` (`Currículo_ID_Currículo` ASC) VISIBLE,
  CONSTRAINT `fk_Narradores_Currículo1`
    FOREIGN KEY (`Currículo_ID_Currículo`)
    REFERENCES `Webteca`.`Currículo` (`ID_Currículo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Webteca`.`Livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Webteca`.`Livros` (
  `ID_Livro` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `Nome_Livro` VARCHAR(45) NOT NULL,
  `Nome_Escritor` VARCHAR(45) NOT NULL,
  `Tema` VARCHAR(45) NOT NULL,
  `Edição` VARCHAR(45) NOT NULL,
  `Idioma` VARCHAR(45) NOT NULL,
  `Narradores_ID_Narrador` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`ID_Livro`),
  INDEX `fk_Livros_Narradores_idx` (`Narradores_ID_Narrador` ASC) VISIBLE,
  UNIQUE INDEX `Narradores_ID_Narrador_UNIQUE` (`Narradores_ID_Narrador` ASC) VISIBLE,
  CONSTRAINT `fk_Livros_Narradores`
    FOREIGN KEY (`Narradores_ID_Narrador`)
    REFERENCES `Webteca`.`Narradores` (`ID_Narrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Webteca`.`Reclamação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Webteca`.`Reclamação` (
  `ID_Reclamação` SMALLINT(5) NOT NULL AUTO_INCREMENT,
  `Nome do narrador` VARCHAR(45) NOT NULL,
  `Nome do Leitor` VARCHAR(45) NOT NULL,
  `Reclamação` VARCHAR(45) NOT NULL,
  `Narradores_ID_Narrador` SMALLINT(5) NOT NULL,
  `Leitores_ID_Leitor` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`ID_Reclamação`),
  INDEX `fk_Reclamação_Leitores1_idx` (`Leitores_ID_Leitor` ASC) VISIBLE,
  UNIQUE INDEX `Narradores_ID_Narrador_UNIQUE` (`Narradores_ID_Narrador` ASC) VISIBLE,
  UNIQUE INDEX `Leitores_ID_Leitor_UNIQUE` (`Leitores_ID_Leitor` ASC) VISIBLE,
  CONSTRAINT `fk_Reclamação_Narradores1`
    FOREIGN KEY (`Narradores_ID_Narrador`)
    REFERENCES `Webteca`.`Narradores` (`ID_Narrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reclamação_Leitores1`
    FOREIGN KEY (`Leitores_ID_Leitor`)
    REFERENCES `Webteca`.`Leitores` (`ID_Leitor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Webteca`.`Leitura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Webteca`.`Leitura` (
  `Leitores_ID_Leitor` SMALLINT(5) NOT NULL,
  `Livros_ID_Livro` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`Leitores_ID_Leitor`, `Livros_ID_Livro`),
  INDEX `fk_Livros_has_Leitores_Leitores1_idx` (`Leitores_ID_Leitor` ASC) VISIBLE,
  UNIQUE INDEX `Leitores_ID_Leitor_UNIQUE` (`Leitores_ID_Leitor` ASC) VISIBLE,
  INDEX `fk_Leitura_Livros1_idx` (`Livros_ID_Livro` ASC) VISIBLE,
  CONSTRAINT `fk_Livros_has_Leitores_Leitores1`
    FOREIGN KEY (`Leitores_ID_Leitor`)
    REFERENCES `Webteca`.`Leitores` (`ID_Leitor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Leitura_Livros1`
    FOREIGN KEY (`Livros_ID_Livro`)
    REFERENCES `Webteca`.`Livros` (`ID_Livro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Webteca`.`Avaliação da Reclamação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Webteca`.`Avaliação da Reclamação` (
  `Avaliadores_ID_Avaliador` SMALLINT(5) NOT NULL,
  `Validar` TINYINT NOT NULL,
  `Reclamação_ID_Reclamação` SMALLINT(5) NOT NULL,
  INDEX `fk_Reclamação_has_Avaliadores_Avaliadores1_idx` (`Avaliadores_ID_Avaliador` ASC) VISIBLE,
  PRIMARY KEY (`Reclamação_ID_Reclamação`, `Avaliadores_ID_Avaliador`),
  CONSTRAINT `fk_Reclamação_has_Avaliadores_Avaliadores1`
    FOREIGN KEY (`Avaliadores_ID_Avaliador`)
    REFERENCES `Webteca`.`Avaliadores` (`ID_Avaliador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Avaliação da Reclamação_Reclamação1`
    FOREIGN KEY (`Reclamação_ID_Reclamação`)
    REFERENCES `Webteca`.`Reclamação` (`ID_Reclamação`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `webteca` ;

-- -----------------------------------------------------
-- Table `webteca`.`avaliadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webteca`.`avaliadores` (
  `ID_Avaliador` SMALLINT NOT NULL,
  `CPF_Avaliador` BIGINT NOT NULL,
  `Nome_Avaliador` VARCHAR(45) NOT NULL,
  `Email_Avaliador` VARCHAR(45) NOT NULL,
  `Senha_Avaliador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Avaliador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `webteca`.`leitores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webteca`.`leitores` (
  `ID_Leitor` SMALLINT NOT NULL,
  `CPF_Leitor` BIGINT NOT NULL,
  `Nome_Leitor` VARCHAR(45) NOT NULL,
  `Email_Leitor` VARCHAR(45) NOT NULL,
  `Senha_Leitor` VARCHAR(45) NOT NULL,
  `Método de Pagamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Leitor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `webteca`.`narradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webteca`.`narradores` (
  `ID_Narrador` SMALLINT NOT NULL,
  `CPF_Narrador` BIGINT NOT NULL,
  `Nome_Narrador` VARCHAR(45) NOT NULL,
  `Email_Narrador` VARCHAR(45) NOT NULL,
  `Senha_Narrador` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Narrador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `webteca`.`reclamação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webteca`.`reclamação` (
  `ID_Reclamação` SMALLINT NOT NULL,
  `Nome do narrador` VARCHAR(45) NOT NULL,
  `Nome do Leitor` VARCHAR(45) NOT NULL,
  `Reclamação` VARCHAR(45) NOT NULL,
  `Narradores_ID_Narrador` SMALLINT NOT NULL,
  `Leitores_ID_Leitor` SMALLINT NOT NULL,
  PRIMARY KEY (`ID_Reclamação`),
  INDEX `fk_Reclamação_Leitores1_idx` (`Leitores_ID_Leitor` ASC) VISIBLE,
  INDEX `fk_Reclamação_Narradores1` (`Narradores_ID_Narrador` ASC) VISIBLE,
  CONSTRAINT `fk_Reclamação_Leitores1`
    FOREIGN KEY (`Leitores_ID_Leitor`)
    REFERENCES `webteca`.`leitores` (`ID_Leitor`),
  CONSTRAINT `fk_Reclamação_Narradores1`
    FOREIGN KEY (`Narradores_ID_Narrador`)
    REFERENCES `webteca`.`narradores` (`ID_Narrador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `webteca`.`avaliação da reclamação`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webteca`.`avaliação da reclamação` (
  `Avaliadores_ID_Avaliador` SMALLINT NOT NULL,
  `Validar` TINYINT NOT NULL,
  `Reclamação_ID_Reclamação` SMALLINT NOT NULL,
  PRIMARY KEY (`Reclamação_ID_Reclamação`, `Avaliadores_ID_Avaliador`),
  INDEX `fk_Reclamação_has_Avaliadores_Avaliadores1_idx` (`Avaliadores_ID_Avaliador` ASC) VISIBLE,
  CONSTRAINT `fk_Avaliação da Reclamação_Reclamação1`
    FOREIGN KEY (`Reclamação_ID_Reclamação`)
    REFERENCES `webteca`.`reclamação` (`ID_Reclamação`),
  CONSTRAINT `fk_Reclamação_has_Avaliadores_Avaliadores1`
    FOREIGN KEY (`Avaliadores_ID_Avaliador`)
    REFERENCES `webteca`.`avaliadores` (`ID_Avaliador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `webteca`.`currículo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webteca`.`currículo` (
  `ID_Currículo` SMALLINT NOT NULL,
  `Status` TINYINT NULL DEFAULT NULL,
  `Narradores_ID_Narrador` SMALLINT NOT NULL,
  `Avaliadores_ID_Avaliador` SMALLINT NOT NULL,
  PRIMARY KEY (`ID_Currículo`),
  INDEX `fk_Currículo_Narradores1_idx` (`Narradores_ID_Narrador` ASC) VISIBLE,
  INDEX `fk_Currículo_Avaliadores1_idx` (`Avaliadores_ID_Avaliador` ASC) VISIBLE,
  CONSTRAINT `fk_Currículo_Avaliadores1`
    FOREIGN KEY (`Avaliadores_ID_Avaliador`)
    REFERENCES `webteca`.`avaliadores` (`ID_Avaliador`),
  CONSTRAINT `fk_Currículo_Narradores1`
    FOREIGN KEY (`Narradores_ID_Narrador`)
    REFERENCES `webteca`.`narradores` (`ID_Narrador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `webteca`.`livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webteca`.`livros` (
  `ID_Livro` SMALLINT NOT NULL,
  `Nome_Livro` VARCHAR(45) NOT NULL,
  `Nome_Escritor` VARCHAR(45) NOT NULL,
  `Tema` VARCHAR(45) NOT NULL,
  `Edição` VARCHAR(45) NOT NULL,
  `Idioma` VARCHAR(45) NOT NULL,
  `Narradores_ID_Narrador` SMALLINT NOT NULL,
  PRIMARY KEY (`ID_Livro`),
  INDEX `fk_Livros_Narradores_idx` (`Narradores_ID_Narrador` ASC) VISIBLE,
  CONSTRAINT `fk_Livros_Narradores`
    FOREIGN KEY (`Narradores_ID_Narrador`)
    REFERENCES `webteca`.`narradores` (`ID_Narrador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `webteca`.`leitura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `webteca`.`leitura` (
  `Leitores_ID_Leitor` SMALLINT NOT NULL,
  `Livros_ID_Livro` SMALLINT NOT NULL,
  PRIMARY KEY (`Leitores_ID_Leitor`, `Livros_ID_Livro`),
  UNIQUE INDEX `Leitores_ID_Leitor_UNIQUE` (`Leitores_ID_Leitor` ASC) VISIBLE,
  INDEX `fk_Livros_has_Leitores_Leitores1_idx` (`Leitores_ID_Leitor` ASC) VISIBLE,
  INDEX `fk_Leitura_Livros1_idx` (`Livros_ID_Livro` ASC) VISIBLE,
  CONSTRAINT `fk_Leitura_Livros1`
    FOREIGN KEY (`Livros_ID_Livro`)
    REFERENCES `webteca`.`livros` (`ID_Livro`),
  CONSTRAINT `fk_Livros_has_Leitores_Leitores1`
    FOREIGN KEY (`Leitores_ID_Leitor`)
    REFERENCES `webteca`.`leitores` (`ID_Leitor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
