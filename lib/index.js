var express = require('express')
var sequelize = require('sequelize');
var async = require('async');

var app = express();
app.get('/', function(request, response) {
    var s = 'hello world';
    response.json(s)
});

module.exports = app;
