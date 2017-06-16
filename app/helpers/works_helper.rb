module WorksHelper

	def original_url_helper
	  url_for(:only_path => false)
	end
	
	def work_options_icon_helper user, work, arrow_value
	
		(link_to (fa_icon "angle-#{arrow_value}"), 
			user_work_toggle_status_path(user, work), class: "edit-icons", titel: arrow_value == "up" ? "Udgiv" : "Gør til kladde" ) + 
		(link_to (fa_icon "trash-o"), 
			user_work_path(user, work), class: "edit-icons", titel: "Slet værk", method: "delete", data: {confirm: "Er du sikker på at du vil slette \"#{work.title}?\""}) + 
		(link_to (fa_icon "pencil"), edit_user_work_path(user, work), class: "edit-icons", titel: "Rediger værk")
	end

	def is_work_already_saved_helper? current_user_saved_works, work
		current_user_saved_works.each do |saved_work| 
			if saved_work.work_id == work.id
				return true
			end
		end 
		false
	end
end
