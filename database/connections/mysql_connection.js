/**
*  This file return connection mysql
*/
var configDB = require("./../config/config_db");
var connection = require("mysql").createConnection(configDB.mysql);
module.exports = connection;
