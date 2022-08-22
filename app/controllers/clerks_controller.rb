class ClerksController < ApplicationController
  def index
    @users = User.where(:role =>  3)
    "index"
  end
end
