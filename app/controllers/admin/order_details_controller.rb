class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = Order_datail.find(params[:id])
  end
end
