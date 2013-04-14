require 'test_helper'

class TiendaTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Tienda.new.valid?
  end
end
