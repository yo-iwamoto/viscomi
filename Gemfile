source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.7.2'
gem 'rails', '6.0.3.6'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
# vue-routerの挙動が不安定になる（原因は不明）ため、使用しない
# gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'image_processing', '1.9.3'
gem 'mini_magick', '4.9.5'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'faker', '2.1.2'
gem 'active_storage_validations', '0.8.2'
gem 'slim-rails'
gem 'html2slim'
gem 'rails-i18n'
gem 'aws-sdk-s3', '1.46.0', require: false
gem 'carrierwave', '~> 2.0'
gem 'fog-aws'
gem 'jwt', '~> 2.1.0'
gem 'devise'
gem 'activeadmin'
gem 'letter_opener_web', '~> 1.0'
gem 'active_decorator'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'sqlite3', '~> 1.4'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'factory_bot_rails'
  gem 'rails_best_practices'
  gem 'rubocop', '~> 0.83.0', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'foreman'
end
group :test do
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
group :production do
  gem 'pg', '1.1.4'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
