module UsersHelper

	def if_active_helper path 
		"active" if current_page? path
	end 
	def published
		self.published? ? "Gør til kladde" : "Udgiv"
	end


end
