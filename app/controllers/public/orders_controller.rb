class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.create(order_params)
    
    if @order.save
        redirect_to order_path(@order), notice: 'Order was successfully created.'
    else
        render :new, status: :unprocessable_entity
    end
  end
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
