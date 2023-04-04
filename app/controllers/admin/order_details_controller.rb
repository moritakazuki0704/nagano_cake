class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update_making_process
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    flash[:notice] = "製作ステータスを変更しました"
    @order = @order_detail.order
    redirect_to admin_order_path(@order.id)

    if @order_detail.making_status == "making"
      @order.update(status: 2)
    end

    if @order.order_details.count == @order.order_details.where(making_status: 3).count
      @order.update(status: 3)
    end

  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
