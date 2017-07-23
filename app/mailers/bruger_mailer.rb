class BrugerMailer < Devise::Mailer
	helper :application # gives access to all helpers defined within `application_helper`.
	include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
	default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views


	def confirmation_instructions(record, token, opts={})
	  headers["Custom-header"] = "Mail fra Sweig"
	  opts[:from] = 'kontakt@sweig.dk'
	  opts[:reply_to] = 'kontatk@sweig.dk'
	  super
	end


end
