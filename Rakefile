require 'bundler/gem_tasks'
require 'rdoc/task'
require 'rake/testtask'

Rake::RDocTask.new do |rdoc|
  rdoc.main      = 'README.md'

  if rdoc.respond_to? :markup=
    rdoc.markup  = 'markdown'
  end
  rdoc.generator = 'fivefish'

  rdoc.rdoc_files.include(rdoc.main, 'lib/**/*.rb')
end

Rake::TestTask.new do |test|
  test.libs.push 'test'
  test.pattern = 'test/**/test_*.rb'
  test.warning = true
  test.verbose = true
end

desc 'Generates a coverage report'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].execute
end
