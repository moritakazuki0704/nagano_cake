class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def sub_total
    item.with_tax_price * amount
  end
end