// server.js

// BASE SETUP
// =============================================================================

// call the packages we need
const express    = require('express');        // call express
const fileUpload = require('express-fileupload');
const app        = express();                 // define our app using express
const bodyParser = require('body-parser');

// use fileUpload()
app.use(fileUpload());

// configure app to use bodyParser()
// this will let us get the data from a POST
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

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

// test route to make sure everything is working (accessed at GET http://localhost:8080/api)
router.get('/', function(req, res) {
    res.json({ message: 'hooray! welcome to our api!' });   
});

// Get available trees in server (accessed at GET http://localhost:8080/api/trees)
// TODO get real list of stored trees in server
router.get('/trees', function(req, res) {
    res.json({ trees: ['insects', 'bacteries', 'mamals'] });   
});

// POST uploading a file
router.post('/upload-qs', function(req, res) {
	if (!req.files)
    	return res.status(400).send('No files were uploaded.');  
  
	var querySequencesFile = req.files.qs;
	console.log(querySequencesFile.name + " uploaded.");

	querySequencesFile.mv("uploads/" + querySequencesFile.name, function(err) {
    	if (err)
      		return res.status(500).send(err);
 
    	res.send('File uploaded!');
	});
});

// GET http://localhost:8080/api/phylogenetic?tree=insects&qs=file.fasta  <-- URL
router.get('/phylogenetic', function(req, res) {
    var tree = req.query.tree; // name of the tree to be used
    var querySequencesFileName = req.query.qs; // name of the QS file previously uploaded

	// TODO execute scripts and get JSON result
	// var jsonResult = ...
	// res.json(jsonResult);
    res.json({ tree: 'Here we should retrieve the result tree.' });
	//res.send('Response send to client with JSON file');
});

// REGISTER OUR ROUTES -------------------------------
// all of our routes will be prefixed with /api
app.use('/api', router);

// START THE SERVER
// =============================================================================
app.listen(port);
console.log('Magic happens on port ' + port)
