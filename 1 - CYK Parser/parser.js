/*
 *  CYK Parser
 *  Michael Garate
 *  February 2014
 *  
 */

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
    var printSpaces = function (count) {
        while (count > 0) {
            process.stdout.write(" ");
            count--;
        }
    };

    // Pre-order tree print 
    var printTree = function (tree, indent) {
        if (tree === null) {
            return;
        }
        printSpaces(indent);
        process.stdout.write(tree.phrase);
        if (tree.word !== null) {
            console.log(" " + tree.word);
        } else {
            console.log("");
        }
        printTree(tree.left, indent + 3);
        printTree(tree.right, indent + 3);
    };

    // Begin the tree print
    this.print = function () {
        if (this.prob > 0) {
            printTree(this, 0);

            // print probability rounding out floating point error margin
            var power = 10000000000000000;
            var rounded_prob = Math.round(this.prob * power) / power;
            console.log("probability = " + rounded_prob + " (" + rounded_prob.toExponential() + ")" );
            console.log("");
        } else {
            console.log("This sentence cannot be parsed");
        }
    };
};

// Create an object to handle the multiarray
// The first level can be used like a hash
// POS is a string, ie 'Noun', which is a key
var MultiArray = function () {

    // Create blank arrays for given indices
    this.initialize = function (POS, i) {
        if (this[POS] === undefined) {
            this[POS] = [];
        }
        if (this[POS][i] === undefined) {
            this[POS][i] = [];
        }
    };

    // Get the probability for a node or return
    // 0 if it is defined
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
    for (var h = 0; h < N; h++) {
        var word = sentence[h];
        for (var s = 0; s < lexicon.rules.length; s++) {
            var POS = lexicon.rules[s].pos;
            var lex_word = lexicon.rules[s].word;
            var prob = lexicon.rules[s].prob;
            if (word === lex_word) {
                P.initialize(POS, h);
                P[POS][h][h] = new TreeNode(POS, h, h, word, null, null, prob);
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

                        var probability = grammar[M][t].prob;

                        var children = grammar[M][t].sequence.split(" ");
                        var Y = children[0];
                        var Z = children[1];

                        var PYik_prob = P.getProb(Y, i, k);
                        var PZk1j_prob = P.getProb(Z, k + 1, j);

                        var newProb = PYik_prob * PZk1j_prob * probability;

                        if (newProb > P[M][i][j].prob) {
                            P[M][i][j].left = P[Y][i][k];
                            P[M][i][j].right = P[Z][k + 1][j];
                            P[M][i][j].prob = newProb;
                        }
                    }
                }
            }
        }
    }
    // Call print on the most probable parse
    P["S"][0][N - 1].print();
};

// loop through all of our sentences and parse each

for (var i = 0; i < sentences.length; i++) {

    if (sentences.length > 1) {
        console.log("----- sentence: " + (i + 1) + " -----");
    }

    var sentence = sentences[i].toLowerCase().split(" ");
    parse(sentence);
}