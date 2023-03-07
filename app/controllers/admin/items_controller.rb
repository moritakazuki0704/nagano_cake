class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!
  before_action :set_item,except:[:new,:create,:index]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def index
    @items = Item.page(params[:page]).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  private

  def item_params
    params.require(:item).permit(:image,:name,:introduction,:genre_id,:price,:is_active)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
