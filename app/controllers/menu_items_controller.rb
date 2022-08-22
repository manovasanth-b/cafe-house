class MenuItemsController < ApplicationController
  def update_menu_item
    if isCafeOwner
      begin
        menu_item = MenuItem.find(params[:menu_item_id])
        menu_item.name = params[:name]
        menu_item.price = params[:price]
        menu_item.description = params[:description]
        menu_item.menu_category_id = params[:menu_category_id]

        if menu_item.save
          flash[:notice] = "Menu Item Updated Successfully"
        else
          flash[:Error] = "Error occured in updating the menu item"
        end
      rescue => exception
        flash[:Error] = exception.message
      end
    else
      flash[:Error] = "Error: 404 Not Authorized"
    end
    redirect_to view_home_path
  end

  def delete_menu_item
    if isCafeOwner
      begin
        @menu_item = MenuItem.find(params[:menu_item_id])
        if @menu_item.destroy
          flash[:notice] = "Menu Item Deleted successfully!"
        else
          flash[:Error] = "Error: Issue in deleting the menu item!"
        end
      rescue => exception
        flash[:Error] = exception.message
        redirect_to view_home_path
      end
      redirect_to view_home_path
    else
      render plain: "Error: 404 Not Authorized"
    end
  end

  def create
    if isCafeOwner
      begin
        menu_category_id = params[:menu_category_id]
        puts menu_category_id
        if menu_category_id == "Others"
          @menu_category = MenuCategory.new(:name => params[:new_menu_category_name])
          if @menu_category.save
          else
            flash[:Error] = "Error: Issue in creating the menu category!"
            redirect_to view_home_path
          end
        else
          @menu_category = MenuCategory.find(menu_category_id)
        end

        if @menu_category && @menu_category.id
          @menu_item = @menu_category.menu_items.new(:name => params[:name], :price => params[:price], :description => params[:description])
          if @menu_item.save
            flash[:notice] = "Menu Items changes saved successfully!"
          else
            flash[:Error] = "Error: Menu Category Not Found!"
          end
        else
          flash[:Error] = "Error: Menu Category Not Found!"
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
