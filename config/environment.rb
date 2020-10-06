# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# => Heroku addon Mailgun
ActionMailer::Base.smtp_settings = {
  :port           => ENV['MAILGUN_SMTP_PORT'],
  :address        => ENV['MAILGUN_SMTP_SERVER'],
  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  :domain         => 'shielded-fortress-06087.herokuapp.com',
  :authentication => :plain,
}
ActionMailer::Base.delivery_method = :smtp