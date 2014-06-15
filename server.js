require('coffee-script').register();
var express = require('express');
var app = express();
var server = require('http').createServer(app);
var jitter = require('jitter');
var io = require('socket.io').listen(server);
var activityClass = require('./activity')();
var activity = new activityClass();
var people = {};
var messages = {};

app.use(express.json());       // to support JSON-encoded bodies
app.use(express.urlencoded()); // to support URL-encoded bodies
require('./routes')(app, io, activity);
app.use("/css", express.static(__dirname + '/css'));
app.use("/fonts", express.static(__dirname + '/fonts'));
app.use("/templates", express.static(__dirname + '/templates'));
app.use("/js", express.static(__dirname + '/js'));
app.use("/coffee", express.static(__dirname + '/coffee'));
app.use("/img", express.static(__dirname + '/img'));
server.listen(3001);
app.get('/', function(req, res) { res.sendfile("./html/splash.html")});
require('./socket_server')(io, people, activity);





