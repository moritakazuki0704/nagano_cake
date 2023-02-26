class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer
  
  def billing_total
    (total_payment + postage)
  end
end
