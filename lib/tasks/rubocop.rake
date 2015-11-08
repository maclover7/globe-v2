desc 'Run Rubocop code style analyzer'
task :rubocop do
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end
