require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:oladoyin)
    @other_user = users(:oladele)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should redirect edit when not logged in" do
  #   logout
  #   get :edit, id: @user
  #   assert_redirected_to signin_url
  # end

  # test "should redirect update when not logged in" do
  #   logout
  #   patch :update, id: @user, user: { name: @user.name, email: @user.email }
  #   assert_redirected_to signin_url
  # end

  # test "should redirect edit when logged in as wrong user" do
  #   log_in_as(@other_user)
  #   get :edit, id: @user
  #   assert_redirected_to @user
  # end

  # test "should redirect update when logged in as wrong user" do
  #   log_in_as(@other_user)
  #   patch :update, id: @user, user: { name: @user.name, email: @user.email }
  #   assert_redirected_to @user
  # end
end