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

# Bundle config
set :bundle_binary, "bundle"
set :bundle_flags,  "--deployment"

require 'capistrano/ext/multistage'
require "bundler/capistrano"
# require "whenever/capistrano"
require "delayed/recipes"

# Unicorn config
set :unicorn_binary, "unicorn"


after "deploy:restart", "deploy:cleanup"
