class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = @order_details.inject(0) { |sum, order_detail| sum + order_detail.sub_total }
  end

  def update_status
    @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:notice] = "注文ステータスを変更しました"
    redirect_to admin_order_path(@order.id)

    if @order.status == "payment_confirmation"
      @order.order_details.each do |order_detail|
        order_detail.update(making_status: 1)
      end
    end

  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
