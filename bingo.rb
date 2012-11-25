
require 'optparse'
require './bingoboard'

OptionParser.new do |opts|
    opts.on(
        '-b', '--boards <BOARDS>', 'Specify how many boards you want (default 3)'
    ) { |b| $num_boards = b.to_i }

    opts.on(
        '-s', '--size <SIZE>', 'Specify size of each board (default 5)'
    ) { |b| $size = b.to_i }

    opts.on('-h', '--help', 'show this help screen') { puts opts; exit }

    opts.parse!
end

$num_boards ||= 3
$size ||= 5

boards = BingoBoard.make_boards $num_boards, $size

puts "\n#{$num_boards} boards of size #{$size}x#{$size}, no ties:\n(use -h to see how to change settings)"
boards.each do |b|
    b.show
end


