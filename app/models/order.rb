class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer

  validates :customer_id,presence: true
  validates :total_payment,presence: true, numericality: { only_integer: true }
  validates :address,presence: true
  validates :postal_code,presence: true,length: {is: 7}, numericality: { only_integer: true }
  validates :name,presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { awaiting_payment: 0, payment_confirmation: 1, making: 2, shipping_preparation: 3, shipped: 4 }

  def billing_total
    (total_payment + postage)
  end

  def address_display
    '〒' + postal_code + '' + address
  end
end
