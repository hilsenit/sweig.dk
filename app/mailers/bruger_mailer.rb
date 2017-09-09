class BrugerMailer < Devise::Mailer
	helper :application # gives access to all helpers defined within `application_helper`.
	include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
	default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
	def confirmation_instructions(record, token, opts={})
		attachments.inline["email-haeder.png"] = File.read("#{Rails.root}/app/assets/images/email-header.png")
		attachments.inline["email-haeder-omvendt.png"] = File.read("#{Rails.root}/app/assets/images/email-header-omvendt.png")
	  headers["Custom-header"] = "Aktiver din bruger"
	  @username = record.username
	  opts[:from] = 'kontakt@sweig.dk'
	  opts[:reply_to] = 'kontakt@sweig.dk'
	  super	
	end
	def reset_password_instructions(record, token, opts={})
		attachments.inline["email-haeder.png"] = File.read("#{Rails.root}/app/assets/images/email-header.png")
		attachments.inline["email-haeder-omvendt.png"] = File.read("#{Rails.root}/app/assets/images/email-header-omvendt.png")
	  headers["Custom-header"] = "Nulstil dit kodeord"
	  opts[:from] = 'kontakt@sweig.dk'
	  opts[:reply_to] = 'kontakt@sweig.dk'
	  @username = record.username
	  super	
	end
	def unlock_instructions(record, token, opts={})
		attachments.inline["email-haeder.png"] = File.read("#{Rails.root}/app/assets/images/email-header.png")
		attachments.inline["email-haeder-omvendt.png"] = File.read("#{Rails.root}/app/assets/images/email-header-omvendt.png")
	  headers["Custom-header"] = "Lås din bruger op"
	  opts[:from] = 'kontakt@sweig.dk'
	  opts[:reply_to] = 'kontakt@sweig.dk'
	  @username = record.username
	  super	
	end
end
