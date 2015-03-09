class Authentication < ActiveRecord::Base
	belongs_to :user

	scope :image, ->(auth) { where(provider: auth['provider']).first.avatar }

end



