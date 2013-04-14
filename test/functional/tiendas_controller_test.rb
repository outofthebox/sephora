require 'test_helper'

class TiendasControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Tienda.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Tienda.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Tienda.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to tienda_url(assigns(:tienda))
  end

  def test_edit
    get :edit, :id => Tienda.first
    assert_template 'edit'
  end

  def test_update_invalid
    Tienda.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Tienda.first
    assert_template 'edit'
  end

  def test_update_valid
    Tienda.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Tienda.first
    assert_redirected_to tienda_url(assigns(:tienda))
  end

  def test_destroy
    tienda = Tienda.first
    delete :destroy, :id => tienda
    assert_redirected_to tiendas_url
    assert !Tienda.exists?(tienda.id)
  end
end
