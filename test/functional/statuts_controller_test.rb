require 'test_helper'

class StatutsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create statut" do
    assert_difference('Statut.count') do
      post :create, :statut => { }
    end

    assert_redirected_to statut_path(assigns(:statut))
  end

  test "should show statut" do
    get :show, :id => statuts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => statuts(:one).to_param
    assert_response :success
  end

  test "should update statut" do
    put :update, :id => statuts(:one).to_param, :statut => { }
    assert_redirected_to statut_path(assigns(:statut))
  end

  test "should destroy statut" do
    assert_difference('Statut.count', -1) do
      delete :destroy, :id => statuts(:one).to_param
    end

    assert_redirected_to statuts_path
  end
end
