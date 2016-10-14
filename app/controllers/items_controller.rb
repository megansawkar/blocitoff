class ItemsController < ApplicationController

  before_action :authorize_user, except: [:show]

  def create
    @item = Item.new(item_params)
    @item.user = current_user

    if @item.save
      flash[:notice] = "Item was saved successfully."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      redirect_to root_path
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.user = current_user

    if @item.destroy
      flash[:notice] = "\"#{@item}\" was deleted successfully."
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error deleting the item."
      redirect_to root_path
    end

#    respond_to do |format|
#      format.html
#      format.js
#    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :public)
  end

  def authorize_user
    item = Item.find(params[:id])

    unless current_user == item.user
      flash[:alert] = "You must be an admin to do that."
      redirect_to root_path
    end
  end
end
