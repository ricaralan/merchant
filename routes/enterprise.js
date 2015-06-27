var express = require('express');
var router = express.Router();
var abstractModel = require("../database/models/abstract/AbstractTableModel");
var connection = require("../database/connections/mysql_connection");
var tableModel = "usuario";

router.get('/', function(req, res) {
  res.render('app/enterprises', { title: 'Login - merchant' });
});

router.post('/create/:jsonDatos', function(req, res) {
  jsonDatos = JSON.parse(req.params.jsonDatos);
  abstractModel.insert("empresa", jsonDatos, function (err, results) {
    res.send(results);
  });
});


module.exports = router;
