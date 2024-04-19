class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
  end
  
  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path
  end
end
