## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase
  class << self
    def get_id
      content = ContactDatabase.load_contacts
      content.length
    end

    def load_contacts
      CSV.open('contacts.csv', 'r').readlines.each{|file| file}
    end

    def show_contact(id)
      lines_in_array = ContactDatabase.load_contacts
      id_hash = {}
      lines_in_array.each do |arr|
        the_id = arr.shift
        the_rest = arr
        id_hash[the_id] = the_rest
      end
      if id_hash[id.to_s] != nil 
         puts id_hash[id.to_s]
      else
        puts "not found"
      end
    end

    def get_all_contacts
      file_name = "contacts.csv"
      CSV.open(file_name, 'r').readlines.each do |file|
        puts file.inspect
      end
        puts "---"
        puts ContactDatabase.get_id
    end

         
    def write_new_contact_to_file(write_to_file)
      file_name = "contacts.csv"
      CSV.open(file_name, "a") do |file|
        file << write_to_file
      end
    end
  end
end
