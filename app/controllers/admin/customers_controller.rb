class Admin::CustomersController < ApplicationController
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def index
    @customers = Customer.all
    @customers = Customer.page(params[:page]).per(10)
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
        redirect_to admin_customer_path(@customer)
    else
        render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :email)
  end
end