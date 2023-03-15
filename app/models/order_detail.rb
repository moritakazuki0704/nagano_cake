class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

	validates :item_id, presence: true
	validates :order_id, presence: true
	validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
	validates :amount, presence: true, numericality: {only_integer: true, greater_than: 0}
	
  enum making_status: { impossible: 0, waiting: 1, making: 2, completion: 3 }

  def sub_total
    (price * amount).floor
  end

end