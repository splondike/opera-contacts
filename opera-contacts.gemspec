# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: opera-contacts 0.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "opera-contacts"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stefan Schneider-Kennedy"]
  s.date = "2014-01-31"
  s.description = "Parses the opera browser contacts file (ending in .adr) to a ruby data structure. This can then be exported to vCard or whatever."
  s.email = "code@stefansk.name"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "lib/opera-contacts.rb",
    "lib/opera-contacts/contacts.rb",
    "lib/opera-contacts/parser.rb",
    "spec/parser_spec.rb",
    "spec/test_files/broken_indentation.adr",
    "spec/test_files/detailed_contact.adr",
    "spec/test_files/missing_headers.adr",
    "spec/test_files/nested_contact.adr"
  ]
  s.homepage = "http://github.com/splondike/opera-contacts"
  s.licenses = ["BSD 2-Clause"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "Parse library for the Opera browser contacts file"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.0"])
  end
end

