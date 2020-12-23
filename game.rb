require 'colorize'

# Init methods for setup game

def set_name_player
  system('clear')
  puts ' Ingrese el nombre del jugador: '
  gets.chomp
end

def set_number_columns
  system('clear')
  puts ' Ingrese el numero de columnas que tendra el tablero: '
  puts ' NOTA: El número minimo de columnas para el tablero debe ser de 5.'.colorize(:green)

  number_columns = gets.chomp.to_i

  while number_columns <= 4
    system('clear')
    puts ' Instrucción no valida'.colorize(:red)
    puts
    puts ' Ingrese el numero de columnas que tendra el tablero: '
    puts ' NOTA: El número minimo de columnas para el tablero debe ser de 5.'.colorize(:red)

    number_columns = gets.chomp.to_i
  end

  number_columns
end

def set_number_rabbits(number_columns)
  system('clear')
  puts ' Ingrese el numero de conejos conlos que jugará: '
  puts ' NOTAS:'.colorize(:green)
  puts ' 1) El número minimo de conejos para el tablero debe ser de 2.'.colorize(:green)
  puts " 2) El número maximo de conejos para el tablero debe ser de #{number_columns}.".colorize(:green)

  number_rabbits = gets.chomp.to_i

  while number_rabbits <= 1 || number_rabbits > number_columns
    system('clear')
    puts ' Ingrese el numero de columnas que tendra el tablero: '
    puts ' NOTAS:'.colorize(:red)
    puts ' 1) El número minimo de conejos para el tablero debe ser de 2.'.colorize(:red)
    puts " 2) El número maximo de conejos para el tablero debe ser de #{number_columns}.".colorize(:red)

    number_rabbits = gets.chomp.to_i
  end

  number_rabbits
end

def set_number_foxs(number_columns)
  max_number_foxs = number_columns - 2

  system('clear')
  puts ' Ingrese el numero de conejos conlos que jugará: '
  puts ' NOTAS:'.colorize(:green)
  puts ' 1) El número minimo de zorros para el tablero debe ser de 1.'.colorize(:green)
  puts " 2) El número maximo de zorros para el tablero debe ser de #{max_number_foxs}.".colorize(:green)

  number_foxs = gets.chomp.to_i

  while number_foxs < 1 || number_foxs > number_columns
    system('clear')
    puts ' Ingrese el numero de columnas que tendra el tablero: '
    puts ' NOTAS:'.colorize(:red)
    puts ' 1) El número minimo de zorros para el tablero debe ser de 1.'.colorize(:red)
    puts " 2) El número maximo de zorros para el tablero debe ser de #{max_number_foxs}.".colorize(:red)

    number_foxs = gets.chomp.to_i
  end

  number_foxs
end

def build_board(number_columns)
  board = []

  for y in (0..14)
    board[y] = []
    for x in (0..number_columns - 1)
      board[y][x] = '| |'
    end
  end

  board
end

def available_position?(collection, position)
  available = true
  counter = collection.length - 1

  while available && counter >= 0 do
    if collection[counter][0][0] == position[0] &&
      collection[counter][0][1] == position[1]
      available = false
    end

    counter -= 1
  end

  available
end

def order_collection(collection)
  for i in 0...collection.length do
    min = i
 
    for j in (i + 1)...collection.length do
      if collection[j][0][1] <= collection[min][0][1]
        min = j
      end
    end
  
    aux = collection[i]
    collection[i] = collection[min]
    collection[min] = aux
  end

  collection
end

def build_rabbit_collection(number_columns, number_rabbits)
  collection = []
  num_females = number_rabbits / 2

  loop do
    sex = num_females > 0 ? '|♂|' : '|♀|'

    position = [0, rand(number_columns)]

    if available_position?(collection, position)
      num_females -= 1 if num_females > 0
      number_rabbits -= 1
      collection << [position, sex]
    end

    break if number_rabbits == 0
  end

  order_collection(collection)
end

def build_fox_collection(number_columns, number_foxs)
  collection = []

  loop do
    position = [14, rand(number_columns)]

    if available_position?(collection, position)
      number_foxs -= 1
      collection << [ position, '|z|', 0 ]
    end

    break if number_foxs == 0
  end

  order_collection(collection)
end

# End methods for setup game


# Init methods for show game

def print_final_message(name_player, win)
  if win
    puts " #{name_player} you won".colorize(:cyan)
  else
    puts " #{name_player} you lost".colorize(:light_red)
  end
  puts
end

