require 'test_helper'

class TelsControllerTest < ActionController::TestCase
  setup do
    @tel = tels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tel" do
    assert_difference('Tel.count') do
      post :create, tel: {  }
    end

    assert_redirected_to tel_path(assigns(:tel))
  end

  test "should show tel" do
    get :show, id: @tel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tel
    assert_response :success
  end

  test "should update tel" do
    patch :update, id: @tel, tel: {  }
    assert_redirected_to tel_path(assigns(:tel))
  end

  test "should destroy tel" do
    assert_difference('Tel.count', -1) do
      delete :destroy, id: @tel
    end

    assert_redirected_to tels_path
  end
end
