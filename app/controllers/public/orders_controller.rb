class Public::OrdersController < ApplicationController
  def new
  end

  def comfirm
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
end
