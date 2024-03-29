// server.js

// BASE SETUP
// =============================================================================

// call the packages we need
const express = require('express');        // call express
const fileUpload = require('express-fileupload'); // call fileUpload
const bodyParser = require('body-parser'); // call body=parser
const mkdirp = require('mkdirp'); // call mkdirp
const uuid = require('uuid'); // call uuid

const app = express(); // define our app using express

app.use(fileUpload()); // use fileUpload()

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// create path to save uploaded fasta QS files
mkdirp('uploads/', function(err) { 
    // path exists unless there was an error
	if(err)
		console.log('Error creating path uploads/');
});

var port = process.env.PORT || 3000;        // set our port

// ROUTES FOR OUR API
// =============================================================================
var router = express.Router();              // get an instance of the express Router

// middleware to use for all requests
router.use(function(req, res, next) {
    // do logging
    console.log('Something is happening.');
    next(); // make sure we go to the next routes and don't stop here
});

// test route to make sure everything is working (accessed at GET http://localhost:3000/api)
router.get('/', function(req, res) {
    res.json({ message: 'Welcome to the EPA-ng API' });   
});

// Get available trees in server (accessed at GET http://localhost:3000/api/trees)
router.get('/trees', function(req, res) {
	var util = require('util'),
    exec = require('child_process').exec,
    child;

	child = exec('/bin/bash scripts/get-trees-list.sh',
  		function (error, stdout, stderr) {     
    		console.log('stdout: ' + stdout);
    		if (error !== null) {
      			console.log('exec error: ' + error);
    		} else {
				res.json({ trees: stdout.split(",") });			
			}
		});  
});

// POST uploading a file
// use form-data with key='qs' and value=[FILE TO UPLOAD]
router.post('/upload-qs', function(req, res) {
	if (!req.files)
    	return res.status(400).send('No files were uploaded.');  
  
	var querySequencesFile = req.files.qs;
	console.log(querySequencesFile.name + " uploaded.");

	var randomCode = uuid.v4();
	var fileNameArr = querySequencesFile.name.split(".");	
	var fileName = fileNameArr[0];
	var fileExtension = fileNameArr[1];
	var fileStoredName = fileName + "+" + randomCode + "." + fileExtension;

	querySequencesFile.mv("uploads/" + fileStoredName, function(err) {
    	if (err)
      		return res.status(500).send(err);
 
		res.json({ token: randomCode });
    	res.send('File uploaded!');
	});
});

// GET /api/analysis-text-result?tree=[treeName]&qs=[UUID]  <-- URL
// for example: http://localhost:3000/api/analysis-text-result?tree=Animals&qs=a725f87f-c3c1-4c31-858e-be2a83924acb
router.get('/analysis-text-result', function(req, res) {
    var tree = req.query.tree; // name of the tree to be used
    var storedQSUUID = req.query.qs; // uuid of the QS file previously uploaded

	var util = require('util'),
    exec = require('child_process').exec,
    child;

	child = exec('/bin/bash scripts/run-epa.sh ' + storedQSUUID + " " + tree,
  		function (error, stdout, stderr) {     
    		if (error !== null) {
      			console.log('Exec error: ' + error);
    		} else {
				// retrieve result -> send text result
				res.sendfile('results/' + storedQSUUID + '/epa_result.jplace')		
			}
		});

});

// GET /api/analysis-graphical-result?tree=[treeName]&qs=[UUID]&graphicType[type]  <-- URL
// for example: http://localhost:3000/api/analysis-graphical-result?tree=Animals&qs=a725f87f-c3c1-4c31-858e-be2a83924acb&graphicType=circular
router.get('/analysis-graphical-result', function(req, res) {
    var tree = req.query.tree; // name of the tree to be used
    var storedQSUUID = req.query.qs; // uuid of the QS file previously uploaded
	var graphicType	= req.query.graphicType; // type of graphic: horizontal (default), vertical or circular

	var util = require('util'),
    exec = require('child_process').exec,
    child;

	child = exec('/bin/bash scripts/run-epa.sh ' + storedQSUUID + " " + tree,
  		function (error, stdout, stderr) {     
    		if (error !== null) {
      			console.log('Exec error: ' + error);
    		} else {
				// retrieve result -> send graphical result
				var fileName = "horizontal-tree.png"

				if (graphicType != null) {
					switch (graphicType) {
						case "vertical":
							fileName = "vertical-tree.png"
							break;
						case "circular":
							fileName = "circular-tree.png"
							break;
						default:
							fileName = "horizontal-tree.png"
					}
				}

				res.sendfile('results/' + storedQSUUID + '/' + fileName)
			}
		});

});

// REGISTER OUR ROUTES -------------------------------
// all of our routes will be prefixed with /api
app.use('/api', router);

// START THE SERVER
// =============================================================================
app.listen(port);
console.log('EPA-ng Web Server working on port ' + port)
