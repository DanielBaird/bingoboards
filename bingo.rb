
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
        '-i', '--images <IMAGE_DIR>', 'Specify a directory of image files (sets output to html, overriding -o)'
    ) { |i| $image_dir = i }

    opts.on(
        '-p', '--urlprefix <PREFIX>', 'used with -i, links to images will be prefixed with this path (default \'.\''
    ) { |p| $image_prefix = p }

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

$image_dir = nil       unless $image_dir && File.directory?($image_dir)
$image_prefix = ''     unless $image_prefix && $image_prefix.is_a?(String)

# overrides..
$output_format = :html if $image_dir

$symbol_count = $size * $size

# if they gave us an image dir, get a list of files from there
if $image_dir
    $image_files = Dir.new($image_dir).entries.select do |img|
        File.file? File.join($image_dir, img) and img != '.DS_Store'
    end
    if $image_files.length < ($size * $size)
        puts "Sorry, not enough images in directory '#{$image_dir}' (need #{$size * $size}+, found #{$image_files.length})"
        exit 1
    end
    $symbol_count = $image_files.length
end

# get the boards.  show progress if they asked for text.
boards = BingoBoard.make_boards $num_boards, $size, [*(1..$symbol_count)], ($output_format == :text)

if $output_format == :text
    puts "\n#{$num_boards} boards of size #{$size}x#{$size}, no ties:\n(use -h to see how to change settings)"
    boards.each do |b|
        b.show
    end

elsif $output_format == :html
    output = []
    output << "\n<!-- #{$num_boards} boards of size #{$size}x#{$size}, no ties -->\n"

    boards.each do |b|
        output << "<h1>Baby Bingo</h1>"
        output << "<h2>at Michelle's Baby Shower</h2>"
        output << '<div class="bingoboard-wrapper"><table class="bingoboard">'
        output << "\n"
        $size.times do |row|
            output << '<tr>'
            $size.times do |col|
                if $image_dir
                    img_file = $image_files[b.cell(row, col)-1]
                    output << "<td><img src=\"#{$image_prefix}/#{img_file}\"></td>"
                else
                    output << "<td>#{b.cell(row, col)}</td>"
                end
            end
            output << "</tr>"
        end
        output << '</table></div>'
    end

    if $image_files
        output << '<div class="cards-wrapper">'
        $image_files.each_with_index do |image_file, index|
            output << '<hr>' if index % 9 == 0
            image_name = File.basename(image_file)[0..-5].gsub(/(-|_|\.)/, " ")
            output << "<div class='card'><img src='#{$image_prefix}/#{image_file}'><div class='caption'>#{image_name}</div></div>"
        end
        output << '</div>'
    end

    puts output.join ""
end

