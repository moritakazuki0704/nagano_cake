class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!
  before_action :set_address,except:[:create,:index]

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "新しい配送先を登録しました。"
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses.all
      render :index
    end
  end

  def index
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def edit
  end

  def update
    if @address = update(address_params)
      flash[:notice] = "変更内容を更新しました。"
      redirect_to addresses_path
    else
      render "edit"
    end
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
