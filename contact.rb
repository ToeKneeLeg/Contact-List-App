require_relative 'contact_database.rb'

class Contact
 
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end
 
  class << self
    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      new_contact = Contact.new(name, email)
      database_input = []

      new_user_id = "1" + (ContactDatabase.generate_id.to_i + 1).to_s
      database_input[0] = new_user_id
      database_input[1] = new_contact.name
      database_input[2] = new_contact.email
      ContactDatabase.write_new_contact_to_file(database_input)
      puts "Your user id is #{new_user_id}."
    end

    def to_string(input)
          puts "#{input[0]}: #{input[1]} (#{input[2]})"   
    end
 
    def find_contact(input)
      contact_list = CSV.open('contacts.csv', "r").readlines
      contact_list.each do |line|
        if line.grep(/#{input}/)[0] != nil
          puts to_string(line)
        end
      end
    end
 
    def list_all_contact
      ContactDatabase.get_all_contacts
    end
    
    def show_contact_by_id(id)
      ContactDatabase.show_contact(id)
    end

    def new_contact
      puts "To create a new contact, please provide the follow:"
      puts "A user name:"
      new_username = gets.chomp
      puts "An email address:"
      new_email = gets.chomp
      create(new_username, new_email)      
    end    
  end 
end

class Menu

  private

  class << self
    #to facilitate and redirect command from commandline inputs
    def process_input(command, option)
      if command == "help"
        run_menu
      elsif command == "new"
        Contact.new_contact
      elsif command == "list" 
        Contact.list_all_contact
      elsif command == "show"
        Contact.show_contact_by_id(option)
      elsif command == "find"
        Contact.find_contact(option)
      end
    end

    #to provide an interface for the menu when help is the input
    def run_menu
      puts "Here is a list of available commands:"
      puts "    new  - Create a new contact"
      puts "    list - List all contacts"
      puts "    show - Show a contact"
      puts "    find - Find a contact"
    end    
  end
end 

