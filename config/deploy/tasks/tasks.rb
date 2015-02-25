#tasks.rb

require 'bundler/capistrano'
require 'rvm/capistrano' if using_rvm == true

# set :whenever_command, 'bundle exec whenever'
# set :whenever_environment, defer { stage }
# set :whenever_identifier, defer { "#{application}_#{stage}" }
# require 'whenever/capistrano'

# Unicorn tasks
namespace :unicorn do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{try_sudo} #{bundle_binary} exec #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "if [ -e #{unicorn_pid} ]; then #{try_sudo} kill `cat #{unicorn_pid}`; else echo '#{unicorn_pid} does not exists'; fi"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "if [ -e #{unicorn_pid} ]; then #{try_sudo} kill -s QUIT `cat #{unicorn_pid}`; else echo '#{unicorn_pid} does not exists'; fi"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "if [ -e #{unicorn_pid} ]; then #{try_sudo} kill -s USR2 `cat #{unicorn_pid}`; else echo '#{unicorn_pid} does not exists'; fi"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end

namespace :deploy do
  task :setup_solr_data_dir do
    run "mkdir -p #{shared_path}/solr/data"
  end
end

namespace :solr do
  desc "start solr"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec sunspot-solr start --port=8982 --data-directory=#{shared_path}/solr/data --pid-dir=#{shared_path}/pids"
  end
  desc "stop solr"
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec sunspot-solr stop --port=8982 --data-directory=#{shared_path}/solr/data --pid-dir=#{shared_path}/pids"
  end
  desc "reindex the whole database"
  task :reindex, :roles => :app do
    stop
    run "rm -rf #{shared_path}/solr/data"
    start
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:reindex"
  end
end


# Symlinks
namespace :symlink do
  desc "Setup symlinks"
  task :setup, :except => { :no_release => true } do
    symlinks.each do |symlink|
      symlink_path = symlink[:path]

      dir_path = /^(.*)\/.*$/.match(symlink_path)[1]
      run "mkdir -p #{shared_path}/#{dir_path} && touch #{shared_path}/#{symlink[:path]}"
    end
  end

  desc "Upload symlink files"
  task :local_upload, :except => { :no_release => true } do
    symlinks.each do |symlink|
      symlink_path = symlink[:path]
      upload symlink_path, "#{shared_path}/#{symlink[:path]}" if File.file?(symlink_path)
    end
  end

  desc <<-DESC
    [internal] Updates the symlinks to the just deployed release.
  DESC
  task :symlink, :except => { :no_release => true } do
    symlinks.each do |symlink|
      run "ln -nfs #{shared_path}/#{symlink[:path]} #{release_path}/#{symlink[:path]}"
    end
  end
end

after 'deploy:setup', 'deploy:setup_solr_data_dir'
after "deploy:setup",           "symlink:setup"   unless fetch(:skip_db_setup, false)
after "deploy:finalize_update", "symlink:symlink"
after "deploy:start",           "unicorn:start"
after "deploy:stop",            "unicorn:stop"
after "deploy:restart",         "unicorn:restart"
after "deploy:restart",         "deploy:cleanup"