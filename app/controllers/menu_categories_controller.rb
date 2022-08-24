class MenuCategoriesController < ApplicationController
  helper_method :get_cart_order_items

  def index
    @menu_category = MenuCategory.new
    @menu_item = MenuItem.new
    @menu_categories

    if Rails.cache.fetch(:menu_categories)
      @menu_categories = Rails.cache.fetch(:menu_categories)
    else
      Rails.cache.write(:menu_categories, MenuCategory.all.order(name: :asc))
      @menu_categories = Rails.cache.fetch(:menu_categories)
    end

    if isClerk
      redirect_to view_clerk_home_path
    elsif current_user && current_user.id
      render "index"
    else redirect_to view_welcome_path     end
  end

  def search_menu_item
    search_term = params[:search_term]
    @menu_items = (MenuItem.search query: { match: { name: search_term } }).results
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create_menu_item_view
    @menu_categories = MenuCategory.all.order(name: :asc)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_menu_item_view
    @selected_menu_item = MenuItem.find(params[:menu_item_id])
    @selected_menu_category_name = params[:menu_category_name]
    @menu_categories = MenuCategory.all.order(name: :asc)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit_menu_category
    if isCafeOwner
      begin
        @menu_category = MenuCategory.find(params[:menu_id])
        @menu_category.name = params[:menu_name]
        if @menu_category.save
          flash[:notice] = "Menu category changes saved successfully!"
        else
          flash[:Error] = "Error: Issue in creating the menu category!"
        end
      rescue => exception
        flash[:Error] = exception.message
      end
      redirect_to view_home_path
    else
      render plain: "Error: 404 Not Authorized"
    end
  end

  def destroy
    if isCafeOwner
      begin
        @menu_category = MenuCategory.find(params[:menu_id])
        if @menu_category.destroy
          flash[:notice] = "Menu category deleted successfully!"
        else
          flash[:Error] = "Error: Issue in deleting the menu category!"
        end
      rescue => exception
        flash[:Error] = exception.message
      end
      redirect_to view_home_path
    else
      render plain: "Error: 404 Not Authorized"
    end
  end

  def get_cart_order_items
    if current_user
      @get_cart_order_items = {}
      if get_cart_orders_current_user && get_cart_orders_current_user.first
        get_cart_orders_current_user.first.order_items.each do |order_item|
          @get_cart_order_items[order_item.menu_item_id] = order_item.menu_item_quantity
        end
      end
    end
    @get_cart_order_items
  end
end
