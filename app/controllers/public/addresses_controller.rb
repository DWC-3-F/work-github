class AddressesController < ApplicationController
  def create
    @address = Address.new(address_params)
  end
  
  def index
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end
  
  def address_params
    params.require(:address).permit(:customer_id, :post_code)
  end
end
