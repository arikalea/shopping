require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest:: Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Vendor, @vendor
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_check_stock_starts_at_none
    assert_equal 0, @vendor.check_stock(@item1)
  end

  def test_stock_an_item
    @vendor.stock(@item1, 30)

    assert_equal ({@item1 => 30}), @vendor.check_stock(@item1)
  end
end
