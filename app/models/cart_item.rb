class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :item_id, presence: true
  validates :customer_id, presence: true
  validates :amount, presence: true, numericality: {only_integer: true, greater_than: 0}

  def sub_total
    item.with_tax_price * amount
  end
end