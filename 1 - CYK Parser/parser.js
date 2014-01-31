// Get the grammar and lexicon rules for our parser in JSON format
var Grammar = function(path){
  this.rules = require(path).rules;
  this.ruleCount = this.rules.length;
}
var Lexicon = function(path){
  this.rules = require(path).rules;
  this.ruleCount = this.rules.length;
}
var grammar = new Grammar('./grammar.json');
var lexicon = new Lexicon('./lexicon.json');


// Get input sentences in JSON format
var sentences = require('./sentences.json');

var Sentence = function(sentence){
  this.string = sentence;
  this.words = this.string.split(" "); //array of words 
  this.wordCount = this.words.length;
}

var sentence = new Sentence(sentences[0]); //temporary hard code

// Outline our Tree Node Object
var TreeNode = function(){
  this.phrase;         // The non-terminal
  this.startPhrase;    // index of starting word
  this.endPhrase;      // index of ending word
  this.word;           // If a leaf, then the word
  this.right;
  this.left;
  this.prob;           // probability
}

var parse = function(sentence){
  // Initialize the array
  var P = [];
  var N = sentence.wordCount;
  for(var i = 0; i < N + 1; i++){
    word = sentence[i];
    for (var t = 0; t < lexicon.ruleCount; t++){
      var POS = lexicon.rules[t].pos;
      var word = lexicon.rules[t].word;
      P[POS][i][i] = new TreeNode(POS,i,i);
      console.log(POS);
    }
  }
}

// loop through all of our sentences and parse each
for (var i = 0; i < 1; i++){
  var sentence = new Sentence(sentences[i]);
  parse(sentence);
}