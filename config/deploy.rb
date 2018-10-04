# Change these
server '159.203.188.191', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:ferrettim/nerdylegion.git'
set :application,     'nerdylegion'
set :user,            'deploy'
set :puma_threads,    [1, 6]
set :puma_workers,    1

# Don't change these unless you know what you're doing
set :pty,             false
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix:///home/deploy/apps/nerdylegion/shared/tmp/sockets/nerdylegion-puma.sock"
set :puma_state,      "/home/deploy/apps/nerdylegion/shared/tmp/pids/puma.state"
set :puma_pid,        "/home/deploy/apps/nerdylegion/shared/tmp/pids/puma.pid"
set :puma_access_log, "/home/deploy/apps/nerdylegion/current/log/puma.error.log"
set :puma_error_log,  "/home/deploy/apps/nerdylegion/current/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
append :linked_files, "config/master.key"

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 6

## Linked Files & Directories (Default None):
# set :linked_files, %w{/home/deploy/apps/nerdylegion/shared/config/secrets.yml}
#set :linked_files, %w{config/database.yml config/application.yml}
#set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
#set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir /home/deploy/apps/nerdylegion/shared/tmp/sockets -p"
      execute "mkdir /home/deploy/apps/nerdylegion/shared/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc "Link shared files"
  task :symlink_config_files do
    on roles(:app) do
      symlinks = {
        "/home/deploy/apps/nerdylegion/shared/config/local_env.yml" => "#{release_path}/config/local_env.yml"
      }
      execute symlinks.map{|from, to| "ln -nfs #{from} #{to}"}.join(" && ")
    end
  end

  before :starting,     :check_revision
  before 'deploy:assets:precompile', :symlink_config_files
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
