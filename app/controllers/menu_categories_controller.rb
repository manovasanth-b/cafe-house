class MenuCategoriesController < ApplicationController
  def index
    @menu_category = MenuCategory.new
    @menu_item = MenuItem.new
    @menu_categories = MenuCategory.all.order(name: :asc)
    puts "098765"
    puts get_cart_order_items
    if isClerk
      redirect_to view_clerk_home_path
    elsif current_user && current_user.id
      render "index"
    else redirect_to view_welcome_path     end
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
end
