# -*- coding: utf-8 -*-

require 'rspec/expectations'
include RSpec::Matchers

require 'opera-contacts'

def load_example(name)
  return File.open("spec/test_files/#{name}.adr", "r:UTF-8").read
end

describe "Parser" do
  describe "parse_s" do
    it "should parse contacts correctly" do
      detailed_contact = load_example("detailed_contact")

      parsed = OperaContacts.parse_s(detailed_contact)

      expect(parsed.count).to eql(1)
      contact = parsed.first
      expect(contact.id).to eql(11)
      expect(contact.name).to eql("root-contact")
      expect(contact.description).to eql("Notes\nAnd a new line")
      expect(contact.emails).to eql(["email@example.com", "additional@example.com", "emails@example.com"])
    end

    it "should handle nested structures" do
      nested_contact = load_example("nested_contact")

      parsed = OperaContacts.parse_s(nested_contact)

      expect(parsed.count).to eql(1)
      parent_folder = parsed.first
      expect(parent_folder.count).to eql(2)

      parent_child = parent_folder.find{|i| i.name == "child-of-parent-folder"}
      expect(parent_child).to be_true

      subfolder = parent_folder.find{|i| i.name == "subfolder"}
      expect(subfolder).to be_true
      expect(subfolder.count).to eql(1)
      expect(subfolder.first.name).to eql("child-of-subfolder")
    end

    it "should fail for missing headers" do
      missing_headers = load_example("missing_headers")
      expect {OperaContacts.parse_s(missing_headers)}.to raise_error
    end

    it "should fail for broken indentation" do
      broken_indentation = load_example("broken_indentation")
      expect {OperaContacts.parse_s(broken_indentation)}.to raise_error
    end
  end
end

# vim: ft=ruby et sw=2 ts=2 sts=2
