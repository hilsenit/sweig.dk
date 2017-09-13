class RegistrationsController < Devise::RegistrationsController
	
	def new
		@head_title = "Opret dig her"		
		super
	end	
	private

	def after_sign_up_path_for(resource)	
		biblo_path(current_user.friendly_id)
	end
end
