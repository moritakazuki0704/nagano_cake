class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_customers,except:[:index]

  def index
    @customers = Customer.page(params[:page]).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました。"
      redirect_to admin_customer_path(@customer.id)
    else
      render 'edit'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:email,:address,:telephone_number,:is_deleted)
  end

  def set_customers
    @customer = Customer.find(params[:id])
  end
end

