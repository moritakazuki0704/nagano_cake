class Public::CustomersController < ApplicationController

  before_action :current_customer

  def show
  end

  def edit
  end

  def update
  end

  def confirm
  end

  def withdraw
    Customers.is_deleted = true
    redirect_to root_path
  end

  private

  def current_customer
    @customer = current_customer
  end
end
