class Board

    attr_accessor :columns, :rows, :moves

    def initialize
        @columns = {}
        @rows = {}
        @moves = {}
        (0..6).to_a.each { |value| @columns[value] = Array.new(6, nil) }
        (0..5).to_a.each { |value| @rows[value] = Array.new(7, nil) }
    end

    def available_spot(entry)
        return if !(0..6).to_a.include?(entry)
        @columns[entry].rindex(nil)
    end

    def place_piece(column, symbol)
        spot = available_spot(column)
        return if !spot
        move_list(spot, column, symbol)
        @columns[column][spot] = symbol
        @rows[spot][column] = symbol
    end

    def move_list(row, column, symbol)
        @moves[symbol] = [[], []] if !moves[symbol]
        @moves[symbol][0] << row
        @moves[symbol][1] << column
    end

    def linear_check(hash)
        #checks to see if any consecutive four moves in a column or row are a single player's
        hash.values.any? { |arr| arr.each_cons(4).any? { |four| four.none? { |value| !value } && four.uniq.size == 1 } }
    end

    def diagonal_check
        result = []
        comparison = []
        #for each player...
        @moves.each do |player, dimension|
            break if dimension.all? { |arr| arr.length < 4 }
            #evaluate the moves in the dimension (row/column, depending on which loop) to see if there is a set of four consecutive moves...
            dimension.each { |arr| arr.each_cons(4) { |four| comparison << four } }
            #that are numerically consecutive within the dimension as well – add that boolean to the result array
            result << comparison.any? { |arr| arr.each_cons(2).all? { |first, second| second == first + 1 || second == first - 1 } }
            #reset comparison array to prepare for testing the next player if needed
            comparison = []
        end
        #if both of the booleans in the results array are true, that means there is a column + row pair with four consecutive values each (diagonal win)
        !result.empty? && result.all? { |boolean| boolean }
    end

    def display
        @rows.values.each { |row| p row }
    end

    def full?
        @rows.values.all? { |row| row.all? { |boolean| boolean } }
    end

end

# test = Board.new
# 0.upto(3) do |num|
#     num.times { test.place_piece(num, "O") }
#     test.place_piece(num, "X")
# end
# p test.diagonal_check