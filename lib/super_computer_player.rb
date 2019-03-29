# require "colorize"
require "byebug"
require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    node.children.shuffle.each do |child|
      if child.winning_node?(mark) && node.children
        return child.prev_move_pos
      end 
    end 
    non_losing_node(node, mark)  
  end

  def non_losing_node(node, mark)
    node.children.each do |child|
      if !child.losing_node?(mark) && node.children 
        return child.prev_move_pos
      end 
    end 
    raise "Should be a non-losing node"
  end 
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
