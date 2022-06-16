class Board
  attr_reader :computer_code

  def initialize(computer_code)
    @computer_code = computer_code
    @player_guesses = nil
    @key_pegs = nil
  end
end

class Computer 
  attr_reader :computer_code

  COLORS = ["Red", "Blu", "Grn", "Ylw", "Pur", "Org"]

  def initialize
    @computer_code = []
  end

  def choose_code
    for i in 1..4
      color = COLORS.sample
      @computer_code << color
    end
    puts computer_code
  end
end

computer = Computer.new
computer.choose_code
computer.computer_code