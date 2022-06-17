class Board
  attr_reader :codemaker_code

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

class Computer 
  attr_reader :codemaker_code, :key_pegs

  COLORS = ["R", "B", "G", "Y", "P", "O"]

  def initialize
    @codemaker_code = []
  end

  def choose_code
    for i in 1..4
      color = COLORS.sample
      @codemaker_code << color
    end
  end

  def guess_feedback(codebreaker)
    @key_pegs = []
    @color_totals = self.tally_colors

    # first check equivalent color AND indexes at SAME TIME. Replace with nil
    for i in 0..3
      p "#{@codemaker_code[i]} and #{codebreaker.code_guess[i]}"
      if @codemaker_code[i] == codebreaker.code_guess[i]
        @key_pegs << "B"
        @codemaker_code[i] = nil
        codebreaker.code_guess[i] = nil
      end
    end

    @codemaker_code.delete(nil)
    codebreaker.code_guess.delete(nil)

    @codemaker_code.each_with_index do
      |code_element, code_idx|
      codebreaker.code_guess.each_with_index do
        |guess_element, guess_idx|

      end
    end

    # if @key_pegs.length != 4
    #   remaining_space = 4 - @key_pegs.length 
    #   for j in 1..remaining_space
    #     @key_pegs << nil
    #   end
    # else
    #   @key_pegs
    # end
  end

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

board = Board.new(computer.codemaker_code)
p board.codemaker_code
hash = computer.tally_colors

result = nil
turn = 1
while result != true && turn <= 12
  human = Human.new
  human.get_code_guess

  result = board.compare_guess(human)
  board.save_guess(human)
  turn += 1

  computer.guess_feedback(human)
  p computer.key_pegs
  p computer.codemaker_code
  p human.code_guess
end
