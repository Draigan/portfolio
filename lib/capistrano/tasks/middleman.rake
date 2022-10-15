namespace :middleman do
  desc 'Echo PATH'
  task :echo_path do
    on roles(:all) do |host|
      within release_path do
        execute :echo, '$PATH'
      end  
    end
  end

  desc 'Install the Ruby version from .ruby-version if neccessary'
  task :install_ruby do
    on roles(:all) do |host|
      within release_path do
        execute :rbenv, :install, '-s', '--verbose'
      end  
    end
  end

  desc 'Rehash rbenv shims'
  task :rehash do
    on roles(:all) do |host|
      within release_path do
        execute :rbenv, :rehash
      end  
    end
  end

  desc 'Install bundler'
  task :install_bundler do
    on roles(:all) do |host|
      within release_path do
        execute :gem, :install, :bundler
      end  
    end
  end

  desc 'Bundle'
  task :bundle do
    on roles(:all) do |host|
      within release_path do
        execute :bundler, '--deployment', '--binstubs', '--without=development'
      end  
    end
  end

  desc 'Middleman build'
  task :build do
    on roles(:all) do |host|
      within release_path do
        execute :bundle, :exec, :middleman, :build
      end  
    end
  end

  desc 'Copy assets'
  task :copy_assets do
    on roles(:all) do |host|
      within release_path do
        execute :cp, '-a', 'source/assets/.', 'build/assets/'
      end  
    end
  end
end  

desc 'Middleman build steps'
task middleman: [
  'middleman:echo_path',
  'middleman:install_ruby',
  'middleman:rehash',
  'middleman:install_bundler',
  'middleman:rehash',
  'middleman:bundle',
  'middleman:build',
  'middleman:copy_assets'
]
