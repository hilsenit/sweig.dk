if Rails.env.development?

	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
	  address:              'smtp.gmail.com',
	  port:                 587,
	  domain:               'http://localhost:3000',
	  user_name:            ENV["SWEIG_GMAIL_USERNAME"],
	  password:             ENV["SWEIG_GMAIL_PASSWORD"],
	  authentication:       'plain',
	  enable_starttls_auto: true 
	}

elsif Rails.env.production?

	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
	  address:              'smtp.sendgrid.net',
	  port:                 587,
	  domain:               'heroku.com',
	  user_name:            ENV["SENDGRID_USERNAME"],
	  password:             ENV["SENDGRID_PASSWORD"],
	  authentication:       'plain',
	  enable_starttls_auto: true 
	}

end