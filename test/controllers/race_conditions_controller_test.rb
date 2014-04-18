require 'test_helper'

class RaceConditionsControllerTest < ActionController::TestCase
  setup do
    @race_condition = race_conditions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:race_conditions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create race_condition" do
    assert_difference('RaceCondition.count') do
      post :create, race_condition: { condition_id: @race_condition.condition_id, race_id: @race_condition.race_id, value: @race_condition.value }
    end

    assert_redirected_to race_condition_path(assigns(:race_condition))
  end

  test "should show race_condition" do
    get :show, id: @race_condition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @race_condition
    assert_response :success
  end

  test "should update race_condition" do
    patch :update, id: @race_condition, race_condition: { condition_id: @race_condition.condition_id, race_id: @race_condition.race_id, value: @race_condition.value }
    assert_redirected_to race_condition_path(assigns(:race_condition))
  end

  test "should destroy race_condition" do
    assert_difference('RaceCondition.count', -1) do
      delete :destroy, id: @race_condition
    end

    assert_redirected_to race_conditions_path
  end
end
