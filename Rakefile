require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  require 'lib/sofa/version'
  Jeweler::Tasks.new do |gem|
    gem.name = "sofa"
    gem.version = Sofa::Version::STRING
    gem.summary = %Q{A Ruby library for the TVRage API.}
    gem.description = %Q{A simple Ruby library for the TVRage API.}
    gem.email = "henry@qlane.com"
    gem.homepage = "http://github.com/hsume2/sofa"
    gem.authors = ["Henry Hsu"]
    gem.add_dependency "httparty"
    gem.add_dependency "crack"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "mocha"
    gem.add_development_dependency "fakeweb"
    gem.add_development_dependency "yard", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
  spec.rcov_opts = %w{--exclude spec/*,gems/*}
end

task :spec => :check_dependencies

begin
  require 'reek/adapters/rake_task'
  Reek::RakeTask.new do |t|
    t.fail_on_error = true
    t.verbose = false
    t.source_files = 'lib/**/*.rb'
  end
rescue LoadError
  task :reek do
    abort "Reek is not available. In order to run reek, you must: sudo gem install reek"
  end
end

begin
  require 'roodi'
  require 'roodi_task'
  RoodiTask.new do |t|
    t.verbose = false
  end
rescue LoadError
  task :roodi do
    abort "Roodi is not available. In order to run roodi, you must: sudo gem install roodi"
  end
end

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
