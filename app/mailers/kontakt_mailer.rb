class KontaktMailer < ApplicationMailer
	default to: "kontakt@sweig.dk"

	def kontakt(email, emne, besked)
		@besked = besked
		mail(from: email, subject: emne)
	end


end
