require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "saves with valid attributes" do
    user = User.new(
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    assert user.save
  end

  def setup
    @user1 = users(:user1)
    @user2 = users(:user2)
  end

  test "validates email presence" do
    @user1.email = nil

    assert_not @user1.valid?
  end

  test "validates email uniquesness" do
    @user1.email = @user2.email

    assert_not @user1.valid?
  end

  test "should follow leader" do
    @user1.follow!(@user2)

    assert_equal 1, @user1.leaders.count
    assert_equal 1, @user2.followers.count
  end

  test "following? should be true" do
    @user1.follow!(@user2)

    assert @user1.following?(@user2)
  end
end
