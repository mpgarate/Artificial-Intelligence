Naive Bayes Text Classifier
=======================

Biography classifyer using Naive Bayes, written in Ruby. 

### Usage



```sh
ruby classify_bios.rb [n] [path] -v
```

`n` defaults to `5`

`path` defaults to `corpus.txt`.

The verbose flag toggles printing a word probability chart similar to the one provided: http://www.cs.nyu.edu/faculty/davise/ai/tinyChart.txt

### Examples:

Run on the **tiny corpus** with sample size **5**.

```sh
ruby classify_bios.rb 5 test/corpora/tinyCorpus.txt
```


Run on the **tiny corpus** with sample size **5** with **verbose** output. 

```sh
ruby classify_bios.rb 5 test/corpora/tinyCorpus.txt -v
```

Run on the **larger corpus** with sample size **5**. 

```sh
ruby classify_bios.rb 5 test/corpora/bioCorpus.txt
```

Run on the **larger corpus** with sample size **10**. 

```sh
ruby classify_bios.rb 10 test/corpora/bioCorpus.txt
```

### Structural Overview

```classify_bios.rb``` is the command line interface for ```BioClassifier```.


```BioClassifier``` uses ```InputFileParser``` to generate ```Biography``` objects.

Each bio up to ```n``` is passed into an instance of ```NaiveBayesClassifier``` for learning.

Each bio after ```n``` is passed into an instance of ```NaiveBayesClassifier``` for classification. 

A ```Classification``` object is returned, which keeps information beyond the best match. For example, this class can produce runnerups and original probabilities.

### Under the Hood

```NaiveBayesClassifier``` uses hashes to maintain information about the learned words and categories. Probabilities are calculated from these on the fly during classification. 


I have made an effort to keep ```NaiveBayesClassifier``` not tied to the biography problem.

The corpus file is not read into memory all at once, rather done incrementally, line by line, as each bio is learned or classsified. 
