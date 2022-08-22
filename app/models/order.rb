class Order < ActiveRecord::Base
  has_many :order_items, class_name: "OrderItem", :dependent => :destroy
  belongs_to :user, class_name: "User", foreign_key: :user_id
end
