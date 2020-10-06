# Class for the color combination players can choose
# 6 available colors included in array, 4 slots for
# choice.
# combination will be stored as a string, e.g.
# 'rbyg' 'wbgb'
class Code
  COLORS = %w[r b y g w b].freeze
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
end

secret = Code.new('random')
p secret