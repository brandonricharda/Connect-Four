class Board 

    attr_accessor :spaces

    def initialize
        cols = (0..6).to_a
        @spaces = {}

        cols.each do |item|
            spaces[item] = Array.new(6, nil)
        end

    end

    def place_piece(column)
        spot = nil
        #finds the last non-nil row in the chosen column, then adds the player's piece on top of it
        @spaces[column].each_with_index do |row, index|
            if row
                spot = (index - 1)
            elsif index == @spaces[column].length - 1
                spot = index
            end
        end
        @spaces[column][spot] = "X"
        #returns the index at which the new piece has been added
        @spaces[column].index("X")
    end

end

test = Board.new
test.place_piece(0)
test.place_piece(0)