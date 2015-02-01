require 'test_helper'

class ConditionNodesControllerTest < ActionController::TestCase
  setup do
    @condition_node = condition_nodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:condition_nodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create condition_node" do
    assert_difference('ConditionNode.count') do
      post :create, condition_node: {  }
    end

    assert_redirected_to condition_node_path(assigns(:condition_node))
  end

  test "should show condition_node" do
    get :show, id: @condition_node
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @condition_node
    assert_response :success
  end

  test "should update condition_node" do
    patch :update, id: @condition_node, condition_node: {  }
    assert_redirected_to condition_node_path(assigns(:condition_node))
  end

  test "should destroy condition_node" do
    assert_difference('ConditionNode.count', -1) do
      delete :destroy, id: @condition_node
    end

    assert_redirected_to condition_nodes_path
  end
end
