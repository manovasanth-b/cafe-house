class OrderItem < ActiveRecord::Base
  belongs_to :order, class_name: "Order", foreign_key: :order_id
  belongs_to :menu_item, class_name: "MenuItem", foreign_key: :menu_item_id
  validates :order_id, presence: true
end
