class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!
  before_action :current_customer_cart,except:[:create]

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      flash[:notice] = "新しい商品を追加しました。"
      redirect_to cart_items_path
    else
      @item = Item.find(@cart_item.item.id)
      render template: "public/items/show"
    end
  end

  def index
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.sub_total }
  end

  def update
    cart_item = @cart_items.find(params[:id])
    cart_item.customer_id = current_customer.id
    if cart_item.update(cart_item_params)
      flash[:notice] = "個数を更新しました。"
      redirect_to cart_items_path
    end
  end

  def destroy
    cart_item = @cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id,:amount)
  end

  def current_customer_cart
    @cart_items = current_customer.cart_items
  end

end