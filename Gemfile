source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5.rc.2'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'devise'
gem 'haml-rails'
gem 'jquery-rails'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'

group :development do
  gem 'ZenTest'
end

group :development, :test do
  gem 'faker'
  gem 'activerecord-spatialite-adapter'
  gem 'nifty-generators'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'sqlite3'
  gem 'spork', '0.9.0.rc9'
end

group :test do
  gem 'factory_girl_rails'
  gem 'mocha'
  gem 'webmock'
  gem 'webrat'
end

group :production do
  gem 'pg'
  gem 'thin'
end


