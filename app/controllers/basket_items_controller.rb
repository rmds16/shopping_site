class BasketItemsController < ApplicationController

  def index
    @basket = BasketDecorator.decorate(current_basket)
  end

  def create
    @basket = current_basket
    @basket_item = @basket.add_item(params[:item_id])
    @basket_item.save
    respond_to do |format|
      format.html { redirect_to basket_items_url }
      format.js
    end
  end

  def destroy
    @basket = current_basket
    @basket.remove_item(BasketItem.find(params[:id]))
    @basket
    respond_to do |format|
      format.html { redirect_to basket_items_url }
      format.js 
    end
  end
end
