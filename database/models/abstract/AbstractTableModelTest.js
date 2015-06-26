/**
* TEST AbstractTableModelTest
*/

var connection = require("../../connections/mysql_connection");
var self;
var AbstractTableModelTest = function () {
  self = this;
};

AbstractTableModelTest.prototype.tableStructure = {};
AbstractTableModelTest.prototype.table = "user";

AbstractTableModelTest.prototype.getDescriptionTable = function (callback) {
  connection.query("describe " + self.table, function (err, attributes) {
    json = {};
    for (pos in attributes) {
      json[attributes[pos].Field] = {type:attributes[pos].Type};
    }
    callback(json);
  });
};

AbstractTableModelTest.prototype.makeQueryInsert = function (jsonData) {
  self.getDescriptionTable(function(json){
    self.tableStructure = json;
    try {
      json = self.getDataJsonInsert(jsonData);
      query = ("INSERT INTO " + json.keys + " VALUES " + json.values);
      connection.query("INSERT INTO "+self.table+""+ json.keys +" VALUES " + json.signos, json.values, function (err, data){
        console.log(data);
      } );
    } catch (e) {
      console.log(e);
    }
  });
};

AbstractTableModelTest.prototype.getDataJsonInsert = function (jsonData) {
  keys = "", signos = "", values = [];
  cont = 0, i = 0;
  for (key in jsonData){
    if (self.existDataType(key)){
      if (cont != 0){
        keys   += ",";
        signos += ",";
      }
      keys += key;
      signos += "?";
      values[i++] =  jsonData[key];
    }
    cont ++;
  }
  return {
    keys   : "(" + keys   + ")",
    signos : "(" + signos + ")",
    values : values
  };
};

AbstractTableModelTest.prototype.existDataType = function (key) {
  return self.tableStructure != null;
};

AbstractTableModelTest.prototype.getCorrectTypeValue = function (key, value){
  if (self.tableStructure[key].type.indexOf("varchar") != 0 && self.tableStructure[key].type.indexOf("date") != 0) {
    return value;
  }
  return "'"+value+"'";
};

/**
* FIRE TEST
*/

new AbstractTableModelTest().makeQueryInsert({
  user_name   : "usuario",
  user_password : "contraseña",
  user_age : 21
});
