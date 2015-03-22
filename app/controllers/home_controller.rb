class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:profile]
  before_action :set_auth

  def index
  end

  def profile
  end

  private

  def set_auth
  	 @auth = session[:omniauth] if session[:omniauth]
  end

end


