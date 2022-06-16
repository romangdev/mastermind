class Board
  attr_reader :codemaker_code

  def initialize(codemaker_code)
    @codemaker_code = codemaker_code
    @codebreaker_guesses = []
    @key_pegs = nil
  end

  def compare_guess(codebreaker)
   result = (@codemaker_code == codebreaker.code_guess) ? true : false
   p result
   result
  end

  def save_guess(codebreaker_guess)
    @codebreaker_guesses << codebreaker_guess.code_guess
    p @codebreaker_guesses
  end
end

class Computer 
  attr_reader :computer_code

  COLORS = ["R", "B", "G", "Y", "P", "O"]

  def initialize
    @computer_code = []
  end

  def choose_code
    for i in 1..4
      color = COLORS.sample
      @computer_code << color
    end
  end
end

class Human
  attr_reader :code_guess

  def initialize
    @code_guess = []
  end

  def get_code_guess
    puts "First color?:"
    first_color = gets.chomp
    puts "Second color?:"
    second_color = gets.chomp
    puts "Third color?:"
    third_color = gets.chomp
    puts "Fourth color?:"
    fourth_color = gets.chomp
    @code_guess << first_color << second_color << third_color << fourth_color
    puts "\n#{@code_guess}"
  end
end

computer = Computer.new
computer.choose_code

board = Board.new(computer.computer_code)
puts board.codemaker_code

result = nil
turn = 1
while result != true && turn <= 12
  human = Human.new
  human.get_code_guess

  result = board.compare_guess(human)
  board.save_guess(human)
  turn += 1
end
