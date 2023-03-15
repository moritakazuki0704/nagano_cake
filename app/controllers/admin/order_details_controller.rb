class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update_making_process
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    flash[:notice] = "製作ステータスを変更しました"
    @order = @order_detail.order
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
