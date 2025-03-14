Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://192.168.1.5:3000' 
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options]
    end
  end
  