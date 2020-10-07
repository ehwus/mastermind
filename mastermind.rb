# Class for the color combination players can choose
# 6 available colors included in array, 4 slots for
# choice.
# combination will be stored as a string, e.g.
# 'rbyg' 'wbgb'
class Code
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

secret = Code.new('rryg')
secret.give_feedback('gggr')
p secret.check_winner('rryg')
