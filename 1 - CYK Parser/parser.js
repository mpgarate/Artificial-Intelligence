// Get command line args
process.argv.forEach(function (val, index, array) {
  console.log(index + ': ' + val);
});

// Get the grammar and lexicon rules for our parser in JSON format
var RuleSet = function(path){
  this.contents = require(path);
}

var grammar = new RuleSet('./grammar.json');
var lexicon = new RuleSet('./lexicon.json');


// Get input sentences in JSON format
var SentenceSet = function(path){
  this.contents = require(path);
}
var sentences = new SentenceSet('./sentences.json');

var Sentence = function(sentence){
  this.contents = sentence;
  this.words = this.contents.split(" "); //array of words 
  this.wordCount = this.words.length;
}

var sentence = new Sentence(sentences.contents[0]); //temporary hard code

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

console.log(sentence.wordCount);