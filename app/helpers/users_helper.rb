module UsersHelper


	def published
		self.published? ? "Gør til kladde" : "Udgiv"
	end


end
