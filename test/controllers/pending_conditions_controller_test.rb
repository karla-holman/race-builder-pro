require 'test_helper'

class PendingConditionsControllerTest < ActionController::TestCase
  setup do
    @pending_condition = pending_conditions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pending_conditions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pending_condition" do
    assert_difference('PendingCondition.count') do
      post :create, pending_condition: {  }
    end

    assert_redirected_to pending_condition_path(assigns(:pending_condition))
  end

  test "should show pending_condition" do
    get :show, id: @pending_condition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pending_condition
    assert_response :success
  end

  test "should update pending_condition" do
    patch :update, id: @pending_condition, pending_condition: {  }
    assert_redirected_to pending_condition_path(assigns(:pending_condition))
  end

  test "should destroy pending_condition" do
    assert_difference('PendingCondition.count', -1) do
      delete :destroy, id: @pending_condition
    end

    assert_redirected_to pending_conditions_path
  end
end
