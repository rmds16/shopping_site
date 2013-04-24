class BasketItemsController < ApplicationController

  def index
    @basket_items = current_basket.basket_items
    @basket = current_basket
  end

  def create
    @basket = current_basket
    @basket_item = @basket.add_item(params[:item_id])
    @basket_item.save
    redirect_to basket_items_url
  end

  def destroy
    @basket_item = BasketItem.find(params[:id])
    @basket_item.destroy
    redirect_to basket_items_url 
  end
end
