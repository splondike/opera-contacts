# -*- coding: utf-8 -*-

require 'opera-contacts/contacts'

module OperaContacts
  # Parses the given string containing Hotlist formatted contacts
  # to a ContactCollection.
  #
  # @param hotlist_string A UTF8 string containing the Hotlist info
  # @return A ContactCollection containing the parse result of hotlist_string
  def OperaContacts.parse_s(hotlist_string)
    return ContactsParser.new.parse_s(hotlist_string)
  end

  class ContactsParser
    def parse_s(hotlist_string)
      lines = hotlist_string.lines
      (meta, remaining_lines) = extract_meta(lines)
      items = extract_items(remaining_lines)
      return build_structure(meta, items)
    end

    def extract_meta(lines)
      #TODO: Not sure how to turn this into split_at(lines) do |l|...
      (meta, remaining_lines) = split_at(lines, lambda{|l| l.strip != ""})
      if meta.count < 1 or not meta.first.start_with?("Opera Hotlist")
        raise "File broken (missing meta)"
      end
      return meta, remaining_lines
    end

    # Divide an array into two parts based on a block
    # TODO: Find built in function for this
    def split_at(arr, predicate)
      return arr.take_while(&predicate), arr.drop_while(&predicate)
    end

    def extract_items(lines)
      rtn = []
      remaining = lines

      def try_next_if_nil(*opts)
        opts.each do |opt|
          result = opt.call()
          if not result.nil?
            return result
          end
        end

        return nil
      end

      while remaining != []
        (item, remaining) = try_next_if_nil(
          lambda{parse_empty_line(remaining)},
          lambda{parse_item(remaining)},
          lambda{parse_folder_end(remaining)},
          lambda{fail "Parse error."}
        )
        rtn << item if item
      end

      return rtn
    end

    def parse_empty_line(lines)
      if lines.first.strip == ""
        return nil, lines[1..-1]
      else
        return nil
      end
    end

    def parse_folder_end(lines)
      if lines.first.strip == "-"
        end_folder = {
          :type=> "end folder",
          :data=>{}
        }
        return end_folder, lines[1..-1]
      else
        return nil
      end
    end

    def parse_item(lines)
      return nil unless lines.first.start_with? "#"

      type = lines.first
      item = {
        :type => lines.first.strip,
        :data => {},
      }

      not_finished = true
      rest = lines[1..-1]
      while rest != [] and not_finished do
        line = rest.first
        if line.start_with? "\t"
          (key, value) = line[1..-1].split("=", 2)
          item[:data][key] = add_newlines(value).strip
          rest = rest[1..-1]
        else
          not_finished = false
        end
      end
      return item, rest
    end

    # Turn's Hotlist's newlines into the conventional character
    def add_newlines(string)
      return string.gsub("\x02\x02", "\n")
    end

    def build_structure(meta, item_hashes)
      collection = ContactCollection.new
      build_collection!(collection, item_hashes)
      return collection
    end

    # Recursively build a tree structure from item_hashes and add it to parent
    def build_collection!(parent, item_hashes)
      remaining = item_hashes
      not_finished = true
      while remaining != [] and not_finished do
        item_hash = remaining.first
        remaining = remaining[1..-1]

        case item_hash[:type]
        when "#CONTACT"
          contact = build_contact(item_hash)
          parent << contact
        when "#FOLDER"
          folder = build_folder(item_hash)
          parent << folder
          remaining = build_collection!(folder, remaining)
        when "end folder"
          not_finished = false
        else
          raise "Unknown type: #{item_hash[:type]}"
        end
      end

      return remaining
    end

    def build_contact(item_hash)
      data = item_hash[:data]
      id = Integer(data["ID"])
      contact = Contact.new(id, data["NAME"],
                            parse_date(data["CREATED"]), 
                            data["DESCRIPTION"])
      contact.homepage = data["URL"] if data["URL"]
      contact.phone = data["PHONE"] if data["PHONE"]
      contact.fax = data["FAX"] if data["FAX"]
      contact.postal_address = data["POSTALADDRESS"] if data["POSTALADDRESS"]
      #Strip off the newlines left by lines
      contact.emails = data["MAIL"].lines.map{|l| l.strip} if data["MAIL"]
      return contact
    end

    def build_folder(item_hash)
      data = item_hash[:data]
      folder = ContactFolder.new(data["ID"], data["NAME"],
                                 parse_date(data["CREATED"]), 
                                 data["DESCRIPTION"])
      return folder
    end

    def parse_date(timestamp_string)
      timestamp = Integer(timestamp_string)
      return Time.at(timestamp)
    end
  end
end

# vim: ft=ruby et sw=2 ts=2 sts=2
