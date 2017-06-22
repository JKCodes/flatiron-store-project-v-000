class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    total = 0
    self.line_items.each do |line_item|
      total += line_item.item.price * line_item.quantity
    end
    total
  end

  def add_item(item_index)
    item_to_add = Item.find_by(id: item_index)

    if self.items.include?(item_to_add)
      line_item = LineItem.find_by(item_id: item_index)
      line_item.quantity += 1
      line_item
    else
      line_items.build(item_id: item_index)
    end
  end

  def checkout
    subtract_inventory
    user.destroy_cart
    update(status: "submitted")
  end

  private

    def subtract_inventory
      line_items.each { |line_item| line_item.item.reduce_quantity_by(line_item.quantity) }
    end
end
