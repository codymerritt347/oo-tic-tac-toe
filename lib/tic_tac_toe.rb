require "pry"
class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(position)
    @board[position] == " " ? false : true
  end

  def valid_move?(index)
    if index.between?(0,8) && !position_taken?(index)
      true
    else
      false
    end
  end

  def turn_count
    @board.count {|x| x == "X" || x == "O"}
  end

  def current_player
    turn_count
    if turn_count % 2 == 0 || turn_count == 0
      "X"
    else
      "O"
    end
  end

  def turn
    puts "Pick a number between 1 and 9."
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      until valid_move?(index) do
        puts "Sorry, invalid number. Try again."
        input = gets.chomp
        index = input_to_index(input)
      end
      move(index, current_player)
      display_board
    end
  end

  def won?
    WIN_COMBINATIONS.each do |single_win_combo|
      win_index_1 = single_win_combo[0]
      win_index_2 = single_win_combo[1]
      win_index_3 = single_win_combo[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if position_1 == position_2 && position_2 == position_3 && position_taken?(win_index_1)
        return single_win_combo
      end
    end
    false
  end

  def full?
    if @board.any? {|index| index == nil || index == " "}
      false
    else
      if !won?
        true
      end
    end
  end

  def draw?
    full? && !won? ? true : false
  end

  def over?
    full? || won? ? true : false
  end

  def winner
    if won?
      @board[won?[0]]
    end
  end

  def play
    turn until over?
  end

end