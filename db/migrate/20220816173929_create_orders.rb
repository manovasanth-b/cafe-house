class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.bigint :user_id, null: false
      t.datetime :order_placed_date
      t.string :order_status, null: false
    end
  end
end
