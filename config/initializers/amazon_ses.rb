return unless Rails.env.production?

creds = Aws::Credentials.new(
  Settings.aws.access_key_id,
  Settings.aws.secret_access_key,
)

Aws::Rails.add_action_mailer_delivery_method(
  :ses,
  credentials: creds,
  region: Settings.aws.region,
)
