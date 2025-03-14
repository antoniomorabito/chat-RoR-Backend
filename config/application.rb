require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Chatapp
  class Application < Rails::Application
   
    config.load_defaults 8.0

   
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*' 
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options],
          expose: ['Authorization'],
          credentials: false
      end
    end
    

   
    config.api_only = false

   
    config.action_controller.default_protect_from_forgery = false

   
    config.middleware.use Rack::Head
    config.middleware.use Rack::ConditionalGet
    config.middleware.use Rack::ETag
    config.middleware.delete ActionDispatch::HostAuthorization
    config.action_dispatch.rescue_responses["ActionController::UnknownFormat"] = :not_acceptable
    config.middleware.delete ActionDispatch::ContentSecurityPolicy::Middleware
    config.middleware.delete ActionDispatch::PermissionsPolicy::Middleware

  end
end
