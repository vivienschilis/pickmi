set :application, "pickmi"

set :deploy_to, "/var/apps/#{application}"

set :repository, "git://github.com/andreareginato/pickmi.git"
set :scm, :git
set :branch, "master"
set :repository_cache, "git_master"
set :git_enable_submodules, 1
set :deploy_via, :remote_cache

role :app, "pickmi.mikamai.com"
role :web, "pickmi.mikamai.com"
role :db,  "pickmi.mikamai.com", :primary => true

set :user, "rails"
set :password, "rails111"

deploy.task :start do 
end

deploy.task :restart do
  run "touch #{current_path}/tmp/restart.txt"
end