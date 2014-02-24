Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, '3278706e88c54e92ae3e1e88704b52d6', '420df733a929474080e76408ca8b6837'
end