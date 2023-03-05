class Public::OrdersController < ApplicationController

    before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def comfirm
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.sub_total }
    @order = Order.new(order_params)

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
    @order = current_customer.orders.new(order_params)
    @order.save

    if params[:select_address] == "2"
      @address_data = Address.new
      @address_data.customer_id = current_customer.id
      @address_data.postal_code = @order.postal_code
      @address_data.address = @order.address
      @address_data.name = @order.name
      @address_data.save
    end

    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.id
      @order_detail.order_id = @order.id
      @order_detail.price = cart_item.item.price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
    @cart_items.destroy_all

    redirect_to complete_orders_path
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
    params.require(:order).permit(:postage,:total_payment,:payment_method,:postal_code,:address,:name)
  end

end