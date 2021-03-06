class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name    = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def total_inventory
    total_inventory = {}

    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if total_inventory[item].nil?
          total_inventory[item] = {quantity: 0, vendors: []}
        end
        total_inventory[item][:quantity] += quantity
        total_inventory[item][:vendors].push(vendor)
      end
    end
    total_inventory
  end

  def overstocked_items
    overstocked = []

    total_inventory.each do |item, info|
      overstocked << item if info[:quantity] > 50 && info[:vendors].length > 1
    end
    overstocked
  end

  def sorted_item_list
    items = @vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten.uniq

    items.map do |item|
      item.name
    end.sort
  end

  def sell(item, quantity)
    if total_inventory[item].nil? || total_inventory[item][:quantity] < quantity
      return false
    end

    vendors_that_sell(item).each do |vendor|
      if vendor.check_stock(item) >= quantity
        vendor.sell(item, quantity)
        quantity = 0
      else
        quantity -= vendor.check_stock(item)
        vendor.sell(item, vendor.check_stock(item))
      end
    end 
  end
end
