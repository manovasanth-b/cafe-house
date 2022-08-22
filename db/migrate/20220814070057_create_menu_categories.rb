class CreateMenuCategories < ActiveRecord::Migration
  def change
    create_table :menu_categories do |t|
      t.string :name, null: false
    end
  end
end
