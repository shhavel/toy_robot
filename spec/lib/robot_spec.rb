RSpec.describe Robot, type: :robot do
  subject(:robot) { described_class.new }

  describe "Scenarios" do
    specify "Basic Movement" do
      place "0,0,NORTH"
      move
      expect_position "0,1,NORTH"
    end

    specify "Rotation" do
      place "0,0,NORTH"
      left
      expect_position "0,0,WEST"
    end

    specify "Complex Sequence" do
      place "1,2,EAST"
      move
      move
      left
      move
      expect_position "3,3,NORTH"
    end
  end

  describe "PLACE" do
    it "places the robot on the table" do
      place "2,3,WEST"
      expect_position "2,3,WEST"
    end

    it "ignores placement commands out of the table boundaries" do
      place "5,5,NORTH"
      expect_not_placed
    end

    it "ignores invalid placement commands" do
      place "2,0,NORTH,WEST"
      expect_not_placed
    end
  end

  describe "MOVE" do
    it "moves the robot forward" do
      place "2,2,WEST"
      move
      expect_position "1,2,WEST"
    end

    it "ignores move commands that would take the robot off the table" do
      place "0,0,SOUTH"
      move
      expect_position "0,0,SOUTH"

      place "0,2,WEST"
      move
      expect_position "0,2,WEST"
    end

    it "ignores move commands if not placed" do
      move
      expect_not_placed
    end
  end

  describe "LEFT" do
    it "rotates the robot to the left" do
      place "2,2,WEST"
      left
      expect_position "2,2,SOUTH"
    end

    it "rotates the robot facing SOUTH to the left" do
      place "2,2,SOUTH"
      left
      expect_position "2,2,EAST"
    end

    it "ignores LEFT commands if not placed" do
      left
      expect_not_placed
    end
  end

  describe "RIGHT" do
    it "rotates the robot to the right" do
      place "2,2,WEST"
      right
      expect_position "2,2,NORTH"
    end

    it "rotates the robot facing EAST to the right" do
      place "2,2,EAST"
      right
      expect_position "2,2,SOUTH"
    end

    it "ignores RIGHT commands if not placed" do
      right
      expect_not_placed
    end
  end

  describe "REPORT" do
    it "reports the robot's position" do
      place "2,3,EAST"
      expect_report "2,3,EAST"
    end

    it "ignores REPORT commands if not placed" do
      expect_empty_report
    end
  end

  describe "UNKNOWN COMMAND" do
    it "ignores unknown commands" do
      place "2,3,EAST"
      robot.execute("UNKNOWN")
      expect_position "2,3,EAST"
    end
  end
end
