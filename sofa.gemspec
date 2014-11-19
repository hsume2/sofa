# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sofa"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Henry Hsu"]
  s.date = "2013-01-22"
  s.description = "A simple Ruby library for the TVRage API."
  s.email = "henry@qlane.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".document",
    ".yardopts",
    "LICENSE",
    "README.md",
    "Rakefile",
    "doc/Sofa.html",
    "doc/Sofa/Mapping.html",
    "doc/Sofa/Mapping/ClassMethods.html",
    "doc/Sofa/Mapping/InstanceMethods.html",
    "doc/Sofa/TVRage.html",
    "doc/Sofa/TVRage/Episode.html",
    "doc/Sofa/TVRage/Schedule.html",
    "doc/Sofa/TVRage/Season.html",
    "doc/Sofa/TVRage/Show.html",
    "doc/Sofa/TVRage/Show/ShowNotFound.html",
    "doc/Sofa/Version.html",
    "doc/_index.html",
    "doc/class_list.html",
    "doc/css/common.css",
    "doc/css/full_list.css",
    "doc/css/style.css",
    "doc/file.README.html",
    "doc/file_list.html",
    "doc/index.html",
    "doc/js/app.js",
    "doc/js/full_list.js",
    "doc/js/jquery.js",
    "doc/method_list.html",
    "doc/top-level-namespace.html",
    "lib/sofa.rb",
    "lib/sofa/mapping.rb",
    "lib/sofa/tvrage.rb",
    "lib/sofa/tvrage/episode.rb",
    "lib/sofa/tvrage/schedule.rb",
    "lib/sofa/tvrage/season.rb",
    "lib/sofa/tvrage/show.rb",
    "lib/sofa/version.rb",
    "sofa.gemspec",
    "spec/fixtures/tvrage/cases/castle.xml",
    "spec/fixtures/tvrage/cases/community.xml",
    "spec/fixtures/tvrage/cases/live_with_regis_and_kelly.xml",
    "spec/fixtures/tvrage/episode_info.xml",
    "spec/fixtures/tvrage/episode_list.xml",
    "spec/fixtures/tvrage/episode_list_one_season.xml",
    "spec/fixtures/tvrage/episode_list_two_episodes.xml",
    "spec/fixtures/tvrage/full_schedule.xml",
    "spec/fixtures/tvrage/full_show_info.xml",
    "spec/fixtures/tvrage/quickinfo.html",
    "spec/fixtures/tvrage/quickinfo_missing.html",
    "spec/fixtures/tvrage/search.xml",
    "spec/fixtures/tvrage/show_info.xml",
    "spec/fixtures/tvrage/show_info_blank.xml",
    "spec/fixtures/tvrage/single_episode.xml",
    "spec/sofa/mapping_spec.rb",
    "spec/sofa/tvrage/cases_spec.rb",
    "spec/sofa/tvrage/episode_spec.rb",
    "spec/sofa/tvrage/schedule_spec.rb",
    "spec/sofa/tvrage/season_spec.rb",
    "spec/sofa/tvrage/show_spec.rb",
    "spec/sofa/version_spec.rb",
    "spec/sofa_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/hsume2/sofa"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A Ruby library for the TVRage API."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<crack>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<crack>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<crack>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end

