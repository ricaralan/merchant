var connection  = require("./../connections/mysql_connection");
var abstractTableModel  = require("./abstract/AbstractTableModel");

var UserModel = function (){};

UserModel.prototype.existUser = function (usuario, contraseña, callback){
	query = "SELECT idUsuario, statusUsuario FROM usuario WHERE nombreUsuario=? AND passwordUsuario=?";
	connection.query(query, [usuario, contraseña], callback);
};

module.exports = new UserModel();
