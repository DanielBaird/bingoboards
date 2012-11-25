
class BingoBoard
    # -----------------------------------------------------
    def self.make_boards(number, size = 5, symbols = nil)
        boards = []
        linepool = []

        while boards.length < number do

            new_board = BingoBoard.new size

            found_copy = false
            new_board.lines.each do |new_line|
                found_copy = true if linepool.include? new_line
            end

            if found_copy
            else
                linepool.concat new_board.lines
                boards << new_board
            end
        end

        boards
    end
    # -----------------------------------------------------
    def initialize(size, symbols = nil)

        # create or check the symbols array
        unless symbols
            symbols = *(1..(size*size))
        else
            raise "Not enough symbols to fill bingo board" if symbols.length < size * size
        end

        @size = size
        @symbols = symbols
        @board = []

        symbol_pool = @symbols.dup

        size.times do |row_index|
            row = []
            size.times do
                row << symbol_pool.shuffle!.pop
            end
            @board << row
        end
    end
    # -----------------------------------------------------
    def show
        puts ""
        @board.each do |row|
            row.each do |symbol|
                print symbol.to_s.center(5)
            end
            puts ""
        end
    end
    # -----------------------------------------------------
    def lines
        lines = []
        @size.times do |index|
            # add each row
            lines << @board[index].sort
            # add each column
            lines << @board.map { |row| row[index] }.sort
        end
        # add the two diagonals
        d1 = []
        d2 = []
        @size.times do |index|
            d1 << @board[index][index]
            d2 << @board[index][@size - index - 1]
        end
        lines << d1.sort
        lines << d2.sort

        lines.sort
    end
    # -----------------------------------------------------
end
