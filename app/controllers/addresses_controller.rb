class AddressesController < ApplicationController

  def index
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      redirect_to address_path(@address), notice: "You have created address successfully."
    else
      render 'index'
    end
  end

  private

  def book_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
