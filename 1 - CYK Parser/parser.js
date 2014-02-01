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
var TreeNode = function(POS, start, end, word, right, left, prob){
  this.phrase = POS;         // The non-terminal
  this.startPhrase = start;    // index of starting word
  this.endPhrase = end;      // index of ending word
  this.word = word;           // If a leaf, then the word
  this.right = right;
  this.left = left;
  this.prob = prob;           // probability
}

// Create an object to handle the multiarray
var MultiArray = function(){
  this.initialize = function(POS,i){
    if (this[POS] === undefined){
      this[POS] = [];
    }
    if (this[POS][i] === undefined){
      this[POS][i] = [];
    }
  }
}

// Parse a sentence to a tree 
var parse = function(sentence){
  // Initialize the array
  var P = new MultiArray(new Array(new Array()));
  var N = sentence.wordCount;
  for(var i = 0; i < N + 1; i++){
    word = sentence[i];
    for (var t = 0; t < lexicon.ruleCount; t++){
      var POS = lexicon.rules[t].pos;
      var word = lexicon.rules[t].word;
      var prob = lexicon.rules[t].weight;
      P.initialize(POS,i);
      P[POS][i][i] = new TreeNode(POS,i,i,word,null,null,prob);
      console.log(P[POS][i][i]);
    }
  }
}

// loop through all of our sentences and parse each
for (var i = 0; i < 1; i++){
  var sentence = new Sentence(sentences[i]);
  parse(sentence);
}