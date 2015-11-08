require 'rake'

namespace :app do
  task :run do
    RAILS_PID = Process.spawn('cd ruby && bundle exec puma --config config/puma.rb config.ru')

    trap 'INT' do
      puts 'Terminating Rails process...'
      Process.kill('SIGINT', RAILS_PID)
      puts 'All processes terminated!'
      exit 0
    end

    loop do
      sleep 1
    end
  end

  task :test do
    puts 'Testing Ruby...'
    system('cd ruby && rake')
    puts 'Done testing...!'
  end
end
