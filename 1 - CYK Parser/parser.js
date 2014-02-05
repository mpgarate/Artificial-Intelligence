// Get the grammar and lexicon rules for our parser in JSON format
var Grammar = function(path){
  this.contents = require(path);
  this.rules = this.contents.rules;
}
var Lexicon = function(path){
  this.contents = require(path);
  this.rules = this.contents.rules;
  this.parts_of_speech = this.contents.parts_of_speech;
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

//var P[S,1,N] = new Sentence(sentences[0]); //temporary hard code

// Outline our Tree Node Object
var TreeNode = function(POS, start, end, word, right, left, prob){
  this.phrase = POS;         // The non-terminal
  this.startPhrase = start;    // index of starting word
  this.endPhrase = end;      // index of ending word
  this.word = word;           // If a leaf, then the word
  this.right = right;
  this.left = left;
  this.prob = prob;           // probability

  var printTree = function(tree, indent){
    var space = " ";
    if (tree != null) {
      console.log(space.repeat(indent));
      console.log(tree.phrase);
      if (tree.word != null) console.log(tree.word);
      printTree(tree.left, indent+3);
      printTree(tree.right, indent+3);
    }
  }

  this.print = function(){
    printTree(this[S,1,N],0);
  }
}

// Create an object to handle the multiarray
// The first level can be used like a hash
// POS is a string, ie 'Noun', which is a key
var MultiArray = function(){
  this.initialize = function(POS,i){
    if (this[POS] === undefined){
      this[POS] = [];
    }
    if (this[POS][i] === undefined){
      this[POS][i] = [];
    }
    //if (j !== undefined && this[POS][i][j] === undefined ){
    //  this[POS][i][j] = new TreeNode(POS, i, j, null, null, null, 0);
    //}
  }
}

// Parse a sentence to a tree 
var parse = function(sentence){
  // Initialize the array
  var P = new MultiArray();
  var N = sentence.wordCount;
  for(var i = 1; i < N; i++){
    word = sentence[i];
    for (var t = 0; t < lexicon.rules.length; t++){
      var POS = lexicon.rules[t].pos;
      var word = lexicon.rules[t].word;
      var prob = lexicon.rules[t].weight;
      P.initialize(POS,i);
      P[POS][i][i] = new TreeNode(POS,i,i,word,null,null,prob);
    }
  }

  // Evaluate probabilities
  for(var length = 2; length < N; length++){
    for(var i = 1; i < N + 1 - length; i++){
      var j = i + length - 1;
      for(var p = 0; p < lexicon.parts_of_speech.length; p++){
        var M = lexicon.parts_of_speech[p];
        P[M][i][j] = new TreeNode(M, i, j, null, null, null, 0);  
        for(var k = i; k < j-1; k++){
          for(var t = 0; t < grammar.rules.length; t++){
            var children = grammar.rules[t].sequence.split(" ");
            var Y = children[0];
            var Z = children[1];
            var newProb = P[Y][i][k].prob * P[Z][k+1][j].prob * prob;
            if (newProb > P[M][i][j].prob) {
              P[M][i][j].left = P[Y][i][k];
              P[M][i][j].right = P[Z][k+1][j];
              P[M][i][j].prob = newProb;
            }
          }
        }
      }
    }
  }
  console.log(P);
}

// loop through all of our sentences and parse each
for (var i = 0; i < 1; i++){
  var sentence = new Sentence(sentences[i]);
  parse(sentence);
}