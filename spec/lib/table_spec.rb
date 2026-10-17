RSpec.describe Table do
  describe ".on_table?" do
    it "accepts coordinates within the table boundaries" do
      should be_on_table(0, 0)
      should be_on_table(4, 4)
      should be_on_table(2, 3)
    end

    it "rejects coordinates outside the table boundaries" do
      should_not be_on_table(-1, 0)
      should_not be_on_table(0, -1)
      should_not be_on_table(5, 0)
      should_not be_on_table(0, 5)
    end
  end
end
