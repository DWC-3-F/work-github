class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = CartItem.all
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path
    end
  end 
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end 


  def destroy_all
    @cart_items = CartItem.all
    @cart_items.destroy
    redirect_to cart_items_path
  end
 
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
      session[:cart_item] = @cart_item.attributes.slice(*cart_item_params.keys)
      @genres = Genre.all
      @item = Item.find_by(id:@cart_item.item_id)
      redirect_to item_path(@item.id), flash: {alert: '※個数を選択して下さい'}
    end
  end 
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount )
  end
end
