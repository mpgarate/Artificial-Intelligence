// Get command line args
process.argv.forEach(function (val, index, array) {
  console.log(index + ': ' + val);
});

var RuleSet = function(grammar_path, lexicon_path){
  this.grammar = require(grammar_path);
  this.lexicon = require(lexicon_path);
}
rules = new RuleSet('./grammar.json', './lexicon.json');


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
console.log(rules.lexicon);
