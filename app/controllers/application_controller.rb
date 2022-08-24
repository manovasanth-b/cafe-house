class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :set_locale
  protect_from_forgery with: :null_session
  # skip_before_action :verify_authenticity_token
  $USER_TYPE_CUSTOMER = 3
  $USER_TYPE_CLERK = 2
  $USER_TYPE_OWNER = 1

  @@cart_need_to_be_updated = []

  $ORDER_STAGES = ["In Cart", "Pending Request", "Confirmed", "Being Prepared", "Dispatched", "Delivered"]

  helper_method :current_user_session, :current_user, :isCafeOwner, :get_all_orders, :get_all_orders_current_user, :get_cart_orders_current_user

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end

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
      @get_all_orders = Order.order(order_placed_date: :desc).where.not(:order_status => $ORDER_STAGES[0])
    end
  end

  def get_all_orders_current_user
    if current_user
      @get_all_orders_current_user = current_user.orders.order(order_placed_date: :desc)
    end
  end

  def get_cart_orders_current_user
    if current_user
      @get_cart_orders_current_user = current_user.orders.where(:order_placed_date => nil)
    end
  end
end
