class OtherProvidersController < ApplicationController

  def new
  	@user = User.new
  	@auth = session[:omniauth]
  end

  def create
  	 auth = session[:omniauth]  
     user = User.where(email: params[:email]).first


    if user

       	if user.valid_password?(params[:password])
       		 user.create_auth_to_user(auth)
       		 sign_in_and_redirect(user)
  	  	else
  	 		   redirect_to other_providers_new_path, :notice => "Invalid password/email combination!"
  	  	end

	  else

    	 	user = User.create_user(params[:email], params[:password])

    	 	if user.save
    	 		user.create_auth_to_user(auth)
    	 		sign_in_and_redirect(user)
    	 	else
    	 		redirect_to root_path, :notice => "Something went wrong!"
    	 	end

	  end


  end

end

