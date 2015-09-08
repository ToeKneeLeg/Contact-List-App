## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase
  class << self

    #to generate a new id for the line based on the total number of lines
    def generate_id
      content = load_contacts
      content.length
    end

    #returns the array of the array of contacts
    def load_contacts
      CSV.open('contacts.csv', 'r').readlines.each{|file| file}
    end
    
    #parse the array into hash in order to search by id
    def show_contact(id)
      contacts_in_array = load_contacts
      contacts = {}
      contacts_in_array.each do |contact|
        id_from_array = contact.shift
        data_from_array = contact
        contacts[id_from_array] = data_from_array
      end
      if contacts[id.to_s] != nil 
         puts contacts[id.to_s]
      else
        puts "not found"
      end
    end

    #lists all contact in a user friendly format
    def get_all_contacts
      info = load_contacts
        info.each do |arr|
          puts "#{arr[0]}: #{arr[1]} #{arr[2]} (#{arr[3]})"
      end
        puts "---"
        puts "#{generate_id} records total"
    end

    #allows us to writes input into the CSV file    
    def write_new_contact_to_file(write_to_file)
      file_name = "contacts.csv"
      CSV.open(file_name, "a") do |file|
        file << write_to_file
      end
    end
  end
end
