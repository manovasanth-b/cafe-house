class CheckOutController < ApplicationController
  def index
    get_cart_order_items_with_calculated_price
    "index"
  end

  def place_order
    order_id = params[:order_id]
    begin
      order = Order.find(order_id)
      if order
        order.order_status = $ORDER_STAGES[1]
        order.order_placed_date = Date.today
        if !order.save
          flash[:Error] = "Error: Not able to place the order.. Please try again!"
        else
          flash[:notice] = "Your order has been successfully Placed!"
        end
      end
    rescue => exception
      flash[:Error] = exception.message
    end

    redirect_to view_orders_path
  end
end
