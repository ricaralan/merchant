var express = require('express');
var router = express.Router();
var MerchantEncriptation = require("../encriptation/MerchantEncriptation");
var abstractModel = require("../database/models/abstract/AbstractTableModel");
var userModel = require("../database/models/UserModel");
var connection = require("../database/connections/mysql_connection");
var tableModel = "usuario";

router.get('/getDataForRegistryOfEmploye', function(req, res) {
  json = {};
  connection.query("SELECT * FROM usuario", function (err, values) {
    res.send(values);
  });
});


module.exports = router;
