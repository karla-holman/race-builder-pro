require 'test_helper'

class HorseFilterSettingsControllerTest < ActionController::TestCase
  setup do
    @horse_filter_setting = horse_filter_settings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horse_filter_settings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create horse_filter_setting" do
    assert_difference('HorseFilterSetting.count') do
      post :create, horse_filter_setting: {  }
    end

    assert_redirected_to horse_filter_setting_path(assigns(:horse_filter_setting))
  end

  test "should show horse_filter_setting" do
    get :show, id: @horse_filter_setting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @horse_filter_setting
    assert_response :success
  end

  test "should update horse_filter_setting" do
    patch :update, id: @horse_filter_setting, horse_filter_setting: {  }
    assert_redirected_to horse_filter_setting_path(assigns(:horse_filter_setting))
  end

  test "should destroy horse_filter_setting" do
    assert_difference('HorseFilterSetting.count', -1) do
      delete :destroy, id: @horse_filter_setting
    end

    assert_redirected_to horse_filter_settings_path
  end
end
