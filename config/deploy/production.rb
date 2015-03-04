# production.rb
set :rails_env,      'production'
set :deploy_env,     :rails_env
set :bundle_without,  [:development, :test]

set :deploy_to_application_name , 'prod'

set :repository, "git@github.com:dirtyev69/style.git"
set :branch, 'master'
set :deploy_to, "/var/www/#{deploy_to_application_name}"

set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

# Настраиваем ssh до сервера
#set :gateway, "guest@dev-02.snpdev.ru:10332"
server "5.101.99.155", :app, :web, :db, :primary => true

# Используем rvm
set :using_rvm, true
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
set :rvm_type, :user

# Авторизационные данные
set :user, "rails"
set :group, "rails"
set :password, 'jekan777'
set :use_sudo, false
set :keep_releases, 3

# Unicorn config
set :unicorn_config, "#{current_path}/config/unicorn.rb"

load '/config/deploy/tasks/tasks.rb'
