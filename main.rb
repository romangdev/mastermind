module PlayerNeeds
  COLORS = ["R", "B", "G", "Y", "P", "O"]
end

class Player
  def initialize
    @codemaker_code =[]
  end
end

class Board
  attr_reader :codemaker_code, :codebreaker_guesses, :key_peg_returns

  def initialize(codemaker_code)
    @codemaker_code = codemaker_code
    @codebreaker_guesses = []
    @key_peg_returns = []
  end

  def compare_guess(codebreaker)
   result = (@codemaker_code == codebreaker.code_guess) ? true : false
   result
  end

  def save_guess(codebreaker_guess)
    @codebreaker_guesses << codebreaker_guess.code_guess
  end
end

class Computer < Player
  attr_reader :codemaker_code, :key_pegs

  include PlayerNeeds

  def initialize
    super
  end

  # pick a random color combination 
  def choose_code
    for i in 1..4
      color = COLORS.sample
      @codemaker_code << color
    end
  end

  # provide feedback on the player's guess
  def guess_feedback(codebreaker, board)
    codemaker_arr = []
    codemaker_arr.replace(@codemaker_code)
    codebreaker_arr = []
    codebreaker_arr.replace(codebreaker.code_guess)
    @key_pegs = []
    @color_totals = self.tally_colors

    # first check equivalent color AND indexes at SAME TIME. Replace with nil
    for i in 0..3
      if codemaker_arr[i] == codebreaker_arr[i]
        @key_pegs << "B"
        codemaker_arr[i] = nil
        codebreaker_arr[i] = nil
      end
    end

    # delete nil values from both code and code guess arrays
    codemaker_arr.map do 
      |element|
      if element == nil
        codemaker_arr.delete(nil)
      end
    end
    codebreaker_arr.map do 
      |element|
      if element == nil
        codebreaker_arr.delete(nil)
      end
    end

    # now for remaining values, check for equivalent colors that do not
    # share same index
    codemaker_arr.each_with_index do
      |code_element, code_idx|
      codebreaker_arr.each_with_index do
        |guess_element, guess_idx|
        if code_element == guess_element
          if code_element == nil
            next
          else
            @key_pegs << "W"
            codemaker_arr[code_idx] = nil
            code_element = nil
            codebreaker_arr[guess_idx] = nil
            guess_element = nil
            next
          end
        end
      end
    end

    # fill up unused slots in key pegs with nil
    if @key_pegs.length != 4
      remaining_space = 4 - @key_pegs.length 
      for j in 1..remaining_space
        @key_pegs << nil
      end
    else
      @key_pegs
    end

    board.key_peg_returns << @key_pegs
    @key_pegs
  end

  # Used as a method to help in #guess_check
  def tally_colors
    @codemaker_code.reduce(Hash.new(0)) do
      |total, color|
      if total[color] == nil
        total[color] = 0
      else 
        total[color] += 1
      end
      total
    end
  end
end

class Human < Player
  attr_reader :code_guess, :maker_or_breaker

  include PlayerNeeds

  def initialize
    super
    @code_guess = []
    @maker_or_breaker = nil
    @codemaker_code = []
  end

  def make_or_break
    puts "\nType \"M\" if you want to make the code."
    puts "Type \"B\" if you want to break the code:"

    @maker_or_breaker = gets.chomp.upcase
  end

  def make_code
    puts "\nMake a code from the following colors (repeats are allowed):\n #{COLORS}\n\n"
    for i in 1..4
      begin
        puts "Enter color number #{i}:"
        color = gets.chomp.upcase
        if color != "R" && color != "B" && color != "G" && color != "Y" && color != "P" && color != "O" 
          raise "ERROR: Incorrect input"
        end
      rescue 
        puts "\nLooks like you've entered an incorrect input. Please try again.\n"
        retry
      else
        @codemaker_code << color
      end
    end
    puts "\nYou've made the following code: #{@codemaker_code}\n"
  end

  def get_code_guess
    puts "\nChoose from the following colors (repeats are allowed):"
    puts "R, B, G, Y, P, O\n"
    puts "\nFirst color?:"
    first_color = gets.chomp.upcase
    puts "Second color?:"
    second_color = gets.chomp.upcase
    puts "Third color?:"
    third_color = gets.chomp.upcase
    puts "Fourth color?:"
    fourth_color = gets.chomp.upcase
    @code_guess << first_color << second_color << third_color << fourth_color
  end
end

human_player = Human.new
choice = human_player.make_or_break

if choice == "M"
  puts "\nGreat! So you're a codeMAKER. Computer is a codeBREAKER.\n"
  human = Human.new
  human.make_code

elsif choice == "B"
  puts "\nGreat! So you're a codeBREAKER. Computer is a codeMAKER.\n"
  sleep 2
  puts "\nLet's begin!\n"
  sleep 1
  puts "\nComputer has chosen their code. Time for you to get guessin'...\n"
  sleep 2

  computer = Computer.new
  computer.choose_code

  board = Board.new(computer.codemaker_code)
  hash = computer.tally_colors

  result = nil
  turn = 1
  while result != true && turn <= 12
    human = Human.new
    human.get_code_guess

    result = board.compare_guess(human)
    board.save_guess(human)

    computer.guess_feedback(human, board)

    j = 1
    i = 0
    puts "\n--- Game Board -----------"
    board.codebreaker_guesses.each do
      |guess| 
      if j >= 10
        print "Guess ##{j}: #{guess} ==> #{board.key_peg_returns[i]}\n"
      else
        print "Guess ##{j}:  #{guess} ==> #{board.key_peg_returns[i]}\n"
      end
      j += 1
      i += 1
    end
    puts "--------------------------"

    if result == true
      puts "\nGame over! The codemaker has lost..."
      puts "CODEBREAKER WINS!\n\n"
    end

    turn += 1

    if turn > 12
      puts "\nGame over! The codebreaker has lost..."
      puts "CODEMAKER WINS!\n\n"
    end
  end
else
  puts "Looks like you didn't enter your choice correctly."
end