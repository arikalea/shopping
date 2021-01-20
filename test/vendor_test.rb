require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest:: Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
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

    assert_equal ({@item1 => 30}), @vendor.inventory
    assert_equal 30, @vendor.check_stock(@item1)
  end

  def test_stock_multiple_items
    @vendor.stock(@item1, 30)
    @vendor.stock(@item1, 25)
    @vendor.stock(@item2, 12)

    assert_equal 55, @vendor.check_stock(@item1)
    assert_equal ({@item1 => 55, @item2 => 12}), @vendor.inventory
  end

  def test_vendors_potential_revenue
    @vendor.stock(@item1, 30)
    @vendor.stock(@item1, 25)
    @vendor.stock(@item2, 12)

    assert_equal 29.75, @vendor1.potential_revenue
    assert_equal 345.00, @vendor2.potential_revenue
    assert_equal 48.75, @vendor3.potential_revenue
  end
end
