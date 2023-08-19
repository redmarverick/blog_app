require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should validate presence of name" do
    user = User.new
    assert_not user.save, "Saved user without a name"
  end

  test "should validate posts_counter is greater than or equal to 0" do
    user = User.new(name: "John", posts_counter: -1)
    assert_not user.save, "Saved user with posts_counter less than 0"
  end
end
