-- MySQL Script generated by MySQL Workbench
-- 06/26/15 02:48:05
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema merchant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema merchant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `merchant` DEFAULT CHARACTER SET latin1 ;
USE `merchant` ;

-- -----------------------------------------------------
-- Table `merchant`.`domiciliofiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`domiciliofiscal` (
  `idDomicilioFiscal` INT(11) NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `numExt` VARCHAR(45) NULL DEFAULT NULL,
  `numInt` VARCHAR(5) NULL DEFAULT NULL,
  `colonia` VARCHAR(45) NULL DEFAULT NULL,
  `codigoPostal` VARCHAR(45) NULL DEFAULT NULL,
  `localidad` VARCHAR(45) NULL DEFAULT NULL,
  `municipio` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  `pais` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idDomicilioFiscal`))
ENGINE = InnoDB
AUTO_INCREMENT = 36
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`cliente` (
  `idCliente` INT(11) NOT NULL AUTO_INCREMENT,
  `rfcCliente` VARCHAR(15) NOT NULL,
  `nombreCliente` VARCHAR(145) NOT NULL,
  `telCliente` VARCHAR(15) NOT NULL,
  `tel2Cliente` VARCHAR(15) NULL DEFAULT NULL,
  `mailCliente` VARCHAR(45) NOT NULL,
  `altaCliente` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `statusCliente` TINYINT(4) NULL DEFAULT NULL,
  `domicilioFiscal_idDomicilioFiscal` INT(11) NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_cliente_domicilioFiscal1_idx` (`domicilioFiscal_idDomicilioFiscal` ASC),
  CONSTRAINT `fk_cliente_domicilioFiscal1`
    FOREIGN KEY (`domicilioFiscal_idDomicilioFiscal`)
    REFERENCES `merchant`.`domiciliofiscal` (`idDomicilioFiscal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`usuario` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreUsuario` VARCHAR(45) NOT NULL,
  `passwordUsuario` VARCHAR(45) NOT NULL,
  `statusUsuario` TINYINT(4) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`empresa` (
  `idEmpresa` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreEmpresa` VARCHAR(45) NOT NULL,
  `rfcEmpresa` VARCHAR(15) NOT NULL,
  `regimenEmpresa` VARCHAR(95) NULL DEFAULT NULL,
  `logoEmpresa` VARCHAR(45) NULL DEFAULT NULL,
  `telEmpresa` VARCHAR(15) NULL DEFAULT NULL,
  `tel2Empresa` VARCHAR(15) NULL DEFAULT NULL,
  `mailEmpresa` VARCHAR(45) NULL DEFAULT NULL,
  `webEmpresa` VARCHAR(45) NULL DEFAULT NULL,
  `altaEmpresa` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `domicilioFiscal_idDomicilioFiscal` INT(11) NOT NULL,
  PRIMARY KEY (`idEmpresa`),
  INDEX `fk_empresa_domicilioFiscal1_idx` (`domicilioFiscal_idDomicilioFiscal` ASC),
  CONSTRAINT `fk_empresa_domicilioFiscal1`
    FOREIGN KEY (`domicilioFiscal_idDomicilioFiscal`)
    REFERENCES `merchant`.`domiciliofiscal` (`idDomicilioFiscal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`sucursal` (
  `idSucursal` INT NOT NULL AUTO_INCREMENT,
  `nombreSucursal` VARCHAR(45) NULL,
  `empresa_idEmpresa` INT(11) NOT NULL,
  `domiciliofiscal_idDomicilioFiscal` INT(11) NOT NULL,
  PRIMARY KEY (`idSucursal`, `empresa_idEmpresa`, `domiciliofiscal_idDomicilioFiscal`),
  INDEX `fk_sucursal_empresa1_idx` (`empresa_idEmpresa` ASC),
  INDEX `fk_sucursal_domiciliofiscal1_idx` (`domiciliofiscal_idDomicilioFiscal` ASC),
  CONSTRAINT `fk_sucursal_empresa1`
    FOREIGN KEY (`empresa_idEmpresa`)
    REFERENCES `merchant`.`empresa` (`idEmpresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sucursal_domiciliofiscal1`
    FOREIGN KEY (`domiciliofiscal_idDomicilioFiscal`)
    REFERENCES `merchant`.`domiciliofiscal` (`idDomicilioFiscal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merchant`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`empleado` (
  `idEmpleado` INT(11) NOT NULL AUTO_INCREMENT,
  `rfcEmpleado` VARCHAR(25) NOT NULL,
  `tipoEmpleado` VARCHAR(15) NULL DEFAULT NULL,
  `nombreEmpleado` VARCHAR(45) NOT NULL,
  `telefonoEmpleado` VARCHAR(45) NULL DEFAULT NULL,
  `mailEmpleado` VARCHAR(45) NULL DEFAULT NULL,
  `salarioDiarioEmpleado` DOUBLE NOT NULL,
  `diasLaboralesEmpleado` INT(11) NULL DEFAULT NULL,
  `altaEmpleado` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_idUsuario` INT(11) NOT NULL,
  `domicilioFiscal_idDomicilioFiscal` INT(11) NOT NULL,
  `sucursal_idSucursal` INT NOT NULL,
  `bajaEmpleado` TIMESTAMP NULL,
  `statusEmpleado` TINYINT(4) NULL,
  PRIMARY KEY (`idEmpleado`, `sucursal_idSucursal`),
  INDEX `fk_empleado_usuario1_idx` (`usuario_idUsuario` ASC),
  INDEX `fk_empleado_domicilioFiscal1_idx` (`domicilioFiscal_idDomicilioFiscal` ASC),
  INDEX `fk_empleado_sucursal1_idx` (`sucursal_idSucursal` ASC),
  CONSTRAINT `fk_empleado_domicilioFiscal1`
    FOREIGN KEY (`domicilioFiscal_idDomicilioFiscal`)
    REFERENCES `merchant`.`domiciliofiscal` (`idDomicilioFiscal`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleado_usuario1`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `merchant`.`usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleado_sucursal1`
    FOREIGN KEY (`sucursal_idSucursal`)
    REFERENCES `merchant`.`sucursal` (`idSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`proveedor` (
  `idProveedor` INT(11) NOT NULL AUTO_INCREMENT,
  `rfcProveedor` VARCHAR(15) NOT NULL,
  `nombreProveedor` VARCHAR(45) NOT NULL,
  `telProveedor` VARCHAR(15) NULL DEFAULT NULL,
  `tel2Proveedor` VARCHAR(15) NULL DEFAULT NULL,
  `mailProveedor` VARCHAR(45) NULL DEFAULT NULL,
  `domicilioFiscal_idDomicilioFiscal` INT(11) NOT NULL,
  PRIMARY KEY (`idProveedor`),
  INDEX `fk_proveedor_domicilioFiscal1_idx` (`domicilioFiscal_idDomicilioFiscal` ASC),
  CONSTRAINT `fk_proveedor_domicilioFiscal1`
    FOREIGN KEY (`domicilioFiscal_idDomicilioFiscal`)
    REFERENCES `merchant`.`domiciliofiscal` (`idDomicilioFiscal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`compra` (
  `idCompra` INT(11) NOT NULL AUTO_INCREMENT,
  `fechaCompra` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `totalCompra` FLOAT NOT NULL,
  `tipoPagoCompra` VARCHAR(10) NOT NULL,
  `statusCompra` VARCHAR(10) NOT NULL,
  `statusLiquidezCompra` TINYINT NOT NULL,
  `fechaPagoLimiteCompra` DATE NULL,
  `numeroPagos` INT NULL,
  `proveedor_idProveedor` INT(11) NOT NULL,
  `empleado_idEmpleado` INT(11) NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `fk_compra_proveedor1_idx` (`proveedor_idProveedor` ASC),
  INDEX `fk_compra_empleado1_idx` (`empleado_idEmpleado` ASC),
  CONSTRAINT `fk_compra_empleado1`
    FOREIGN KEY (`empleado_idEmpleado`)
    REFERENCES `merchant`.`empleado` (`idEmpleado`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_compra_proveedor1`
    FOREIGN KEY (`proveedor_idProveedor`)
    REFERENCES `merchant`.`proveedor` (`idProveedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`tipoUnidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`tipoUnidad` (
  `idtipoUnidad` INT(2) NOT NULL,
  `codigoUnidad` VARCHAR(8) NULL,
  `descripcionUnidad` VARCHAR(50) NULL,
  PRIMARY KEY (`idtipoUnidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merchant`.`impuesto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`impuesto` (
  `idImpuesto` INT(2) NOT NULL,
  `codigoImpuesto` VARCHAR(8) NULL,
  `descripcionImpuesto` VARCHAR(50) NULL,
  `valorImpuesto` FLOAT NULL,
  PRIMARY KEY (`idImpuesto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merchant`.`linea`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`linea` (
  `idLinea` INT(2) NOT NULL,
  `codigoLinea` VARCHAR(8) NULL,
  `descripcionLinea` VARCHAR(50) NULL,
  PRIMARY KEY (`idLinea`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merchant`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`producto` (
  `idCodigoBarraProducto` VARCHAR(20) NOT NULL,
  `descripcionProducto` VARCHAR(95) NULL DEFAULT NULL,
  `existenciaProducto` FLOAT NOT NULL,
  `stockMinimoProducto` FLOAT NOT NULL,
  `precioVenta` FLOAT NOT NULL,
  `tipoUnidad_idtipoUnidad` INT(2) NOT NULL,
  `impuesto_idImpuesto` INT(2) NOT NULL,
  `statusProducto` TINYINT(4) NULL,
  `linea_idLinea` INT NOT NULL,
  PRIMARY KEY (`idCodigoBarraProducto`, `tipoUnidad_idtipoUnidad`, `impuesto_idImpuesto`, `linea_idLinea`),
  INDEX `fk_producto_tipoUnidad1_idx` (`tipoUnidad_idtipoUnidad` ASC),
  INDEX `fk_producto_impuesto1_idx` (`impuesto_idImpuesto` ASC),
  INDEX `fk_producto_linea1_idx` (`linea_idLinea` ASC),
  CONSTRAINT `fk_producto_tipoUnidad1`
    FOREIGN KEY (`tipoUnidad_idtipoUnidad`)
    REFERENCES `merchant`.`tipoUnidad` (`idtipoUnidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_impuesto1`
    FOREIGN KEY (`impuesto_idImpuesto`)
    REFERENCES `merchant`.`impuesto` (`idImpuesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_linea1`
    FOREIGN KEY (`linea_idLinea`)
    REFERENCES `merchant`.`linea` (`idLinea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`detallecompra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`detallecompra` (
  `producto_idCodigoBarraProducto` VARCHAR(20) NOT NULL,
  `compra_idCompra` INT(11) NOT NULL,
  `costoUnitarioProducto` FLOAT NULL,
  `cantidad` FLOAT NOT NULL,
  PRIMARY KEY (`producto_idCodigoBarraProducto`, `compra_idCompra`),
  INDEX `fk_producto_has_compra_compra1_idx` (`compra_idCompra` ASC),
  INDEX `fk_producto_has_compra_producto1_idx` (`producto_idCodigoBarraProducto` ASC),
  CONSTRAINT `fk_producto_has_compra_compra1`
    FOREIGN KEY (`compra_idCompra`)
    REFERENCES `merchant`.`compra` (`idCompra`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_producto_has_compra_producto1`
    FOREIGN KEY (`producto_idCodigoBarraProducto`)
    REFERENCES `merchant`.`producto` (`idCodigoBarraProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`detalleproducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`detalleproducto` (
  `proveedor_idProveedor` INT(11) NOT NULL,
  `producto_idProducto` INT(11) NOT NULL,
  `precioCompra` FLOAT NOT NULL,
  PRIMARY KEY (`proveedor_idProveedor`, `producto_idProducto`),
  INDEX `fk_proveedor_has_producto_producto1_idx` (`producto_idProducto` ASC),
  INDEX `fk_proveedor_has_producto_proveedor1_idx` (`proveedor_idProveedor` ASC),
  CONSTRAINT `fk_proveedor_has_producto_producto1`
    FOREIGN KEY (`producto_idProducto`)
    REFERENCES `merchant`.`producto` (`idCodigoBarraProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_proveedor_has_producto_proveedor1`
    FOREIGN KEY (`proveedor_idProveedor`)
    REFERENCES `merchant`.`proveedor` (`idProveedor`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`tipoComprobante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`tipoComprobante` (
  `idTipoComprobante` INT(2) NOT NULL,
  `codigoTipo` VARCHAR(8) NULL,
  `descripcionComprobante` VARCHAR(50) NULL,
  PRIMARY KEY (`idTipoComprobante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `merchant`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`venta` (
  `idVenta` INT(11) NOT NULL AUTO_INCREMENT,
  `fechaVenta` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subTotalVenta` FLOAT NOT NULL,
  `ivaVenta` FLOAT NOT NULL,
  `totalVenta` FLOAT NOT NULL,
  `estatusVenta` VARCHAR(10) NOT NULL,
  `tipoVenta` VARCHAR(10) NULL DEFAULT NULL,
  `cliente_idCliente` INT(11) NOT NULL,
  `empleado_idEmpleado` INT(11) NOT NULL,
  `tipoComprobante_idTipoComprobante` INT(2) NOT NULL,
  PRIMARY KEY (`idVenta`, `tipoComprobante_idTipoComprobante`),
  INDEX `fk_venta_cliente1_idx` (`cliente_idCliente` ASC),
  INDEX `fk_venta_empleado1_idx` (`empleado_idEmpleado` ASC),
  INDEX `fk_venta_tipoComprobante1_idx` (`tipoComprobante_idTipoComprobante` ASC),
  CONSTRAINT `fk_venta_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `merchant`.`cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_empleado1`
    FOREIGN KEY (`empleado_idEmpleado`)
    REFERENCES `merchant`.`empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_tipoComprobante1`
    FOREIGN KEY (`tipoComprobante_idTipoComprobante`)
    REFERENCES `merchant`.`tipoComprobante` (`idTipoComprobante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`detalleventa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`detalleventa` (
  `producto_idCodigoBarraProducto` VARCHAR(20) NOT NULL,
  `venta_idVenta` INT(11) NOT NULL,
  `cantidad` FLOAT NOT NULL,
  PRIMARY KEY (`producto_idCodigoBarraProducto`, `venta_idVenta`),
  INDEX `fk_venta_has_producto_producto1_idx` (`producto_idCodigoBarraProducto` ASC),
  INDEX `fk_venta_has_producto_venta1_idx` (`venta_idVenta` ASC),
  CONSTRAINT `fk_venta_has_producto_producto1`
    FOREIGN KEY (`producto_idCodigoBarraProducto`)
    REFERENCES `merchant`.`producto` (`idCodigoBarraProducto`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_venta_has_producto_venta1`
    FOREIGN KEY (`venta_idVenta`)
    REFERENCES `merchant`.`venta` (`idVenta`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `merchant`.`pagosCompra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `merchant`.`pagosCompra` (
  `idPagosCompra` INT NOT NULL,
  `montoPago` VARCHAR(45) NULL,
  `fechaPagoCompra` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `compra_idCompra` INT(11) NOT NULL,
  PRIMARY KEY (`idPagosCompra`, `compra_idCompra`),
  INDEX `fk_pagosCompra_compra1_idx` (`compra_idCompra` ASC),
  CONSTRAINT `fk_pagosCompra_compra1`
    FOREIGN KEY (`compra_idCompra`)
    REFERENCES `merchant`.`compra` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE USER 'merchant' IDENTIFIED BY 'merchan';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;