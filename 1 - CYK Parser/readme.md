CYK Parser
=======================
CYK Parser for a provided context-free grammar and lexicon written in Javascript. 


### Usage ###
Store sentences in JSON format in the file ```sentences.json```.

Run ```parser.js``` with Node.js from the terminal

```sh
$ node parser.js
```

The parser will draw from ```grammar.json``` and ```lexicon.json``` to build the most probable parse tree. This tree is then printed with its probability. If a sentence cannot be parsed, an error message is printed. 

### Example Sentences ###
1. Fish swim in streams
2. Fish in streams swim
3. Amy ate fish for dinner
4. Amy ate fish for dinner on Tuesday
5. Amy ate for (Should output "This sentence cannot be parsed").

Sentences formatted in JSON: 

```json
[
  "Fish swim in streams",
  "Fish in streams swim",
  "Amy ate fish for dinner",
  "Amy ate fish for dinner on Tuesday",
  "Amy ate for"
]
```

This produces the following output:

```
----- sentence: 1 -----
S
   Noun fish
   VPWithPPList
      Verb swim
      PP
         Prep in
         Noun streams
probability = 0.0000216 (2.16e-5)

----- sentence: 2 -----
S
   NP
      Noun fish
      PP
         Prep in
         Noun streams
   Verb swim
probability = 0.0001152 (1.152e-4)

----- sentence: 3 -----
S
   Noun amy
   VerbAndObject
      Verb ate
      NP
         Noun fish
         PP
            Prep for
            Noun dinner
probability = 0.0001008 (1.008e-4)

----- sentence: 4 -----
S
   Noun amy
   VerbAndObject
      Verb ate
      NP
         Noun fish
         PP
            Prep for
            NP
               Noun dinner
               PP
                  Prep on
                  Noun tuesday
probability = 0.00000129024 (1.29024e-6)

----- sentence: 5 -----
This sentence cannot be parsed

```
