# frozen_string_literal: true

# Class for the color combination players can choose
# 6 available colors included in array, 4 slots for
# choice.
# combination will be stored as a string, e.g.
# 'rbyg' 'wbgb'
class Code
  attr_reader :code

  COLORS = %w[r b y g w v].freeze
  # code - string of player input
  # random - bool, true if computer generating
  # a code randomly
  def initialize(code)
    if code == 'random'
      new_code = ''
      4.times do
        new_code += COLORS.sample
      end
      @code = new_code
    else
      @code = code
    end
  end

  # returns true if player guess matches
  # the code
  def check_winner(guess)
    guess == @code
  end

  # returns the feedback based on a player
  # guess. indicates how many are right
  # and if any colors are correct but in
  # the wrong place
  def give_feedback(guess)
    guess.split('').each_with_index do |val, index|
      if val == @code[index]
        print 'M'
      elsif @code.split('').include?(val)
        print 'O'
      else
        print 'X'
      end
    end
    puts
  end
end

# Store data about the player
# including guesses and whether
# they are codebreaker or
# codemaster
class Player
  attr_reader :role, :guesses
  def initialize(role)
    @guesses = 12
    @role = role
  end

  # see if there are remaining guesses
  def guesses_left?
    @guesses.positive?
  end

  # take guess away from player
  def use_guess
    @guesses -= 1
  end
end

# prompt player for a valid 4 letter code
def prompt_for_valid_code
  colors = %w[r b y g w v]
  code = nil
  loop do
    puts 'Enter a valid code'
    code = gets.chomp
    next if code.length != 4
    return code if code.split('').all? { |char| colors.include?(char) }
  end
end

# MAIN
# take human players role
role = nil
loop do
  puts 'Codebreaker or Codemaster?'
  role = gets.chomp
  break if role == 'codebreaker' || role == 'codemaster'
end
player1 = Player.new(role)

# loop for player being CODEMASTER
if player1.role == 'codemaster'
  secret_code = Code.new(prompt_for_valid_code)
  computer = Player.new('codebreaker')
  loop do
    puts 'Time for the computer to guess'
    sleep(2)
    guess = Code.new('random').code
    puts "The computer guesses #{guess}"
    sleep(2)
    if secret_code.check_winner(guess)
      puts 'The computer has won, the singularity is upon us!'
      break
    end

    puts 'The computer recieves your feedback'
    secret_code.give_feedback(guess)
    sleep(2)
    computer.use_guess

    if computer.guesses.zero?
      puts 'The computer has run out of guesses, you win!'
      break
    end
    puts "The computer has #{computer.guesses} guesses left"
  end
end

# loop for player being CODEBREAKER
if player1.role == 'codebreaker'
  random_code = Code.new('random')
  loop do
    puts 'make your guess!'
    guess = prompt_for_valid_code
    if random_code.check_winner(guess)
      puts 'A winner is you!'
      break
    end

    random_code.give_feedback(guess)
    player1.use_guess
    if player1.guesses.zero?
      puts "You're out of guesses, Game Over!"
      break
    end

    puts "#{player1.guesses} guesses remaining"
  end
end
