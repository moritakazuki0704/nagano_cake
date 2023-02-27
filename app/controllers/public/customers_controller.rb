class Public::CustomersController < ApplicationController
  
  before_action :current_customers
  
  
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
  
  def current_customers
    @customers = current_customers
  end
end
