Rails.configuration.middleware.use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :any
  end
end