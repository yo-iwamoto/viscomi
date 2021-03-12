Rails.application.configure do
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.compile = false

  config.active_storage.service = :local

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  # メーラー設定
  host = 'vis-comi.herokuapp.com'
  config.action_mailer.default_url_options = { host: host }
  config.action_mailer.raise_delivery_errors = true

  # config.action_mailer.delivery_method = :letter_opener
  # smtpで送信したいときは↑をコメント、↓を解除
  config.action_mailer.delivery_method = :smtp

  # gmail
  # mail = ENV['MAIL_ADDRESS']
  # password = ENV['MAIL_PASSWORD']
  # config.action_mailer.smtp_settings = {
  #   enable_starttls_auto: true,
  #   port:                 '587',
  #   address:              'smtp.gmail.com',
  #   domain:               'gmail.com',
  #   user_name:            mail,
  #   password:             password,
  #   authentication:       :login
  # }

  # sendgrid
  api_key = ENV['VIS_SENDGRID_API_KEY']
  config.action_mailer.smtp_settings = {
    enable_starttls_auto: true,
    user_name:            'apikey',
    password:             api_key,
    port:                 '587',
    address:              'smtp.sendgrid.net',
    domain:               'heroku.com',
    authentication:       :plain
  }
end
