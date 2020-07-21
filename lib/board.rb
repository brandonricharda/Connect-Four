class Board 

    attr_accessor :columns, :player, :computer, :rows

    def initialize
        @columns = {}
        @rows = {}
        @player = "X"
        @computer = "O"

        (0..6).to_a.each do |column|
            @columns[column] = Array.new(6, nil)
        end

        (0..5).to_a.each do |row|
            @rows[row] = Array.new(5, nil)
        end

    end

    def place_piece(column, symbol)
        return if !column || !(0..6).to_a.include?(column)
        avail_spot = nil
        #identifies whether the column is full
        full = @columns[column][0]
        #finds the last non-nil row in the chosen column (array), then adds the player's piece on top of it
        @columns[column].each_with_index do |row, index|
            break if avail_spot || full
            if row
                avail_spot = (index - 1)
            elsif index == @columns[column].length - 1
                avail_spot = index
            end
        end

        if avail_spot
            @columns[column][avail_spot] = symbol
            @rows[avail_spot][column] = symbol
            #returns the column index at which the new piece has been added
            @columns[column].index(symbol)            
        end

    end

    def computer_move
        column = nil
        until place_piece(column, @computer)
            column = rand(0..6)
        end
        column
    end

    def human_move
        p "Choose a column (0-6)."
        column = gets.chomp
        until column.match?(/^[0-9]/) && place_piece(column.to_i, @player)
            p "Please enter a number between 0 and 6 to represent a column that is not full."
            column = gets.chomp
        end
        column.to_i
    end

    def full?
        moves = []
        @columns.each do |key, column|
            column.each do |cell|
                moves << cell
            end
        end
        moves.all? { |value| value }
    end

    def display
        @rows.values.each do |row|
            p row
        end
    end

    def collect_moves(symbol)
        coordinates = []
        @rows.each do |key, value|
            value.each_with_index do |piece, index|
                coordinates << [key, index] if piece == symbol
            end
        end
        coordinates
    end

    def analyze_moves(moves)
        rows = []
        cols = []
        result = false

        def all_equal?(arr)
            arr.uniq.length == 1
        end

        def four_apart?(arr)
            (arr[3] - arr[0]).abs == 3
        end

        moves.each do |coordinates|
            rows << coordinates[0]
            cols << coordinates[1]
        end

        if all_equal?(rows) || all_equal?(cols)
            result = true if four_apart?(rows) || four_apart?(cols)
        elsif four_apart?(rows) && four_apart?(cols)
            result = true
        end

        result

    end

    def winner?
        analyze_moves(collect_moves(@player))
    end

end

test = Board.new