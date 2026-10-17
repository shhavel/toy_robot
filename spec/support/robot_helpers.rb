module RobotHelpers
  def place(x_y_direction)
    robot.execute("PLACE #{x_y_direction}")
  end

  def move
    robot.execute("MOVE")
  end

  def left
    robot.execute("LEFT")
  end

  def right
    robot.execute("RIGHT")
  end

  def report
    robot.execute("REPORT")
  end

  def expect_position(expected_position)
    expect { report }.to output("#{expected_position}\n").to_stdout
  end
  alias_method :expect_report, :expect_position

  def expect_not_placed
    expect { report }.not_to output.to_stdout
  end
  alias_method :expect_empty_report, :expect_not_placed
end
