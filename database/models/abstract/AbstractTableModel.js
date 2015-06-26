/**
* TEST AbstractTableModel
*/

var connection = require("../../connections/mysql_connection");
var self;
var AbstractTableModel = function () {
  self = this;
};

AbstractTableModel.prototype.tableStructure = {};

AbstractTableModel.prototype.getDescriptionTable = function (table, callback) {
  connection.query("describe " + table, function (err, attributes) {
    json = {};
    for (pos in attributes) {
      json[attributes[pos].Field] = {type:attributes[pos].Type};
    }
    callback(json);
  });
};

AbstractTableModel.prototype.insert = function (table, jsonData, callback) {
  self.getDescriptionTable(table, function(json){
    self.tableStructure = json;
    try {
      json = self.getDataJsonInsert(jsonData);
      connection.query("INSERT INTO "+table+""+ json.keys +" VALUES " + json.signos, json.values, callback);
    } catch (e) {
      callback({message:"A field not found"}, null);
    }
  });
};

AbstractTableModel.prototype.update = function (table, jsonData, jsonIds, callback) {
  self.getDescriptionTable(table, function(json){
    self.tableStructure = json;
    try {
      json  = self.getDataJsonUpdate(jsonData, jsonIds);
      query = "UPDATE " + table + json.sets + json.whereids;
      connection.query(query, json.arrays, callback);
    } catch (e) {
      callback({message:"A field not found"}, null);
    }
  });
};

AbstractTableModel.prototype.delete = function (table, jsonIds, callback) {
  whereids = " WHERE ";
  json = self.getKeyValueJson(jsonIds);
  whereids += json.keys;
  connection.query("DELETE FROM " + table + whereids, json.arrayValues, callback);
};

AbstractTableModel.prototype.getDataJsonUpdate = function (jsonData, jsonIds) {
  sets = " SET ", whereids = " WHERE ";
  cont = 0, i = 0;
  json1 = self.getKeyValueJson(jsonData);
  sets += json1.keys;
  json2 = self.getKeyValueJson(jsonIds);
  whereids += json2.keys;
  return {
    sets      : sets,
    whereids  : whereids,
    arrays    : getJoinJsons(json1.arrayValues, json2.arrayValues)
  };
};

function getJoinJsons(json1, json2){
	json = [];
	mergeJson(json, json1);
	mergeJson(json, json2);
	return json
}

function mergeJson(jsonTemp, json){
  var i = jsonTemp.length;
	for (key in json){
    jsonTemp[i++] = json[key];
  }
}

AbstractTableModel.prototype.getKeyValueJson = function (jsonData) {
  keys = "";
  array = [];
  cont = 0, i = 0;
  for (key in jsonData) {
    if (self.existDataType(key)){
      if (cont != 0){
        keys += ",";
      }
      keys +=  key + "=?";
      array[i++] = jsonData[key];
    }
    cont++;
  }
  return {
    keys : keys,
    arrayValues : array
  };
};

AbstractTableModel.prototype.getDataJsonInsert = function (jsonData) {
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

AbstractTableModel.prototype.existDataType = function (key) {
  return self.tableStructure != null;
};

AbstractTableModel.prototype.getCorrectTypeValue = function (key, value){
  if (self.tableStructure[key].type.indexOf("varchar") != 0 && self.tableStructure[key].type.indexOf("date") != 0) {
    return value;
  }
  return "'"+value+"'";
};
/*
new AbstractTableModel().update("user", {
  user_name : "Alan",
  user_password : "secret2"
}, {
  user_id : 1
}, function (err, data){
  console.log(err);
  console.log(data);
});
*/
new AbstractTableModel().insert("user", {
  user_name : "Alan",
  user_password : "secret"
}, function (err, data){
  console.log(data);
});
/*
new AbstractTableModel().delete("user",{
  user_id : 5
}, function (err, data) {
  console.log(err);
  console.log(data);
});
*/
module.exports = new AbstractTableModel();
