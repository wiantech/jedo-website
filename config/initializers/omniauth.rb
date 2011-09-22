Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '229205447093980', '4ce1973434603f73d7c231d99be772be' ,{:client_options => {:ssl => {:ca_path => '/etc/ssl/certs'}}}

end