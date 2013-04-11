class BasketsController < ApplicationController

  def create
    @basket = Basket.new
  end

  def destroy
  end

end
