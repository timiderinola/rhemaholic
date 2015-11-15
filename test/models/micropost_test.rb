require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:oladoyin)
    # This code is not idiomatically correct.
    @micropost = @user.microposts.build(content: "lorem ipsum")
  end

  test "micropost should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal Micropost.first, microposts(:most_recent)
  end

  test "content should be present " do
    @micropost.content = " "
    assert_not @micropost.valid?
  end

  test "content should be at most 160 characters" do
    @micropost.content = "a" * 161
    assert_not @micropost.valid?
  end
end
