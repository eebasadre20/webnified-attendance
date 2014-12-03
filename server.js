var express = require( "express" );
	talk    = express();

	talk.use( express.static( __dirname + '/materialize-attendance' ));


	talk.listen( 8082,function(request, response){
		console.log("listing");
	});