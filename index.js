
var express = require('express');

var lib = require('./lib');

var app = express();

app.listen(8080, function(err, result) {
	if (!err) {
		console.log('Server started...');
	} else {
		console.error('Error occurred when starting server: ', err);
	}
});
