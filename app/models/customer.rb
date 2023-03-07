class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses
  has_many :orders

  def address_display
  '〒' + postal_code + ' ' + address
  end

  def full_name
    last_name + first_name
  end

  def name
    last_name + "　" + first_name
  end

  def name_kana
    last_name_kana + "　" + first_name_kana
  end

end
