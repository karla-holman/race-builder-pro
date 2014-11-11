require 'test_helper'

class HorseEquipmentsControllerTest < ActionController::TestCase
  setup do
    @horse_equipment = horse_equipments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:horse_equipments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create horse_equipment" do
    assert_difference('HorseEquipment.count') do
      post :create, horse_equipment: {  }
    end

    assert_redirected_to horse_equipment_path(assigns(:horse_equipment))
  end

  test "should show horse_equipment" do
    get :show, id: @horse_equipment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @horse_equipment
    assert_response :success
  end

  test "should update horse_equipment" do
    patch :update, id: @horse_equipment, horse_equipment: {  }
    assert_redirected_to horse_equipment_path(assigns(:horse_equipment))
  end

  test "should destroy horse_equipment" do
    assert_difference('HorseEquipment.count', -1) do
      delete :destroy, id: @horse_equipment
    end

    assert_redirected_to horse_equipments_path
  end
end
