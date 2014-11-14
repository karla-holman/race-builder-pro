require 'test_helper'

class LastWinsControllerTest < ActionController::TestCase
  setup do
    @last_win = last_wins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:last_wins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create last_win" do
    assert_difference('LastWin.count') do
      post :create, last_win: {  }
    end

    assert_redirected_to last_win_path(assigns(:last_win))
  end

  test "should show last_win" do
    get :show, id: @last_win
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @last_win
    assert_response :success
  end

  test "should update last_win" do
    patch :update, id: @last_win, last_win: {  }
    assert_redirected_to last_win_path(assigns(:last_win))
  end

  test "should destroy last_win" do
    assert_difference('LastWin.count', -1) do
      delete :destroy, id: @last_win
    end

    assert_redirected_to last_wins_path
  end
end
