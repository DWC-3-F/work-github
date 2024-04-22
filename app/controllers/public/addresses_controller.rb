class Public::AddressesController < ApplicationController
  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to customers_my_page_path, notice: "You have created address successfully."
    else
      flash.now[:alert] = "Address creation failed."
      render 'index'
    end
  end

  def index
    @addresses = Address.all
    @address = Address.new
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
    params.require(:address).permit(:post_code, :address, :name, :customer_id)
  end
end
