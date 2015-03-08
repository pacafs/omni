class RegistrationsController < Devise::RegistrationsController
  # def create
  #   super
  #   session[:omniauth] = nil unless @user.new_record?
  # end
  
  # private
  
  # def build_resource(*args)
  #   super
  #   if session[:omniauth]
  #     @user.omniauth(session[:omniauth])
  #     @user.valid?
  #   end
  # end	

  # protected

  # def update_resource(resource, params)
  #   resource.update_without_password(params)
  # end

end