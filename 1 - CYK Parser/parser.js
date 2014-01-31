// Get command line args
process.argv.forEach(function (val, index, array) {
	console.log(index + ': ' + val);
});


// Outline our Tree Node Object

var Tree = function(){
	this.phrase;				//The non-terminal
	this.startPhrase;		// index of starting word
	this.endPhrase;			// index of ending word
	this.word;					// If a leaf, then the word
	this.right;					
	this.left;					
	this.prob; 					// probability
}


// Supporting methods
