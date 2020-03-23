class UsersController < ApplicationController
  def show
    @flavors = current_user.flavors
  end
  def image
    @flavors = current_user.flavors
  end

end
