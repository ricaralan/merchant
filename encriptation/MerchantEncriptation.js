/**
*	Este modulo sirve para encriptar y desencriptar lo que se requiera...
*	Si es necesario cambiar la key por defecto tiene que ser en la instalación.
*	Ya que despues no se podrá por que entonces no se podría decifrar lo que
*	se ha guardado en base de datos.
*
*	@version 0.0.1
*	@author Alan Olvares
*/

var crypto	= require("crypto");
var configEncriptacion = require("./ConfigEncriptacion");

var MerchantEncriptation = function(){};

MerchantEncriptation.prototype.openSSLCipherAlgorithm =
				   configEncriptacion.openSSLCipherAlgorithm;
MerchantEncriptation.prototype.key = configEncriptacion.key;

/*	Aqui se recibe la palabra que se cifrará	*/
MerchantEncriptation.prototype.cifrar = function(palabraAEncriptar) {
	try{
		var cipher 	 = crypto.createCipher(
			MerchantEncriptation.prototype.openSSLCipherAlgorithm,
			MerchantEncriptation.prototype.key);
		var cifrado  = cipher.update(palabraAEncriptar, "utf8", "hex");
		cifrado 	  += cipher.final("hex");
	}catch(e){
		console.log(e.message);
	}
	return cifrado;
};

/*	Aqui se recibe la palabra que se decifrará			*/
MerchantEncriptation.prototype.decifrar = function(palabraADecifrar){
	try{
		var decipher = crypto.createDecipher(
			MerchantEncriptation.prototype.openSSLCipherAlgorithm,
			MerchantEncriptation.prototype.key);
		var palabraDecifrada  = decipher.update(palabraADecifrar, "hex", "utf8");
		palabraDecifrada	 += decipher.final("utf8");
	}catch(e){
		console.log(e.message + "  -->  " + palabraADecifrar);
	}
	return palabraDecifrada;
};

module.exports = new MerchantEncriptation();
