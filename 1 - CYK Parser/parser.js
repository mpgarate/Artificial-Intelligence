// Get the grammar and lexicon rules for our parser in JSON format

var grammar = require('./grammar.json');
var lexicon = require('./lexicon.json');


// Get input sentences in JSON format
var sentences = require('./sentences.json');

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
    if (tree === null) return;
    var spaces = indent;
    while(spaces > 0){
      process.stdout.write(" ");
      spaces--;
    }
    console.log(tree.phrase);
    if (tree.word != null) console.log(tree.word);
    printTree(tree.left, indent+3);
    printTree(tree.right, indent+3);
  }

  this.print = function(){
    printTree(this,0);
    console.log("");
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

  this.getProb = function(POS, i, j){
    if(this[POS] === undefined){
      return 0;
    }
    else if (this[POS][i] === undefined){
      return 0;
    }
    else if (this[POS][i][j] === undefined){
      return 0;
    }
    else{
      return this[POS][i][j].prob;
    }
  }
}

// Parse a sentence to a tree 
var parse = function(sentence){
  // Initialize the array
  var P = new MultiArray();
  var N = sentence.length;
  for(var i = 0; i < N; i++){
    word = sentence[i];
    for (var t = 0; t < lexicon.rules.length; t++){
      var POS = lexicon.rules[t].pos;
      var lex_word = lexicon.rules[t].word;
      var prob = lexicon.rules[t].weight;
      if (word === lex_word){
        P.initialize(POS,i);
        P[POS][i][i] = new TreeNode(POS,i,i,word,null,null,prob);
        //P[POS][i][i].print();
      }
    }
  }


  // Evaluate probabilities

  // Vary the phrase length 
  for(var length = 2; length < N; length++){

    // Set start and end of phrase by current length
    for(var i = 0; i < N - length; i++){
      var j = i + length - 1;

      // Loop through NonTerms in sentence
      for(var p = 0; p < grammar.nonterms.length; p++){
        var M = grammar.nonterms[p];
        P.initialize(M,i);
        P[M][i][j] = new TreeNode(M, i, j, null, null, null, 0);
        // Loop through words in subphrase
        for(var k = i; k < j; k++){

          // Visit possible rules for current nonterm
          for(var t = 0; t < grammar[M].length; t++){
            var prob = grammar[M][t].weight;
            var children = grammar[M][t].sequence.split(" ");
            var Y = children[0];
            var Z = children[1]; 
            var PYik_prob = P.getProb(Y,i,k);
            var PZk1j_prob = P.getProb(Z,k+1,j);

            console.log(PYik_prob + "*" + PZk1j_prob + "*" + prob);
            var newProb = PYik_prob * PZk1j_prob * prob;
            //console.log("newProb: " + newProb);
            if (newProb > P[M][i][j].prob) {
              console.log("----in the if----");
              P[M][i][j].left = P[Y][i][k];
              P[M][i][j].right = P[Z][k+1][j];
              P[M][i][j].prob = newProb;
              console.log("[" + M + "][" + i + "][" + j + "] prob: " + newProb);

            }
          }
        }
      }
    }
  }
  //console.log(P["S"][0][2]);
  //P["S"][0][2].print();
}

// loop through all of our sentences and parse each
var sentence = sentences[0].toLowerCase().split(" ");
parse(sentence);