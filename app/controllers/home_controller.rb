class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:profile]
  
  def index
  	@auth = session[:omniauth]
  end

  def profile
  end

end
