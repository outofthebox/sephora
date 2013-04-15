require 'test_helper'

class EventotiendasControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Eventotienda.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Eventotienda.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Eventotienda.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to eventotienda_url(assigns(:eventotienda))
  end

  def test_edit
    get :edit, :id => Eventotienda.first
    assert_template 'edit'
  end

  def test_update_invalid
    Eventotienda.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Eventotienda.first
    assert_template 'edit'
  end

  def test_update_valid
    Eventotienda.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Eventotienda.first
    assert_redirected_to eventotienda_url(assigns(:eventotienda))
  end

  def test_destroy
    eventotienda = Eventotienda.first
    delete :destroy, :id => eventotienda
    assert_redirected_to eventotiendas_url
    assert !Eventotienda.exists?(eventotienda.id)
  end
end
