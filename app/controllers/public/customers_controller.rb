class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!
  before_action :customer

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "変更内容を更新しました。"
      redirect_to mypage_path
    else
      render "edit"
    end
  end

  def confirm
  end

  def withdraw
    @customer.update(is_deleted: 'true')
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:email,:address,:telephone_number,:is_deleted)
  end

  def customer
    @customer = current_customer
  end

end
