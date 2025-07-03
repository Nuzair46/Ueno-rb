source "https://rubygems.org"

ruby File.read(File.expand_path(".ruby-version", __dir__)).strip

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"

# For background jobs
gem "sidekiq"
gem "redis"

# Environment variables management
gem "config"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

gem "tzinfo-data", platforms: %i[ windows jruby ]
# gem "rack-cors"

gem "net-ssh"
gem "ed25519"
gem "bcrypt_pbkdf"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "pry-byebug"
end

group :test do
  gem "minitest"
  gem "minitest-ci"
  gem "simplecov", require: false
  gem "faker"
  gem "mocha"
end
