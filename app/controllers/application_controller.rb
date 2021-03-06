class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_basket, :current_order, :current_user_session, :current_user

  private
    def current_basket
      Basket.find(session[:basket_id])
      rescue ActiveRecord::RecordNotFound
        basket = Basket.create
        session[:basket_id] = basket.id
        basket
    end

    def current_order
      Order.find(session[:order_id])
      rescue ActiveRecord::RecordNotFound
        order = Order.create
        session[:order_id] = order.id
        order
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def signed_in_user
      unless current_user
        store_location
        redirect_to signin_path
      end
    end

end
