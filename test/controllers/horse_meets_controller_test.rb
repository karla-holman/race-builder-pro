require 'test_helper'

class HorseMeetsControllerTest < ActionController::TestCase
  setup do
    @horse_meet = horse_meets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horse_meets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create horse_meet" do
    assert_difference('HorseMeet.count') do
      post :create, horse_meet: {  }
    end

    assert_redirected_to horse_meet_path(assigns(:horse_meet))
  end

  test "should show horse_meet" do
    get :show, id: @horse_meet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @horse_meet
    assert_response :success
  end

  test "should update horse_meet" do
    patch :update, id: @horse_meet, horse_meet: {  }
    assert_redirected_to horse_meet_path(assigns(:horse_meet))
  end

  test "should destroy horse_meet" do
    assert_difference('HorseMeet.count', -1) do
      delete :destroy, id: @horse_meet
    end

    assert_redirected_to horse_meets_path
  end
end
