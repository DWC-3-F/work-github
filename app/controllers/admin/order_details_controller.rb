class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @order_detail = Order_datail.find(params[:id])
    if @order_detail.update(:making_status)
      redirect_to admin_order_path
    end
  end
end
