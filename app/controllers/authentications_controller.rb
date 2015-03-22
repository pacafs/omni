class AuthenticationsController < ApplicationController

  def create	

    auth = request.env["omniauth.auth"]
    session[:omniauth] = auth.except('extra')
	authentication = Authentication.find_by(provider: auth['provider'], uid: auth['uid'])

		  if authentication

	   		flash[:notice] = "Signed in successfully."
	    	sign_in_and_redirect(:user, authentication.user)

		  elsif current_user
		  
		    current_user.create_auth_to_user(auth)
		    flash[:notice] = "Authentication successful."
		    redirect_to authentications_url	

		  elsif !authentication
		  
		    	user = User.find_by_email(auth['info']['email'])
			    
			    if user
	  			    user.create_auth_to_user(auth)
			    	sign_in_and_redirect(user)
			    else
					redirect_to other_providers_new_path
			    end

		  end

  end


  def destroy
	  @authentication = current_user.authentications.find(params[:id])
	  @authentication.destroy
	  session[:omniauth] = nil
	  flash[:notice] = "Successfully destroyed authentication."
	  redirect_to authentications_url
  end


end