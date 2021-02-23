class Cart < ApplicationRecord
	has_many :line_items, dependent: :destroy

	def add_product(product)
    current_item = line_items.find_by(product_id: product.id)

    unless current_item
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def add_line_item(line_item)
    current_item = LineItem.find_by(id: line_item.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(id: line_item.id)
    end
    current_item
  end

  def remove_line_item(line_item)
    current_item = LineItem.find_by(id: line_item.id)
    if current_item.quantity > 1
      current_item.quantity -= 1
    elsif current_item.quantity = 1
      current_item.destroy
    end
    current_item
  end
end
