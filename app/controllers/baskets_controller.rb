class BasketsController < ApplicationController

  def create
    @basket = Basket.new
  end

  def destroy
    current_basket.destroy
    redirect_to root_path
  end

end
