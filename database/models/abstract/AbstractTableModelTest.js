/**
* TEST AbstractTableModelTest
*/

var AbstractTableModelTest = function () {};

var tabla = "user";

var tableStructure = require("./tables/"+tabla);

AbstractTableModelTest.prototype.makeQuery = function (jsonData) {
  keys = "(", values = "(";
  cont = 0;
  for (key in jsonData){
    if (this.existDataType(key)){
      if (cont != 0){
        keys   += ",";
        values += ",";
      }
      keys += key;
      values += this.getCorrectTypeValue(key, jsonData[key]);
    }
    cont ++;
  }
  console.log("INSERT INTO " + tabla + keys +") VALUES " + values +")");
};

AbstractTableModelTest.prototype.existDataType = function (key) {
  return tableStructure[key] != null;
};

AbstractTableModelTest.prototype.getCorrectTypeValue = function (key, value){
  if (tableStructure[key].dataType != "varchar" && tableStructure[key].dataType != "date") {
    return value;
  }
  return "'"+value+"'";
};

new AbstractTableModelTest().makeQuery({
  usu_name   : "usuario",
  usu_password : "contraseña",
  usu_age : 21
});
