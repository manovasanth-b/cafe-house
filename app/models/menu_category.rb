class MenuCategory < ActiveRecord::Base
  has_many :menu_items, class_name: "MenuItem", :dependent => :destroy
end
