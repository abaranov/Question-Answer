class HomeController < ApplicationController

  before_filter :authenticate_user!, except: %w(show index)

  def index
    #redirect_to user_path(current_user) if current_user
  end
end
