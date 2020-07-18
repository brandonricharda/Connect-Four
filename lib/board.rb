class Board 

    attr_accessor :positions, :player, :computer

    def initialize
        @positions = {}
        @player = "X"
        @computer = "O"
        (0..6).to_a.each do |row|
            positions[row] = Array.new(6, nil)
        end
    end

    def place_piece(column, symbol)
        return if !column || !(0..6).include?(column)
        cell = nil
        #identifies whether the column is full
        full = @positions[column][0]
        #finds the last non-nil row in the chosen column (array), then adds the player's piece on top of it
        @positions[column].each_with_index do |row, index|
            break if cell || full
            if row
                cell = (index - 1)
            elsif index == @positions[column].length - 1
                cell = index
            end
        end

        if cell
            @positions[column][cell] = symbol
            #returns the index at which the new piece has been added
            @positions[column].index(symbol)            
        end

    end

    def computer_move
        col = nil
        until place_piece(col, @computer)
            col = rand(0..6)
        end
        col
    end

    def human_move
        p "Choose a column (0-6)."
        col = gets.chomp
        until col.match?(/^[0-9]/) && place_piece(col.to_i, @player)
            p "Please enter a number between 0 and 6 to represent a column that is not full."
            col = gets.chomp
        end
        col.to_i
    end

    def full?
        moves = []
        @positions.each do |key, value|
            value.each do |col|
                moves << col
            end
        end
        moves.all? { |value| value }
    end

    def display
        interface = {}
        (0..5).to_a.each do |row|
            interface[row] = Array.new
        end

        @positions.each do |key, col|
            col.each_with_index do |row, index|
                interface[index] << row
            end
        end

        interface.each do |key, row|
            p row
        end

    end

end

test = Board.new

until 1 == 2
    test.human_move
    test.display
end