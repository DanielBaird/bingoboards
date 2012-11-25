bingoboards
===========

A little tool to make bingo boards easily.

Installing and running:

    $ git clone git://github.com/DanielBaird/bingoboards.git
    
    $ cd bingoboards
    $ ruby bingo.rb -h
    Usage: bingo [options]
        -b, --boards <BOARDS>            Specify how many boards you want (default 3)
        -s, --size <SIZE>                Specify size of each board (default 5)
        -h, --help                       show this help screen
    $ ruby bingo.rb -s3 -b2
    
    2 boards of size 3x3, no ties:
    (use -h to see how to change settings)
    
      9    6    5  
      8    4    3  
      7    2    1  
      
      4    8    2  
      6    7    5  
      9    1    3
       
      $