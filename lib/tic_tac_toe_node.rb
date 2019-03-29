require "byebug"
require_relative 'tic_tac_toe'

class TicTacToeNode

DELTAS = [
  [0,0], [0,1], [0,2],
  [1,0], [1,1], [1,2],
  [2,0], [2,1], [2,2]
]

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark, @prev_move_pos = next_mover_mark, prev_move_pos
  end

  def losing_node?(evaluator)
    # debugger 
    if board.over? 
      return board.won? && board.winner != evaluator 
    end 

    if self.next_mover_mark == evaluator 
      self.children.all? {|child| child.losing_node?(evaluator)}
    else 
      self.children.any? {|child| child.losing_node?(evaluator)} 
    end 
  end

  def winning_node?(evaluator)
    if board.over? 
      return board.winner == evaluator 
    end 

    if self.next_mover_mark == evaluator 
      self.children.any? {|child| child.winning_node?(evaluator)}
    else 
      self.children.all? {|child| child.winning_node?(evaluator)} 
    end 
  end

  def children
    new_positions = []
    mark = @next_mover_mark == :x ? :o : :x
      DELTAS.each do |pos|
        if @board.empty?(pos) 
          board_copy = board.dup
          board_copy[pos] = self.next_mover_mark
          square = TicTacToeNode.new(board_copy, mark, pos)
          new_positions.unshift(square)
        end 
      end 
    new_positions
  end 

    
end
