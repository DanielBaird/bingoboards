
require 'optparse'
require './bingoboard'

# parse command line options
OptionParser.new do |opts|
    opts.on(
        '-o', '--output html or text', 'Specify output format, text (default), or html'
    ) { |f| $output_format = f.to_sym }

    opts.on(
        '-b', '--boards <BOARDS>', 'Specify how many boards you want (default 3)'
    ) { |b| $num_boards = b.to_i }

    opts.on(
        '-s', '--size <SIZE>', 'Specify size of each board (default 5)'
    ) { |b| $size = b.to_i }

    opts.on('-h', '--help', 'show this help screen') { puts opts; exit }

    opts.parse!
end

# defaults
$num_boards = 3        unless $num_boards.is_a?(Numeric) && $num_boards > 0
$size = 5              unless $size.is_a?(Numeric) && $size > 1
$output_format = :text unless [:text, :html].include? $output_format

# get the boards.  show progress if they asked for text.
boards = BingoBoard.make_boards $num_boards, $size, nil, ($output_format == :text)

case $output_format

    when :text
        puts "\n#{$num_boards} boards of size #{$size}x#{$size}, no ties:\n(use -h to see how to change settings)"
        boards.each do |b|
            b.show
        end

    when :html
        output = []
        output << "\n<!-- #{$num_boards} boards of size #{$size}x#{$size}, no ties -->\n"
        boards.each do |b|
            output << '<table class="bingoboard">'
            output << "\n"
            $size.times do |row|
                output << '<tr> '
                $size.times do |col|
                    output << "<td>#{b.cell(row, col)}</td> "
                end
                output << "</tr>\n"
            end
            output << '</table>'
        end
        puts output.join ""
end



