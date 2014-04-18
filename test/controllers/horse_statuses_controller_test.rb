require 'test_helper'

class HorseStatusesControllerTest < ActionController::TestCase
  setup do
    @horse_status = horse_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horse_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create horse_status" do
    assert_difference('HorseStatus.count') do
      post :create, horse_status: { horse_id: @horse_status.horse_id, status_id: @horse_status.status_id, value: @horse_status.value }
    end

    assert_redirected_to horse_status_path(assigns(:horse_status))
  end

  test "should show horse_status" do
    get :show, id: @horse_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @horse_status
    assert_response :success
  end

  test "should update horse_status" do
    patch :update, id: @horse_status, horse_status: { horse_id: @horse_status.horse_id, status_id: @horse_status.status_id, value: @horse_status.value }
    assert_redirected_to horse_status_path(assigns(:horse_status))
  end

  test "should destroy horse_status" do
    assert_difference('HorseStatus.count', -1) do
      delete :destroy, id: @horse_status
    end

    assert_redirected_to horse_statuses_path
  end
end
