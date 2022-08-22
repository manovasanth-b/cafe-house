class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  $USER_TYPE_CUSTOMER = 3
  $USER_TYPE_CLERK = 2
  $USER_TYPE_OWNER = 1

  @@cart_need_to_be_updated = []

  $ORDER_STAGES = ["In Cart", "Confirmed", "Being Prepared", "Dispatched", "Delivered"]

  helper_method :current_user_session, :current_user, :isCafeOwner, :get_all_orders, :get_all_orders_current_user, :get_cart_orders, :get_cart_order_items, :get_cart_items_to_be_updated, :update_cart_items_to_be_updated

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def isCafeOwner
    return @isCafeOwner if defined?(@isCafeOwner)
    @isCafeOwner = current_user if current_user && current_user.role == $USER_TYPE_OWNER
  end

  def isClerk
    return @isClerk if defined?(@isClerk)
    @isClerk = current_user if current_user && current_user.role == $USER_TYPE_CLERK
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def get_all_orders
    return @get_all_orders if defined?(@get_all_orders)
    if current_user && current_user.role == $USER_TYPE_CLERK
      @get_all_orders = Order.where.not(:order_status => $ORDER_STAGES[0])
    end
  end

  def get_all_orders_current_user
    if current_user
      @get_all_orders_current_user = current_user.orders.all
    end
  end

  def get_cart_orders
    return @get_cart_orders if defined?(@get_cart_orders)
    if current_user
      @get_cart_orders = current_user.orders.where(:order_placed_date => nil)
    end
  end

  def get_cart_order_items
    if current_user
      @get_cart_order_items = {}
      if get_cart_orders && get_cart_orders.first
        get_cart_orders.first.order_items.each do |order_item|
          @get_cart_order_items[order_item.menu_item_id] = order_item.menu_item_quantity
        end
      end
    end
    @get_cart_order_items
  end

  def get_cart_order_items_with_calculated_price
    return @get_cart_order_items_with_calculated_price if defined?(@get_cart_order_items_with_calculated_price)
    if current_user
      @get_cart_order_items_with_calculated_price = { "total_price" => 0, "order_items" => [] }
      if get_cart_orders && get_cart_orders.first
        get_cart_orders.first.order_items.each do |order_item|
          @get_cart_order_items_with_calculated_price["order_items"].push(order_item)
          @get_cart_order_items_with_calculated_price["total_price"] = @get_cart_order_items_with_calculated_price["total_price"] + (order_item.menu_item_price * order_item.menu_item_quantity)
        end
      end
    end
  end
end
