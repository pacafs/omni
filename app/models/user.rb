class User < ActiveRecord::Base
  has_many :authentications, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   def create_auth_to_user(auth)
   	  authentications.create(:provider => auth['provider'], :uid => auth['uid'])
   end

   def self.create_user(email, password)
   	  create(email: email, password: password)
   end

end


