// Set up Express Framework
var express = require('express');
var fs = require('fs');
var app = express();


// Home Page
app.get('/', function(req, res) {
  // If READ_FROM_FILE is set then read from file
  if (process.env.READ_FROM_FILE) {
    res.contentType('application/text');
    // Synchronous read - only because we expect the file to be very small
    var contents = fs.readFileSync(process.env.READ_FROM_FILE, 'utf8');
    res.send(contents);
  }
  else {
    // Otherwise send all environment variables as JSON data
    res.contentType('application/json');
    res.send(process.env);
  }
});

var port = (process.env.APP_PORT || 8080);
app.listen(port);
console.log("Node Backend is listening at " + port);
