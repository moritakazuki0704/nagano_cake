class Admin::OrderDetailsController < ApplicationController
  def update_making_process
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    redirect_to admin_order_path(Order.find(params[:id]))
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