def leyend
  puts ' Leyend: '
  puts " #{'♂'.colorize(:light_red)}  - Female rabbit"
  puts " #{'♀'.colorize(:blue)}  - Male rabbit"
  puts " #{'z'.colorize(:yellow)}  - Fox"
  puts " #{'x'.colorize(:red)}  - Dead rabbit"
  puts " #{'✝'.colorize(:red)}  - Dead rabbit and fox doind digestion"
  puts
end

def user_winner?(rabbit_collection)
  counter = rabbit_collection.length - 1

  win = false

  # rabbits alive
  female = 0
  male = 0

  loop do
    if rabbit_collection[counter][1] != '|x|' &&
      rabbit_collection[counter][0][0] == 14

      rabbit_collection[counter][1] == '|♂|' ? female += 1 : male += 1
    end

    win = female > 0 && male > 0

    counter -= 1

    break if win || counter < 0
  end

  win
end

def print_board(board, rabbit_collection, fox_collection, finish_game)
  system('clear')

  puts ' ========================================================================= '
  puts ' ============================ Foxs vs Rabbits ============================ '
  puts
  puts

  for y in 0..board.length - 1
    for x in 0..board[y].length - 1
      print "  #{print_tokken([y, x], fox_collection, rabbit_collection, finish_game)} "
    end
    puts
  end

  puts
  puts " ================================== Farm ================================== ".colorize(:green)
  puts ' ========================================================================== '.colorize(:green)
  puts
end

def print_options_player()
  puts ' Options: '
  puts ' Move down  - ↓'
  puts ' Move left  - ←'
  puts ' Move right - →'
  puts
  puts ' q - Quit game'
  puts
end

# End methods for show game

def setup_game
  name_player = set_name_player
  number_columns = set_number_columns
  number_rabbits = set_number_rabbits(number_columns)
  number_foxs =  set_number_foxs(number_columns)

  board = build_board(number_columns)
  rabbit_collection = build_rabbit_collection(number_columns, number_rabbits)
  fox_collection = build_fox_collection(number_columns, number_foxs)


  [ board, name_player, number_columns, rabbit_collection, fox_collection ]
end

def search_tokken_with_position(collection, position)
  counter = collection.length - 1
  tokken = nil

  loop do
    if collection[counter][0][0] == position[0] &&
      collection[counter][0][1] == position[1]
      tokken = collection[counter]
    end

    counter -= 1

    break if tokken || counter < 0
  end

  tokken
end

# Refactor
def print_tokken(position, fox_collection, rabbit_collection, finish_game)
  rabbit = search_tokken_with_position(rabbit_collection, position)
  fox = search_tokken_with_position(fox_collection, position)

  if rabbit && finish_game
    if rabbit && fox
      fox[1].colorize(:red)
    elsif rabbit[1] == '|♂|'
      rabbit[1].colorize(:light_red)
    elsif rabbit[1] == '|♀|'
      rabbit[1].colorize(:blue)
    else
      rabbit[1].colorize(:red)
    end
  elsif rabbit && !finish_game && rabbit[1] != '|x|'
    rabbit[1] == '|♂|' ? rabbit[1].colorize(:light_red) : rabbit[1].colorize(:blue)
  elsif fox
    fox[1] == '|✝|' ? fox[1].colorize(:red) : fox[1].colorize(:yellow)
  else
    '| |'
  end
end

def show_game(board, name_player, rabbit_collection, fox_collection, finish_game)
  print_board(board, rabbit_collection, fox_collection, finish_game)

  if finish_game
    win = user_winner?(rabbit_collection)

    leyend
    print_final_message(name_player, win)
  else
    leyend
    print_options_player
  end
end

def keypressed
  system("stty raw -echo")
  key = STDIN.getc
  system("stty -raw echo")
  key.ord
end

def user_movement
  key_valid = false
  value = nil

  loop do
    key = keypressed

    case key
    when 113
      key_valid = true
      value = 'quit'
    when 68
      key_valid = true
      value = 'left'
    when 67
      key_valid = true
      value = 'right'
    when 66
      key_valid = true
      value = 'down'
    end

    break if key_valid
  end

  value
end

def move_rabbits_left(rabbit_collection)
  for i in 0...rabbit_collection.length do
    position_y = rabbit_collection[i][0][0]
    new_position_x = rabbit_collection[i][0][1] - 1

    rabbit = search_tokken_with_position(rabbit_collection, [position_y, new_position_x])

    if rabbit_collection[i][0][1] > 0 &&
      rabbit_collection[i][1] != '|x|' &&
      (!rabbit || rabbit[1] == '|x|')

      rabbit_collection[i][0][1] = new_position_x
    end
  end

  rabbit_collection
