Naive Bayes Text Classifier
=======================

### Usage



```sh
ruby classify_bios.rb [n] [path] -v
```

`n` defaults to `5`

`path` defaults to `corpus.txt`.

The verbose flag toggles printing a word probability chart similar to the one provided: http://www.cs.nyu.edu/faculty/davise/ai/tinyChart.txt

### Examples:

Run on the tiny corpus with sample size 5.

```sh
ruby classify_bios.rb 5 test/corpora/tinyCorpus.txt
```


Run with verbose output on the tiny corpus with sample size 5. 

```sh
ruby classify_bios.rb 5 test/corpora/tinyCorpus.txt -v
```

Run on the larger corpus with sample size 5. 

```sh
ruby classify_bios.rb 5 test/corpora/bioCorpus.txt
```

Run on the larger corpus with sample size 10. 

```sh
ruby classify_bios.rb 10 test/corpora/bioCorpus.txt
```

