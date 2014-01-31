# -*- coding: utf-8 -*-

module OperaContacts
class Item
  attr_accessor :id, :name, :created, :description
  def initialize(id, name, created=Time.new, description='')
    @id = id
    @name = name
    @created = created
    @description = description
  end
end

module Collection
  attr :items
  def <<(item)
    @items = [] if @items.nil?
    @items << item
  end

  def folders
    return self.find_all{|i| i.is_a? ContactFolder}
  end

  def contacts
    return self.find_all{|i| i.is_a? Contact}
  end

  include Enumerable
  def each(&block)
    @items = [] if @items.nil?
    @items.each(&block)
  end
end

# A parsed opera contacts file. Treat it as an Enumerable (.each, .map etc.)
#
# Example of use:
# 
#     collection = ContactCollection.new()
#     folder = ContactFolder.new(123, "folder-name")
#     collection << folder
#     collection.map{|i| i.name} # ["folder-name"]
#     collection.folders.map{|i| i.name} # ["folder-name"]
#     collection.contacts # []
class ContactCollection
  include Collection
end

# A single contact in the file. Contains details like emails, phone etc.
# Type of Item.
class Contact < Item
  attr_accessor :homepage, :phone, :fax, :emails, :postal_address
end

# A folder which can contain Contact and ContactFolder
# (use Enumerable functions like .map). Type of Item.
#
# Example of use:
# 
#     folder = ContactFolder.new(321, "folder-name")
#     contact = Contact.new(123, "contact-name")
#     folder << contact
#     folder.map{|i| i.name} # ["contact-name"]
#     collection.contacts.map{|i| i.name} # ["contact-name"]
#     collection.folders # []
class ContactFolder < Item
  include Collection
end
end

# vim: ft=ruby et sw=2 ts=2 sts=2
