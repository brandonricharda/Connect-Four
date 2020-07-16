require "./lib/board.rb"

describe Board do

    it "produces a board with seven columns" do
        test = Board.new
        expect(test.spaces.length).to eql(7)
    end

    it "produces a board with seven rows" do
        test = Board.new
        expect(test.spaces[1].length).to eql(6)
    end

    describe "#place_piece" do
        it "adds a piece to the last available row of a given column" do
            test = Board.new
            expect(test.place_piece(1)).to eql(5)
            expect(test.place_piece(1)).to eql(4)
        end
    end

end