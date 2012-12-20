cp htmlhead.html test.html && ruby bingo.rb -s5 -b20 -i ./babypics/ -p babypics >> test.html && cat htmlfoot.html >> test.html && open test.html
