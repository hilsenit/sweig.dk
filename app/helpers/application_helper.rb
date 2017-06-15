module ApplicationHelper
	def original_url_helper
	  request.original_url
	end

	def set_title_helper
		default = "Sweig"
		if @page_title
			default + " | " + @page_title
		else
			default
		end
	end

	def alert_notice_helper
		if flash[:notice]
			content_tag :div, flash[:notice], class: "notice"
		elsif flash[:error]
			content_tag :div, flash[:error], class: "alert"
		end
	end
	
	def session_helper_social
		if session[:social] 
			social_message = "Thank you for visiting from #{session[:social]}"
			content_tag :div, social_message, class: "callout succes text-center"
		end
	end

	# For DEVISE MODAL
	def resource_name
	   :user
	 end

	 def resource
	   @resource ||= User.new
	 end

	 def devise_mapping
	   @devise_mapping ||= Devise.mappings[:user]
	 end

end
