class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @item = Item.new
  end

def create
    @item = Item.new(item_params)
    if @item.save
        flash[:notice] = 'You have created item successfully'
        redirect_to admin_item_path(@item) # ここでadmin_item_pathを使用します
    else
        render :new
    end
end

  def index
    @items = Item.all
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[notice] = 'You have updated item successfully'
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :genre_id, :introduction, :price, :is_active, :image)
  end
end
