-- MySQL Script generated by MySQL Workbench
-- Mon Sep 14 00:05:38 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Bazar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Bazar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Bazar` DEFAULT CHARACTER SET utf8 ;
USE `Bazar` ;

-- -----------------------------------------------------
-- Table `Bazar`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bazar`.`Cliente` (
  `cpf` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bazar`.`Login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bazar`.`Login` (
  `codigo` INT NOT NULL,
  `senha` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bazar`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bazar`.`Funcionario` (
  `matricula` INT NOT NULL,
  `cpf` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `Login_codigo` INT NOT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_Funcionarios_Login1_idx` (`Login_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionarios_Login1`
    FOREIGN KEY (`Login_codigo`)
    REFERENCES `Bazar`.`Login` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bazar`.`TipoProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bazar`.`TipoProduto` (
  `codigo` INT NOT NULL,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bazar`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bazar`.`Fornecedor` (
  `cnpj` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bazar`.`Roupa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bazar`.`Roupa` (
  `codigo` INT NOT NULL,
  `descricao` VARCHAR(150) NOT NULL,
  `preco` DOUBLE NOT NULL,
  `marca` VARCHAR(100) NOT NULL,
  `tamanho` VARCHAR(100) NOT NULL,
  `TipoProduto_codigo` INT NOT NULL,
  `Fornecedor_cnpf` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_Roupas_TipoProduto1_idx` (`TipoProduto_codigo` ASC) VISIBLE,
  INDEX `fk_Roupa_Fornecedor1_idx` (`Fornecedor_cnpf` ASC) VISIBLE,
  CONSTRAINT `fk_Roupas_TipoProduto1`
    FOREIGN KEY (`TipoProduto_codigo`)
    REFERENCES `Bazar`.`TipoProduto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roupa_Fornecedor1`
    FOREIGN KEY (`Fornecedor_cnpf`)
    REFERENCES `Bazar`.`Fornecedor` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bazar`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bazar`.`Venda` (
  `Funcionarios_matricula` INT NOT NULL,
  `Clientes_cpf` INT NOT NULL,
  `Roupa_codigo` INT NOT NULL,
  `dataVenda` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Funcionarios_matricula`, `Clientes_cpf`),
  INDEX `fk_Funcionarios_has_Clientes_Clientes1_idx` (`Clientes_cpf` ASC) VISIBLE,
  INDEX `fk_Funcionarios_has_Clientes_Funcionarios_idx` (`Funcionarios_matricula` ASC) VISIBLE,
  INDEX `fk_Venda_Roupa1_idx` (`Roupa_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionarios_has_Clientes_Funcionarios`
    FOREIGN KEY (`Funcionarios_matricula`)
    REFERENCES `Bazar`.`Funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionarios_has_Clientes_Clientes1`
    FOREIGN KEY (`Clientes_cpf`)
    REFERENCES `Bazar`.`Cliente` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Roupa1`
    FOREIGN KEY (`Roupa_codigo`)
    REFERENCES `Bazar`.`Roupa` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
