# frozen_string_literal: true

require_relative "table"

class Robot
  DX = [1, 0, -1, 0].freeze
  DY = [0, 1, 0, -1].freeze
  DIRECTIONS = %w[EAST NORTH WEST SOUTH].freeze

  def execute(command)
    if (m = command.match(/\APLACE (?<x>\d+),(?<y>\d+),(?<direction>NORTH|EAST|SOUTH|WEST)\z/))
      place(m[:x].to_i, m[:y].to_i, m[:direction])
    elsif placed?
      case command
      when "MOVE"
        move
      when "LEFT"
        rotate_left
      when "RIGHT"
        rotate_right
      when "REPORT"
        puts "#{@x},#{@y},#{DIRECTIONS[@dir]}"
      end
    end
  end

  private

  def place(x, y, direction = nil)
    if Table.on_table?(x, y)
      @x = x
      @y = y
      @dir = DIRECTIONS.index(direction) if direction
    end
  end

  def placed?
    !@x.nil? && !@y.nil? && !@dir.nil?
  end

  def move
    x = @x + DX[@dir]
    y = @y + DY[@dir]
    place(x, y)
  end

  def rotate_left
    @dir = (@dir + 1) % 4
  end

  def rotate_right
    @dir = (@dir - 1) % 4
  end
end
