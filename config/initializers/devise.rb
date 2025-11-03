# frozen_string_literal: true

# Use this hook to configure devise mailer, warden hooks, and so forth.
# Many of these configuration options are set to sensible defaults.
# (https://github.com/heartcombo/devise/blob/main/lib/devise.rb)
Devise.setup do |config|
  config.mailer_sender = "please-change-me@example.com"

  require "devise/orm/active_record"

  config.case_insensitive_keys = %i[email]
  config.strip_whitespace_keys = %i[email]

  config.skip_session_storage = [:http_auth, :params_auth]

  config.stretches = Rails.env.test? ? 1 : 12

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 8..128

  config.email_regexp = URI::MailTo::EMAIL_REGEXP

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  # ==> Navigation configuration
  # Lists the formats that should be treated as navigational. Formats like
  # :html, should redirect to the sign in page when the user does not have
  # access, but formats like :xml or :json, should return 401.
  # The "*/*" below is required to match Internet Explorer requests.
  config.navigational_formats = ["*/*", :html, :turbo_stream]

  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  # config.omniauth :github, "APP_ID", "APP_SECRET", scope: "user,public_repo"

  # ==> Warden configuration
  # If you want to use other strategies, that are not supported by Devise, or
  # change the failure app, you can configure them inside the config.warden block.
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end
end
