require 'test_helper'

class HorseracesControllerTest < ActionController::TestCase
  setup do
    @horserace = horseraces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horseraces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create horserace" do
    assert_difference('Horserace.count') do
      post :create, horserace: { created_at: @horserace.created_at, entered: @horserace.entered, horse_id: @horserace.horse_id, race_id: @horserace.race_id, updated_at: @horserace.updated_at }
    end

    assert_redirected_to horserace_path(assigns(:horserace))
  end

  test "should show horserace" do
    get :show, id: @horserace
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @horserace
    assert_response :success
  end

  test "should update horserace" do
    patch :update, id: @horserace, horserace: { created_at: @horserace.created_at, entered: @horserace.entered, horse_id: @horserace.horse_id, race_id: @horserace.race_id, updated_at: @horserace.updated_at }
    assert_redirected_to horserace_path(assigns(:horserace))
  end

  test "should destroy horserace" do
    assert_difference('Horserace.count', -1) do
      delete :destroy, id: @horserace
    end

    assert_redirected_to horseraces_path
  end
end
