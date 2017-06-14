module WorksHelper
	def work_options_icon_helper user, work, arrow_value
		(link_to (fa_icon "angle-#{arrow_value}"), 
			user_work_toggle_status_path(user, work) ) + 
		(link_to (fa_icon "minus-square-o"), 
			user_work_path(user, work), method: "delete", data: {confirm: "Er du sikker på at du vil slette \"#{work.title}?\""})
	end
end
