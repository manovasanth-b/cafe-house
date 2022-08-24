class User < ActiveRecord::Base
  has_many :orders, class_name: "Order", :dependent => :destroy
  #attr_accessor :password, :password_confirmation, :crypted_password, :email, :password_salt, :persistence_token
  acts_as_authentic
end
