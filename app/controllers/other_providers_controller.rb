class OtherProvidersController < ApplicationController
  
  def new
  	@user = User.new
  end

  def create
  	 auth = session[:omniauth]  
     user = User.where(email: params[:email]).first

     if user 
     	
     	if user.valid_password?(params[:password])
     		user.authentications.create(:provider => auth['provider'], :uid => auth['uid'])
     		sign_in_and_redirect(user)
	 	else
	 		redirect_to other_providers_new_path, :notice => "Password Email Combination Error!"
	 	end

	 else

	 	user = User.create!(email: params[:email], password: params[:password])
	 	if user.save
	 		user.authentications.create(:provider => session[:omniauth]['provider'], :uid => session[:omniauth]['uid'], :avatar => session[:omniauth]['info']['image'])
	 		sign_in_and_redirect(user)
	 	else
	 		redirect_to root_path, :notice => "Its Fuck up my Boy!!!"
	 	end

	 end

  end


end