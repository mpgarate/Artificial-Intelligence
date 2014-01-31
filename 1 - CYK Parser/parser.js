// Get command line args
process.argv.forEach(function (val, index, array) {
  console.log(index + ': ' + val);
});

// Get the grammar and lexicon rules for our parser in JSON format
var RuleSet = function(path){
  this.contents = require(path);
}

grammar = new RuleSet('./grammar.json');
lexicon = new RuleSet('./lexicon.json');


// Get input sentences in JSON format
var SentenceSet = function(path){
  this.contents = require(path);
}

sentences = new SentenceSet('./sentences.json');


// Outline our Tree Node Object
var Tree = function(){
  this.phrase;         // The non-terminal
  this.startPhrase;    // index of starting word
  this.endPhrase;      // index of ending word
  this.word;           // If a leaf, then the word
  this.right;
  this.left;
  this.prob;           // probability
}


// Supporting methods

/*
var i;
for(i = 0; i< 1; i++){
  console.log(grammar.S[i]);
}
*/
console.log(sentences);
