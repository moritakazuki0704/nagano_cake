class Public::OrdersController < ApplicationController

    before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def comfirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.postage = "800"
    @order.total_payment = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.sub_total }
    @order.customer_id = current_customer.id

    if params[:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:select_address] == "2"
      @order.postal_code = params[:postal_code]
      @order.address = params[:address]
      @order.name = params[:name]
    end
  end

  def create
  end

  def complete
  end

  def index
    @orders = current_customer.orders.page(params[:page]).latest
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details.all
  end

  private

  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
