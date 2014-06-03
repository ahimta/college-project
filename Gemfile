source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '~> 4.1.0'

gem 'sdoc', '~> 0.4.0', group: :doc

gem 'rails-i18n', '~> 4.0.2'

gem 'bcrypt', '~> 3.1.0'

gem 'grape', '~> 0.7.0'
gem 'grape-entity', '~> 0.4.2'

gem 'factory_girl_rails', '~> 4.4.1'
gem 'rack-cors', require: 'rack/cors'

group :development, :test do
  gem 'rspec-rails', '~> 2.14.2'
  gem 'sqlite3', '~> 1.3.9'
end

group :development do
  gem 'guard-rspec', '~> 4.2.8', require: false
  gem 'guard-bundler', '~> 2.0.0', require: false
  gem 'railroady', '~> 1.1.1'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'brakeman', '~> 2.4.3'
  gem 'rails_best_practices', '~> 1.15.2'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
end

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
  gem 'puma'
  gem 'pg'
end
