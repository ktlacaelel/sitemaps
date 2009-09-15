# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sitemaps}
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["kazuyoshi tlacaelel"]
  s.date = %q{2009-09-15}
  s.default_executable = %q{sitemaps}
  s.description = %q{
    Sitemaps provides an executable that will take a configuration yaml file.
    When runned it will download and gzip-compress your sitemaps ready for production!
    }
  s.email = %q{kazu.dev@gmail.com}
  s.executables = ["sitemaps"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/sitemaps",
     "lib/configuration.rb",
     "lib/generator.rb",
     "lib/invalid_configuration_error.rb",
     "lib/sitemaps.rb",
     "sitemaps.gemspec",
     "test/configuration_test.rb",
     "test/data/empty_configuration_file.yml",
     "test/data/generator_with_http_configuration_file.yml",
     "test/data/generator_with_port_configuration_file.yml",
     "test/data/invalid_configuration_file.yml",
     "test/data/no_domain_configuration_file.yml",
     "test/data/no_dump_dir_configuration_file.yml",
     "test/data/no_generator_configuration_file.yml",
     "test/data/no_port_configuration_file.yml",
     "test/data/no_targets_configuration_file.yml",
     "test/data/no_timeout_configuration_file.yml",
     "test/data/valid_configuration_file.yml",
     "test/data/valid_configuration_file2.yml",
     "test/generator_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/ktlacaelel/sitemaps}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Setup a config yaml file. I will download & compress your sitemaps!}
  s.test_files = [
    "test/configuration_test.rb",
     "test/generator_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<builder>, [">= 2.1.2"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<builder>, [">= 2.1.2"])
  end
end
