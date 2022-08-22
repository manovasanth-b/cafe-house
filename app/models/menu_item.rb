class MenuItem < ActiveRecord::Base
  belongs_to :menu_category, class_name: "MenuCategory", foreign_key: :menu_category_id
  has_many :order_items, class_name: "OrderItem", :dependent => :destroy
  validates :menu_category, presence: true
end
