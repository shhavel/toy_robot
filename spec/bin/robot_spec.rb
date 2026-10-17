require "open3"

RSpec.describe "bin/robot" do
  shared_examples "executes commands" do |scenario, expected_output|
    it "executes #{scenario} and outputs #{expected_output.inspect}" do
      commands = File.read(File.expand_path("../fixtures/commands/#{scenario}.txt", __dir__))
      stdout, stderr, status = Open3.capture3(
        File.expand_path("../../bin/robot", __dir__), stdin_data: commands
      )

      expect(stdout).to eq(expected_output)
      expect(stderr).to be_empty
      expect(status).to be_success
    end
  end

  include_examples "executes commands", "basic_movement", "0,1,NORTH\n"
  include_examples "executes commands", "rotation", "0,0,WEST\n"
  include_examples "executes commands", "complex_movement", "3,3,NORTH\n"
end
