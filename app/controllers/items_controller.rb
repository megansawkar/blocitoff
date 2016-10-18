class ItemsController < ApplicationController

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
    else
      flash.now[:alert] = "There was an error deleting the item."
    end

    respond_to do |format|
      format.html
      format.js { render json: @item }
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :public)
  end

end