end

def move_rabbits_right(number_columns, rabbit_collection)
  counter = rabbit_collection.length - 1

  for i in 0...rabbit_collection.length do
    position_y = rabbit_collection[counter - i][0][0]
    new_position_x = rabbit_collection[counter - i][0][1] + 1
    rabbit = search_tokken_with_position(rabbit_collection, [position_y, new_position_x])

    if rabbit_collection[counter - i][0][1] < number_columns - 1 &&
      rabbit_collection[counter - i][1] != '|x|' &&
      (!rabbit || rabbit[1] == '|x|')

      rabbit_collection[counter - i][0][1] = new_position_x
    end
  end

  rabbit_collection
end

def move_donw_rabbits(rabbit_collection)
  for i in 0...rabbit_collection.length do
    if rabbit_collection[i][0][0] < 14 &&
      rabbit_collection[i][1] != '|x|'

      rabbit_collection[i][0][0] = rabbit_collection[i][0][0] + 1
    end
  end

  rabbit_collection
end

def handle_move_rabbits(move, number_columns, rabbit_collection)
  if move == 'left'
    move_rabbits_left(rabbit_collection)
  elsif move == 'right'
    move_rabbits_right(number_columns, rabbit_collection)
  else
    move_donw_rabbits(rabbit_collection)
  end
end

def handle_move_fox(fox_collection)
  for i in 0...fox_collection.length do
    if fox_collection[i][0][0] > 0
      if fox_collection[i][2] > 0
        fox_collection[i][2] -= 1
      else
        fox_collection[i][0][0] = fox_collection[i][0][0] - 1
        fox_collection[i][1] = '|z|' #hack
      end
    end
  end

  fox_collection
end

def validate_deads(fox_collection, rabbit_collection)
  counter_rabbit = rabbit_collection.length - 1

  loop do
    counter_fox = fox_collection.length - 1

    while rabbit_collection[counter_rabbit][1] != '|x|' && counter_fox >= 0  do
      if rabbit_collection[counter_rabbit][0][0] == fox_collection[counter_fox][0][0] &&
        rabbit_collection[counter_rabbit][0][1] == fox_collection[counter_fox][0][1]

        rabbit_collection[counter_rabbit][1] = '|x|'
        fox_collection[counter_fox][2] += 1
        fox_collection[counter_fox][1] = '|✝|'
      end

      counter_fox -= 1
    end

    break if counter_rabbit == 0

    counter_rabbit -= 1
  end

  [ fox_collection, rabbit_collection ]
end

def end_game?(rabbit_collection)
  counter = rabbit_collection.length - 1
  continue_game = false

  # rabbits alive
  female = 0
  male = 0

  # # rabbits alive without reaching the goal
  playing = 0

  loop do
    if rabbit_collection[counter][1] != '|x|'
      if rabbit_collection[counter][1] == '|♂|'
        female += 1
      else
        male += 1
      end

      playing += 1 if rabbit_collection[counter][0][0] < 14
    end

    continue_game = female > 0 && male > 0 && playing > 0

    counter -= 1

    break if continue_game || counter < 0
  end

  !continue_game
end

def new_round(move_rabbit, number_columns, fox_collection, rabbit_collection)
  rabbit_collection = handle_move_rabbits(move_rabbit, number_columns, rabbit_collection)

  fox_collection, rabbit_collection = validate_deads(fox_collection, rabbit_collection)

  finish_game = end_game?(rabbit_collection)

  unless finish_game
    fox_collection = handle_move_fox(fox_collection)

    fox_collection, rabbit_collection = validate_deads(fox_collection, rabbit_collection)

    finish_game = end_game?(rabbit_collection)
  end

  [ finish_game, fox_collection, rabbit_collection ]
end

def start
  finish_game = false

  # setup_game return = board, name_player, number_columns, rabbit_collection, fox_collection
  board, name_player, number_columns, rabbit_collection, fox_collection = setup_game

  show_game(board, name_player, rabbit_collection, fox_collection, finish_game)

  loop do
    move_selected = user_movement

    if move_selected == 'quit'
      finish_game = true
    else
      finish_game, fox_collection, rabbit_collection = new_round(move_selected, number_columns, fox_collection, rabbit_collection)
    end

    show_game(board, name_player, rabbit_collection, fox_collection, finish_game)

    break if finish_game
  end
end

start
