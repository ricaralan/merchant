var express = require('express');
var router = express.Router();
var MerchantEncriptation = require("../encriptation/MerchantEncriptation");
var abstractModel = require("../database/models/abstract/AbstractTableModel");
var userModel = require("../database/models/UserModel");
var tableModel = "usuario";

router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.get("/existUser/:user/:password", function (req, res){
  var user = req.params.user;
  var password = MerchantEncriptation.cipher(req.params.password);
  userModel.existUser(user, password, function (err, user) {
    res.send(user);
  });
});

router.post("/newUser/:jsonDatos", function (req, res) {
  var jsonDatos = req.params.jsonDatos;
  if (jsonDatos.passwordUsuario != null) {
    jsonDatos.passwordUsuario = MerchantEncriptation.cipher(jsonDatos.passwordUsuario);
    abstractModel.insert(tableModel, jsonDatos, function (err, results) {
      console.log(results);
      res.send(results);
    });
  }
});

module.exports = router;
