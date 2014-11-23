require 'test_helper'

class RaceDatesControllerTest < ActionController::TestCase
  setup do
    @race_date = race_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:race_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create race_date" do
    assert_difference('RaceDate.count') do
      post :create, race_date: {  }
    end

    assert_redirected_to race_date_path(assigns(:race_date))
  end

  test "should show race_date" do
    get :show, id: @race_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @race_date
    assert_response :success
  end

  test "should update race_date" do
    patch :update, id: @race_date, race_date: {  }
    assert_redirected_to race_date_path(assigns(:race_date))
  end

  test "should destroy race_date" do
    assert_difference('RaceDate.count', -1) do
      delete :destroy, id: @race_date
    end

    assert_redirected_to race_dates_path
  end
end
