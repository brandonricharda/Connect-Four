require "./lib/board.rb"
require "./lib/player.rb"
require "./lib/game.rb"

describe Board do

    before do
        @board = Board.new
    end

    it "produces a board with seven columns" do
        expect(@board.columns.length).to eql(7)
    end

    it "produces a board with six rows" do
        expect(@board.rows.length).to eql(6)
    end

    describe "#available_spot" do

        it "finds the available spot in a given column" do
            expect(@board.available_spot(0)).to eql(5)
        end

    end

    describe "#place_piece" do

        it "places a new piece where it should go" do
            expect(@board.place_piece(0, "piece")).to eql("piece")
        end

        it "returns nil when you attempt to add a piece in a full column" do
            6.times { @board.place_piece(0, "piece") }
            expect(@board.place_piece(0, "piece")).to eql(nil)
        end

        it "ignores an invalid entry" do
            expect(@board.place_piece("A", "piece")).to eql(nil)
        end

    end

    describe "#linear_check" do

        it "identifies when a winning move has occurred vertically" do
            4.times { @board.place_piece(0, "X") }
            expect(@board.linear_check(@board.columns)).to eql(true)
        end

        it "identifies when a winning move has occurred horizontally" do
            0.upto(3) { |num| @board.place_piece(num, "X") }
            expect(@board.linear_check(@board.rows)).to eql(true)
        end

        it "recognizes that four consecutive nil does not count as a win" do
            expect(@board.linear_check(@board.rows)).to eql(false)
        end

    end

    describe "#move_list" do

        it "updates a player's list of moves" do
            @board.place_piece(0, "X")
            expect(@board.moves["X"]).to eql([[5], [0]])
        end

    end

    describe "#diagonal_check" do

        it "identifies when a winning move has occurred diagonally" do
            0.upto(3) do |num|
                num.times { @board.place_piece(num, "O") }
                @board.place_piece(num, "X")
            end
            expect(@board.diagonal_check).to eql(true)
        end

    end

    describe "#full?" do

        it "returns false when the board is not full" do
            expect(@board.full?).to eql(false)
        end

    end

end

describe Human do

    before do
        @human = Human.new("X")
    end

    describe "#select_move" do

        it "returns an integer" do
            expect(@human.select_move.class).to eql(Integer)
        end

        it "returns an integer between 0 and 6" do
            expect(@human.select_move).to be_between(0, 6)
        end

    end

end

describe Computer do

    before do
        @computer = Computer.new("O")
    end

    describe "#select_move" do

        it "returns an integer between 0 and 6" do
            expect(@computer.select_move).to be_between(0, 6)
        end

    end

end

describe Game do

    before do
        @game = Game.new
    end

    describe "#check_winner" do

        it "returns false if there is no winner" do
            expect(@game.check_winner).to eql(false)
        end

        it "returns true if there is a winner" do
            4.times { @game.board.place_piece(0, "X") }
            expect(@game.check_winner).to eql(true)
        end

    end

    describe "#player_turn" do

        it "always eventually returns a valid move" do
            expect(@game.player_turn).to be_between(0, 6)
        end

    end

    describe "#computer_turn" do

        it "always eventually returns a valid move" do
            expect(@game.computer_turn).to be_between(0, 6)
        end

    end

end