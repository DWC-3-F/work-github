class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
  end
  
  
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "注文ステータスの更新に成功しました"
      redirect_to admin_order_path(@order)
    else
      flash[:alert] = "注文ステータスの更新に失敗しました"
      render :show
    end
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
end
