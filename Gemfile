source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "ancestry"
gem "aws-sdk-rails"
gem "bootsnap", ">= 1.4.4", require: false
gem "carrierwave", "~> 2.0"
gem "config"
gem "devise"
gem "devise-i18n"
gem "dotenv-rails"
gem "fog-aws"
gem "jbuilder", "~> 2.7"
gem "kaminari"
gem "mini_magick"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.3"
gem "rails-i18n", "~> 6.0"
gem "sass-rails", ">= 6"
gem "slack-notifier"
gem "slack-ruby-client"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "annotate"
  gem "letter_opener_web", "~> 1.0"
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "rails-erd"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
