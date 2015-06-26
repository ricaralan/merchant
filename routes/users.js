var express = require('express');
var router = express.Router();
var MerchantEncriptation = require("../encriptation/MerchantEncriptation");
var userModel = require("../database/models/UserModel");

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

module.exports = router;
