class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name, unique: true, null: false
      t.bigint :menu_category_id, null: false
      t.decimal :price, null: false
      t.string :description
    end
  end
end
