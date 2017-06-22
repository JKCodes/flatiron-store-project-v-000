class Item < ActiveRecord::Base
  has_many :line_items
  belongs_to :category

  def +(item)
    self.price + item.price
  end

  def self.available_items
    where('inventory > ?', 0)
  end

  def reduce_quantity_by(quantity)
    update(inventory: inventory - quantity)
  end
end
