class Admin::HomesController < ApplicationController

  before_action :authenticate_user!

  def top
    @orders = Order.page(params[:page]).order(created_at: :desc)
  end
end
