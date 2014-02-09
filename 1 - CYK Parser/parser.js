// Get the grammar and lexicon rules for our parser in JSON format

var grammar = require('./grammar.json');
var lexicon = require('./lexicon.json');


// Get input sentences in JSON format
var sentences = require('./sentences.json');

// Outline our Tree Node Object
var TreeNode = function (POS, start, end, word, right, left, prob) {
    this.phrase = POS; // The non-terminal
    this.startPhrase = start; // index of starting word
    this.endPhrase = end; // index of ending word
    this.word = word; // If a leaf, then the word
    this.right = right;
    this.left = left;
    this.prob = prob; // probability

    // Helper for spacing tree print output
    var printSpaces = function (count){
      while (count > 0) {
            process.stdout.write(" ");
            count--;
        }
    }

    // Pre-order tree print 
    var printTree = function (tree, indent) {
        if (tree === null) { return; }
        printSpaces(indent);        
        process.stdout.write(tree.phrase);
        if (tree.word !== null) {
            console.log(" " + tree.word);
        }
        else{
          console.log("");
        }
        printTree(tree.left, indent + 3);
        printTree(tree.right, indent + 3);
    };

    // Begin the tree print
    this.print = function () {
        if (this.prob > 0){
          console.log("probability: " + this.prob);
          printTree(this, 0);
          console.log(""); 
        }
        else{
          console.log("This sentence cannot be parsed");
        }
    };
};

// Create an object to handle the multiarray
// The first level can be used like a hash
// POS is a string, ie 'Noun', which is a key
var MultiArray = function () {
    this.initialize = function (POS, i) {
        if (this[POS] === undefined) {
            this[POS] = [];
        }
        if (this[POS][i] === undefined) {
            this[POS][i] = [];
        }
    };

    this.getProb = function (POS, i, j) {
        if (this[POS] === undefined) {
            return 0;
        } else if (this[POS][i] === undefined) {
            return 0;
        } else if (this[POS][i][j] === undefined) {
            return 0;
        } else {
            return this[POS][i][j].prob;
        }
    };
};

// Parse a sentence to a tree 
var parse = function (sentence) {
    // Initialize the array with sentence words
    var P = new MultiArray();
    var N = sentence.length;
    for (var i = 0; i < N; i++) {
        word = sentence[i];
        for (var t = 0; t < lexicon.rules.length; t++) {
            var POS = lexicon.rules[t].pos;
            var lex_word = lexicon.rules[t].word;
            var prob = lexicon.rules[t].prob;
            if (word === lex_word) {
                P.initialize(POS, i);
                P[POS][i][i] = new TreeNode(POS, i, i, word, null, null, prob);
                //console.log("POS:" + POS + " i:" + i);
                //P[POS][i][i].print();
            }
        }
    }


    // Evaluate probabilities

    // Vary the phrase length 
    for (var length = 2; length < N + 1; length++) {

        // Set start and end of phrase by current length
        for (var i = 0; i < N - length + 1; i++) {
            var j = i + length - 1;

            // Loop through NonTerms in grammar
            for (var p = 0; p < grammar.nonterms.length; p++) {

                var M = grammar.nonterms[p];
                P.initialize(M, i);
                P[M][i][j] = new TreeNode(M, i, j, null, null, null, 0);

                // Loop through words in subphrase
                for (var k = i; k < j; k++) {

                    // Visit possible rules for current nonterm
                    for (var t = 0; t < grammar[M].length; t++) {

                        var prob = grammar[M][t].prob;

                        var children = grammar[M][t].sequence.split(" ");
                        var Y = children[0];
                        var Z = children[1];

                        var PYik_prob = P.getProb(Y, i, k);
                        var PZk1j_prob = P.getProb(Z, k + 1, j);

                        //console.log(Y + " " + Z + " " + i + " " + (k+1));
                        //console.log(PYik_prob + "*" + PZk1j_prob + "*" + prob);
                        var newProb = PYik_prob * PZk1j_prob * prob;
                        //console.log("newProb: " + newProb);
                        if (newProb > P[M][i][j].prob) {
                            //console.log("FOUND BETTER PROB");
                            P[M][i][j].left = P[Y][i][k];
                            P[M][i][j].right = P[Z][k + 1][j];
                            P[M][i][j].prob = newProb;
                            //console.log("[" + M + "][" + i + "][" + j + "] prob: " + newProb);
                            //P[M][i][j].print();
                        }
                    }
                }
            }
        }
    }
    // Call print on the most probable parse
    P["S"][0][N-1].print();
}

// loop through all of our sentences and parse each

for (var i = 0; i < sentences.length; i++){
  console.log("----- sentence: " + i + " -----");
  var sentence = sentences[i].toLowerCase().split(" ");
  parse(sentence);  
}
