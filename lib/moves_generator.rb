class MovesGenerator
  def self.generate_moves(board, side)
    moves = []
    board.pieces(side) do |piece|
      moves << piece.valid_moves(board)
    end
  end
end