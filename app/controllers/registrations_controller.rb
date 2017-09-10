class RegistrationsController < Devise::RegistrationsController
	
	private

	def after_sign_up_path_for(resource)	
		biblo_path(current_user.friendly_id)
	end
end
