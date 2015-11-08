require 'rake'

namespace :app do
  task :run do
    EMBER_PID = Process.spawn('cd ember && ./node_modules/.bin/ember serve --port=4200')
    RAILS_PID = Process.spawn('cd ruby && bundle exec puma --config config/puma.rb config.ru')

    trap 'INT' do
      puts 'Terminating Ember process...'
      Process.kill('SIGINT', EMBER_PID)
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
    # Ember
    puts 'Testing Ember...'
    system 'cd ember && ember test'
    # Ruby
    puts 'Testing Ruby...'
    system('cd ruby && rake')
    puts 'Done testing...!'
  end
end
