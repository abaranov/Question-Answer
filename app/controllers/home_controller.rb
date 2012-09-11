class HomeController < ApplicationController

  before_filter :authenticate_user!, except: %w(show index)

  def index
  end
end
