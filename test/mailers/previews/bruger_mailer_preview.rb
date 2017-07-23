# Preview all emails at http://localhost:3000/rails/mailers/bruger_mailer
class BrugerMailerPreview < ActionMailer::Preview
	# https://github.com/plataformatec/devise/wiki/How-To:-Use-custom-mailer
	def confirmation_instructions
	    MyMailer.confirmation_instructions(User.first, "faketoken", {})
	  end

	  def reset_password_instructions
	    MyMailer.reset_password_instructions(User.first, "faketoken", {})
	  end

	  def unlock_instructions
	    MyMailer.unlock_instructions(User.first, "faketoken", {})
	  end
end
