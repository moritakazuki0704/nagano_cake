class Admin::ItemsController < ApplicationController
  def new
  end
  
  def create
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
  end

  def edit
  end
  
  def update
  end
end
