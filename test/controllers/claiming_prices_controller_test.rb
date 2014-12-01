require 'test_helper'

class ClaimingPricesControllerTest < ActionController::TestCase
  setup do
    @claiming_price = claiming_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:claiming_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create claiming_price" do
    assert_difference('ClaimingPrice.count') do
      post :create, claiming_price: {  }
    end

    assert_redirected_to claiming_price_path(assigns(:claiming_price))
  end

  test "should show claiming_price" do
    get :show, id: @claiming_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @claiming_price
    assert_response :success
  end

  test "should update claiming_price" do
    patch :update, id: @claiming_price, claiming_price: {  }
    assert_redirected_to claiming_price_path(assigns(:claiming_price))
  end

  test "should destroy claiming_price" do
    assert_difference('ClaimingPrice.count', -1) do
      delete :destroy, id: @claiming_price
    end

    assert_redirected_to claiming_prices_path
  end
end
