class Public::AddressesController < ApplicationController
  
  before_action :set_address,except:[:create,:index]
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customers.id
    @address.save
    redirect_to addresses_path
  end

  def index
    @addresses = Address.page(params[:page])
    @address = Address.new
  end

  def edit
  end

  def update
    @address = update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:address,:postal_code,:name)
  end
  
  def set_address
    @address = Address.find(params[:id])
  end
end
