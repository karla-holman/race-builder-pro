require 'test_helper'

class HorseConditionsControllerTest < ActionController::TestCase
  setup do
    @horse_condition = horse_conditions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horse_conditions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create horse_condition" do
    assert_difference('HorseCondition.count') do
      post :create, horse_condition: { condition_id: @horse_condition.condition_id, horse_id: @horse_condition.horse_id, value: @horse_condition.value }
    end

    assert_redirected_to horse_condition_path(assigns(:horse_condition))
  end

  test "should show horse_condition" do
    get :show, id: @horse_condition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @horse_condition
    assert_response :success
  end

  test "should update horse_condition" do
    patch :update, id: @horse_condition, horse_condition: { condition_id: @horse_condition.condition_id, horse_id: @horse_condition.horse_id, value: @horse_condition.value }
    assert_redirected_to horse_condition_path(assigns(:horse_condition))
  end

  test "should destroy horse_condition" do
    assert_difference('HorseCondition.count', -1) do
      delete :destroy, id: @horse_condition
    end

    assert_redirected_to horse_conditions_path
  end
end
