bingoboards
===========

A little tool to make bingo boards easily.  It will make you a set of bingo boards that guarantee no ties.

Installing:
```bash 
$ git clone git://github.com/DanielBaird/bingoboards.git
[... git does things ...]
$ cd bingoboards
$ ruby bingo.rb -h
Usage: bingo [options]
    -b, --boards <BOARDS>            Specify how many boards you want (default 3)
    -s, --size <SIZE>                Specify size of each board (default 5)
    -h, --help                       show this help screen
```

A simple example:
```bash
$ ruby bingo.rb --size 3 --boards 2

2 boards of size 3x3, no ties:
(use -h to see how to change settings)

 2  4  8 
 1  6  7 
 3  5  9 

 9  4  3 
 8  6  2 
 5  1  7
 ```




