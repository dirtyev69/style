# encoding: utf-8
set :stages, %w(development testing production)
set :default_stage, "production"

set :application, "prod"

set :git_application_name       , 'prod'
set :deploy_to_application_name , application

set :symlinks,  [
                  { :label => :db, :path => 'config/database.yml' },
                ]

# Capistrano config
set :scm, :git
set :copy_exclude, [".git"]
set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false

set :shared_children, shared_children + %w{public/uploads}

# Bundle config
set :bundle_binary, "bundle"
set :bundle_flags,  "--deployment"

set :ssh_options, {
  forward_agent: true,
  paranoid: true,
  keys: "~/.ssh/id_rsa_prod"
}

require 'capistrano/ext/multistage'
require "bundler/capistrano"
# require "whenever/capistrano"
require "delayed/recipes"

# Unicorn config
set :unicorn_binary, "unicorn"


after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :cope_with_git_repo_relocation do
    run "if [ -d #{shared_path}/cached-copy ]; then cd #{shared_path}/cached-copy && git remote set-url origin #{repository}; else true; fi"
  end
end

before "deploy:update_code", "deploy:cope_with_git_repo_relocation"
