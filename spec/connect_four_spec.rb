require "./lib/board.rb"
require "./lib/game.rb"

describe Board do

    it "produces a board with seven columns" do
        test = Board.new
        expect(test.columns.length).to eql(7)
    end

    it "produces a board with seven rows" do
        test = Board.new
        expect(test.columns[1].length).to eql(6)
    end

    describe "#place_piece" do
        it "adds a piece to the last available row of a given column" do
            test = Board.new
            expect(test.place_piece(1, test.player)).to eql(5)
            expect(test.place_piece(1, test.player)).to eql(4)
            expect(test.place_piece(1, test.player)).to eql(3)
            expect(test.place_piece(1, test.player)).to eql(2)
            expect(test.place_piece(1, test.player)).to eql(1)
            expect(test.place_piece(1, test.player)).to eql(0)
        end

        it "returns nil when a column is full" do
            test = Board.new
            expect(test.place_piece(1, test.player)).to eql(5)
            expect(test.place_piece(1, test.player)).to eql(4)
            expect(test.place_piece(1, test.player)).to eql(3)
            expect(test.place_piece(1, test.player)).to eql(2)
            expect(test.place_piece(1, test.player)).to eql(1)
            expect(test.place_piece(1, test.player)).to eql(0)
            expect(test.place_piece(1, test.player)).to eql(nil)
        end
    end

    describe "#computer_move" do
        it "makes a move for the computer" do
            test = Board.new
            expect(test.computer_move).to be_between(0, 6)
        end
    end

    describe "#human_move" do
        it "makes a move for the player" do
            test = Board.new
            expect(test.human_move).to be_between(0, 6)
        end
    end

    describe "#full?" do
        it "identifies when a board is full" do
            test = Board.new
            42.times { test.computer_move }
            expect(test.full?).to eql(true)
        end

        it "identifies when a board is not full" do
            test = Board.new
            41.times { test.computer_move }
            expect(test.full?).to eql(false)
        end

        describe "#winner?" do
            it "identifies when someone has won column-wise" do
                test = Board.new
                4.times { test.place_piece(0, test.player) }
                expect(test.winner?).to eql(test.player)
            end

            it "identifies when someone has won row-wise" do
                test = Board.new
                0.upto(4) { |num| test.place_piece(num, test.player) }
                expect(test.winner?).to eql(test.player)
            end

        end
    end

end

describe Game do

    it "assigns Board to the right variable" do
        test = Game.new
        expect(test.board.class).to eql(Board)
    end

end