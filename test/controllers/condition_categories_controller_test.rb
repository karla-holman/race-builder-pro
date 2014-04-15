require 'test_helper'

class ConditionCategoriesControllerTest < ActionController::TestCase
  setup do
    @condition_category = condition_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:condition_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create condition_category" do
    assert_difference('ConditionCategory.count') do
      post :create, condition_category: { name: @condition_category.name }
    end

    assert_redirected_to condition_category_path(assigns(:condition_category))
  end

  test "should show condition_category" do
    get :show, id: @condition_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @condition_category
    assert_response :success
  end

  test "should update condition_category" do
    patch :update, id: @condition_category, condition_category: { name: @condition_category.name }
    assert_redirected_to condition_category_path(assigns(:condition_category))
  end

  test "should destroy condition_category" do
    assert_difference('ConditionCategory.count', -1) do
      delete :destroy, id: @condition_category
    end

    assert_redirected_to condition_categories_path
  end
end
