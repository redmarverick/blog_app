require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should validate presence of title" do
    post = Post.new
    assert_not post.save, "Saved post without a title"
  end

  test "should validate length of title is at most 250" do
    post = Post.new(title: "A" * 251)
    assert_not post.save, "Saved post with title longer than 250 characters"
  end

  test "should validate comments_counter is greater than or equal to 0" do
    post = Post.new(title: "Hello", comments_counter: -1)
    assert_not post.save, "Saved post with comments_counter less than 0"
  end

  test "should validate likes_counter is greater than or equal to 0" do
    post = Post.new(title: "Hello", likes_counter: -1)
    assert_not post.save, "Saved post with likes_counter less than 0"
  end
end
