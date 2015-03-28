require 'test_helper'

class NominationCloseDatesControllerTest < ActionController::TestCase
  setup do
    @nomination_close_date = nomination_close_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nomination_close_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nomination_close_date" do
    assert_difference('NominationCloseDate.count') do
      post :create, nomination_close_date: {  }
    end

    assert_redirected_to nomination_close_date_path(assigns(:nomination_close_date))
  end

  test "should show nomination_close_date" do
    get :show, id: @nomination_close_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nomination_close_date
    assert_response :success
  end

  test "should update nomination_close_date" do
    patch :update, id: @nomination_close_date, nomination_close_date: {  }
    assert_redirected_to nomination_close_date_path(assigns(:nomination_close_date))
  end

  test "should destroy nomination_close_date" do
    assert_difference('NominationCloseDate.count', -1) do
      delete :destroy, id: @nomination_close_date
    end

    assert_redirected_to nomination_close_dates_path
  end
end
