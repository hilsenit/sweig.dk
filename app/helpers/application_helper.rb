module ApplicationHelper
	def set_title
		default = "Sweig"
		if @page_title
			default + " | " + @page_title
		else
			default
		end
	end

	def alert_notice_helper
		if flash[:notice]
			content_tag :div, flash[:notice], class: ""
		elsif flash[:error]
			content_tag :div, flash[:error], class: ""
		end
	end
	def session_helper_social
		if session[:social] 
			social_message = "Thank you for visiting from #{session[:social]}"
			content_tag :div, social_message, class: "callout succes text-center"
		end
	end

end
