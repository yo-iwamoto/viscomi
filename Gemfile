source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.6.6'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'image_processing', '1.9.3'
gem 'mini_magick', '4.9.5'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'faker', '2.1.2'
gem 'active_storage_validations', '0.8.2'
gem 'slim-rails'
gem 'html2slim'
gem 'rubocop', '~> 0.83.0', require: false
gem 'rubocop-rails', require: false
gem 'rubocop-performance', require: false
gem 'rails-i18n'
gem 'aws-sdk-s3', '1.46.0', require: false
gem 'carrierwave', '~> 2.0'
gem 'fog-aws'
gem 'jwt', '~> 2.1.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '~> 1.4'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'spring-commands-rspec'
end
group :development do
  gem 'web-console', '>= 3.3.0'
end
group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
group :production do
  gem 'pg', '1.1.4'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
