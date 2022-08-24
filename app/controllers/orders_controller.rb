class OrdersController < ApplicationController
  helper_method :get_enabled_stages

  def index
    @orders = get_all_orders_current_user
    "index"
  end

  def view_clerk_open_orders
    @orders = get_all_orders
    render "open_orders"
  end

  def create_order
    if params[:client_cart_items] == "" || params[:client_cart_items] == "{}"
    else
      begin
        client_cart_items = ActiveSupport::JSON.decode(params[:client_cart_items])
        menu_ids = client_cart_items.keys
        order_id = nil

        if get_cart_orders_current_user && get_cart_orders_current_user.first
          order_id = get_cart_orders_current_user.first.id
        else
          if current_user.orders.create(:order_status => $ORDER_STAGES[0]) && get_cart_orders_current_user && get_cart_orders_current_user.first
            order_id = get_cart_orders_current_user.first.id
          end
        end

        existing_order_items_to_be_deleted = []
        existing_order_items_to_be_updated = []
        OrderItem.where(:menu_item_id => menu_ids, :order_id => order_id).each do |order_item|
          menu_item_id = order_item.menu_item_id.to_s
          menu_ids.delete(menu_item_id)

          if client_cart_items[menu_item_id] && client_cart_items[menu_item_id] != 0
            order_item.menu_item_quantity = client_cart_items[menu_item_id]
            existing_order_items_to_be_updated.push(order_item)
          elsif client_cart_items[menu_item_id] == 0
            existing_order_items_to_be_deleted.push(order_item.id)
          end
        end

        if existing_order_items_to_be_deleted.count != 0
          if !OrderItem.destroy_all(:id => existing_order_items_to_be_deleted)
            flash[:Error] = "Error: In Deleted the Order Item"
          end
        end

        if menu_ids.count != 0 || existing_order_items_to_be_updated.count != 0
          menu_items = menu_ids.count != 0 ? MenuItem.where(:id => menu_ids) : []

          if order_id != nil
            new_orders = menu_items.map do |menu_item|
              order_item = OrderItem.new(
                :order_id => order_id,
                :menu_item_name => menu_item.name,
                :menu_item_id => menu_item.id,
                :menu_item_price => menu_item.price,
                :menu_item_quantity => client_cart_items[menu_item.id.to_s],
              )
            end

            if existing_order_items_to_be_updated.count != 0
              new_orders = new_orders + existing_order_items_to_be_updated
            end
            save_failed = nil
            OrderItem.transaction do
              new_orders.each do |order|
                unless order.save
                  save_failed = true
                  raise ActiveRecord::Rollback
                end
              end
            end
            if save_failed
              flash[:Error] = "Error: In Creating the Order Item"
            end
          end
        end
      rescue => exception
        flash[:Error] = exception.message
      end
    end
    redirect_to view_check_out_path
  end

  def get_enabled_stages(stage)
    enabled_stages = []
    flag = false
    $ORDER_STAGES.each do |curr_stage|
      if flag
        enabled_stages.push([curr_stage, curr_stage])
      end
      if curr_stage == stage
        flag = true
      end
    end
    return enabled_stages
  end

  def change_order_status
    order_id = params[:order_id]
    begin
      order = Order.find(order_id)
      if order
        order.order_status = params[:stage]
        if !order.save
          flash[:Error] = "Error: Not able to update the order.. Please try again!"
        else
          SendUserEmailJob.perform_later(params)
          flash[:notice] = "Order Status has been successfully updated!"
        end
      end
    rescue => exception
      flash[:Error] = exception.message
    end

    redirect_to view_clerk_open_orders_path
  end
end
