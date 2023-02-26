class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  def sub_total
    (price * amount).floor
  end
end
