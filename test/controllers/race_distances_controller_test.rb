require 'test_helper'

class RaceDistancesControllerTest < ActionController::TestCase
  setup do
    @race_distance = race_distances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:race_distances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create race_distance" do
    assert_difference('RaceDistance.count') do
      post :create, race_distance: {  }
    end

    assert_redirected_to race_distance_path(assigns(:race_distance))
  end

  test "should show race_distance" do
    get :show, id: @race_distance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @race_distance
    assert_response :success
  end

  test "should update race_distance" do
    patch :update, id: @race_distance, race_distance: {  }
    assert_redirected_to race_distance_path(assigns(:race_distance))
  end

  test "should destroy race_distance" do
    assert_difference('RaceDistance.count', -1) do
      delete :destroy, id: @race_distance
    end

    assert_redirected_to race_distances_path
  end
end
