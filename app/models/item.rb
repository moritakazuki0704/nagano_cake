class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items
  has_many :order_details
  belongs_to :genre
  
   validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  def with_tax_price
    (price * 1.1).floor
  end

end
