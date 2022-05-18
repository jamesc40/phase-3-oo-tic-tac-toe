require 'pry'

class TicTacToe
  attr_reader :board, :WIN_COMBINATIONS, :display_board
  def initialize
    #@board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    @board = []
    9.times do |i|
      @board << ' '
    end
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts '-----------'
    puts " #{@board[3]} | #{@board[4]} | #{board[5]} "
    puts '-----------'
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(string)
    string.to_i - 1
  end

  def move(index, token = 'X')
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != ' '
  end

  def valid_move?(position)
    (0..8).include?(position) && !self.position_taken?(position)
  end

  def turn_count
    count = 0
    self.board.each do |val|
      val != ' ' ? count += 1 : nil
    end
    count
  end

  def current_player
    turn_count.even? ? 'X' : 'O'
  end

  def turn
    puts 'input a number between 1 - 9' 
    number = gets.chomp
    index = input_to_index(number)
    if(self.valid_move?(index))
      move(index, self.current_player)
      self.display_board
    else turn
    end
  end

  def won?
    WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
        return combo
      end
    end
  end 

  def full?
    self.board.length == self.turn_count 
  end

  def draw?
    self.full? && !self.won?
  end

  def over? 
    self.won? || self.draw?
  end

  def winner
    if(won?)
      (self.turn_count - 1).even? ? 'X' : 'O'
    else nil
    end
  end

  def play
    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end
end

