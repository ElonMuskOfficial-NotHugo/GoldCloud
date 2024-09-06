module CurrentOrder
  extend ActiveSupport::Concern

  included do
    helper_method :current_order
  end

  def current_order
    # First, check if there's an order_id in the session
    if session[:order_id]
      order = Order.find_by(id: session[:order_id])
      return order if order && order.created?
    end

    # If no valid order in session, look for the user's last created order
    order = current_user.orders.created.last

    if order
      # If found, set the session order_id
      session[:order_id] = order.id
      return order
    end

    # If no existing order found, create a new one
    create_new_order
  end

  private

  def create_new_order
    order = Order.create(user: current_user, status: :created)
    session[:order_id] = order.id
    order
  end
end
