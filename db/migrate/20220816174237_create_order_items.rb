class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.bigint :order_id, null: false
      t.bigint :menu_item_id, null: false
      t.string :menu_item_name, null: false
      t.decimal :menu_item_price, null: false
      t.integer :menu_item_quantity, default: 1
    end
  end
end
