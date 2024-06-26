class Public::OrdersController < ApplicationController
   before_action :authenticate_customer!
   
  def new
    @customer = current_customer
    @order = Order.new
  end

  def create
    @customer = current_customer
    @order = Order.new
    @order.customer_id = @customer.id
    @order.shipping_cost = 800
    @cart_items = CartItem.where(customer_id: @customer.id)
    ary = []
      @cart_items.each do |cart_item|
        ary << cart_item.item.price*cart_item.amount
      end
    @cart_items_price = ary.sum
    @order.total_payment = @order.shipping_cost + @cart_items_price
    @order.payment_method = params[:order][:payment_method]
    if @order.payment_method == "credit_card"
      @order.status = 1
    else
      @order.status = 0
    end

    address_type = params[:order][:address_type]
    case address_type
      when "own_address"
        @order.post_code = @customer.post_code
        @order.address = @customer.address
        @order.name = @customer.last_name + @customer.first_name
      when "registered_address"
        Address.find(params[:order][:registered_address_id])
        selected = Address.find(params[:order][:registered_address_id])
        @order.post_code = selected.post_code
        @order.address = selected.address
        @order.name = selected.name
      when "new_address"
        @order.post_code = params[:order][:new_post_code]
        @order.address = params[:order][:new_address]
        @order.name = params[:order][:new_name]
    end

    if @order.save
      if @order.status == 0
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
        end
      else
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 1)
        end
      end
      @cart_items.destroy_all
      redirect_to success_orders_path
    else
      render :new
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details= OrderDetail.where(order_id: @order.id)
  end

  def confirm
    @customer = current_customer
    @cart_items = CartItem.where(customer_id: @customer.id)
    @shipping_cost = 800
    @selected_payment_method = params[:order][:payment_method]
    ary = []
      @cart_items.each do |cart_item|
        ary << cart_item.item.price.to_i * cart_item.amount
      end

    @cart_items_price = ary.sum
    @total_payment = @shipping_cost + @cart_items_price
    @address_type = params[:order][:address_type]
    case @address_type
      when "own_address"
        @selected_address = "〒#{@customer.post_code} #{@customer.address} #{@customer.last_name} #{@customer.first_name}"
      when "registered_address"
        unless params[:order][:registered_address_id] == ""
          selected = Address.find(params[:order][:registered_address_id])
          @selected_address = "〒" + selected.post_code + " " + selected.address + " " + selected.name
        else
      	   render :new
        end
      when "new_address"
        unless params[:order][:new_post_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
          @selected_address = "〒" + params[:order][:new_post_code] + " " + params[:order][:new_address] + " " + params[:order][:new_name]
        else
          render :new
        end
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
