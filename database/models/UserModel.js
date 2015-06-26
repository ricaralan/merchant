var connection  = require("./../connections/mysql_connection");
var abstractTableModel  = require("./abstract/AbstractTableModel");

var UserModel = function (){};

UserModel.prototype.createUser = function (jsonDatos, callback){
	abstractTableModel.create("user", jsonDatos, callback);
};

UserModel.prototype.getUsers = function (callback){
	connection.query("SELECT * FROM user", callback);
};

UserModel.prototype.updateUser = function (jsonUser, callback){
	connection.query("UPDATE user SET user_name = ? WHERE user_id = ?", [jsonUser.user_name, jsonUser.user_id], callback);
};

UserModel.prototype.deleteUser = function (user_id, callback){
	connection.query("DELETE FROM user WHERE user_id=?", [user_id], callback);
};

module.exports = new UserModel();
