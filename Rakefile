# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

spec = Gem::Specification.find_by_name 'geo_importer'
load "#{spec.gem_dir}/Rakefile"
