class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
     @orders = Order.includes(:customer, :order_details).order(created_at: :desc).page(params[:page])
  end
  
  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path
  end
end
