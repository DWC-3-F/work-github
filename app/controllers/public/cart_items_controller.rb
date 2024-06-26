class Public::CartItemsController < ApplicationController
   before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = CartItem.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @customer = current_customer
    @cart_item = @customer.cart_items.new(cart_item_params)
    if @customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = @customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to items_path
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount )
  end
end