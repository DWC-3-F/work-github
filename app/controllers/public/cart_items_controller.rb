class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = Cart_Item.all
  end
  
  def update
    @cart_items = Cart_Item.find(params[:id])
    if @cart_items.update(cart_item_params)
      redirect_to public_cart_items_path
    end
  end 
  
  def destroy
    
  end 


 destroy_all
 
 
  def create
    
  end 
  
  private
  def cart_item_params
    params.require(:cart_item).permit(: )
  end
end
