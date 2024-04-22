class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.create(order_params)
  end
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def confilm
    @order = Order.find(params[:id])
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
