/**
*  This file return connection mysql
*/
var configDB = require("./../config/config_db");

module.exports = require("mysql").createConnection(configDB.mysql);
