class BasketDecorator < Draper::Decorator
  delegate_all

  def continue
    if model.basket_items.count > 0
       h.button_to "Checkout", h.new_order_path, :class => "btn pull-right btn-primary", :method => :get
    end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end