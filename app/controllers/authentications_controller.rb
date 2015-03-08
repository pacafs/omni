class AuthenticationsController < ApplicationController

  def create	

	    auth = request.env["omniauth.auth"]
		authentication = Authentication.find_by(provider: auth['provider'], uid: auth['uid'])

			  if authentication
			   	
		   		flash[:notice] = "Signed in successfully."
		    	sign_in_and_redirect(:user, authentication.user)

			  elsif current_user
			  
			    current_user.authentications.create!(:provider => auth['provider'], :uid => auth['uid'])
			    flash[:notice] = "Authentication successful."
			    redirect_to authentications_url	

			  elsif !authentication && auth['provider'] == 'facebook'
			  
			    	user = User.find_by_email(auth['info']['email'])
				    
				    if user
		  			    user.authentications.create!(:provider => auth['provider'], :uid => auth['uid'])
				    	sign_in_and_redirect(user)
				    else
				    	session[:omniauth] = auth.except('extra')
		  				redirect_to other_providers_new_pat
				    end
			  
			   else
				
				 session[:omniauth] = auth.except('extra')
	  			 redirect_to other_providers_new_path

			   end

  end

  def destroy
	  @authentication = current_user.authentications.find(params[:id])
	  @authentication.destroy
	  flash[:notice] = "Successfully destroyed authentication."
	  redirect_to authentications_url
  end

end




