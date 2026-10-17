module Table
  MIN_X = 0
  MAX_X = 4
  MIN_Y = 0
  MAX_Y = 4

  def self.on_table?(x, y)
    x.between?(MIN_X, MAX_X) && y.between?(MIN_Y, MAX_Y)
  end
end
