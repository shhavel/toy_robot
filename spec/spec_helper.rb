require_relative "../lib/robot"
require_relative "support/robot_helpers"

RSpec.configure do |config|
  config.include RobotHelpers, type: :robot
end
