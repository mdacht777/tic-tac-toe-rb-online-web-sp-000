# Define your play method below
def play(board)
  counter=1
  while counter<=9 && !over?(board) && !draw?(board)
    turn(board)
    counter=counter+1
  end
  if draw?(board)
    puts "Cat's Game!"
  end
  if won?(board)
    puts "Congratulations X!"
    puts "Congratulations O!"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(input)
  input.to_i-1
end

def move(board,index,char)
  board[index]=char
end

# code your #valid_move? method here
def valid_move?(board,index)
  index.between?(0, 8) && !position_taken?(board,index)   
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player=current_player(board)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
WIN_COMBINATIONS.each do |win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
 
  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3
  if (position_1 == "X" || position_1== "O") && position_2 == position_1 && position_3 == position_1
    return win_combination # return the win_combination indexes that won.
  end
end
return false
end

def full?(board)
board.each do |value|
  #puts value
  if value==" "
    return false
  end
end
return true
end

def draw?(board)
  if won?(board)
    return false
  else
      if !full?(board)
        return false
      end  
  end
  return true
end

def over?(board)
#  puts full?(board)
#  puts won?(board)
  if won?(board) && full?(board)
    return true
  end
  if !full?(board)
    if won?(board)
      return true
    else
      return false
    end
  end
  if draw?(board)
    return true
  end
  return false
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def turn_count(board)
  counter=0;
  board.each{|position|
    if position=="X" || position=="O"
      counter+=1
    end
  }
  counter
end

def current_player(board)
  player="O"
  if turn_count(board) % 2 == 0
    player="X"
  end
  return player
end


