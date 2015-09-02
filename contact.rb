require_relative 'contact_database.rb'

class Contact
 
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end
 
  def to_s
    
  end
 
  ## Class Methods
  class << self
    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      new_contact = Contact.new(name, email)
      database_input = []
      new_user_id = "1" + (ContactDatabase.get_id.to_i + 1).to_s
      database_input[0] = new_user_id
      database_input[1] = new_contact.name
      database_input[2] = new_contact.email
      ContactDatabase.write_new_contact_to_file(database_input)
      puts "Your user id is #{new_user_id}."
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
    end
 
    def all
      # TODO: Return the list of contacts, as is
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
    end
    
  end
 
end

class Application

end

class Menu

  def initialize()
  end

  private

  ##Class Methods
  class << self
    def process_input(input, input_2)
      if input == "help"
        run_menu
      elsif input == "new"
        new_contact
      elsif input == "list"
        list_contact
      elsif input == "show"
        show_contact(input_2)
      elsif input == "find"
        find_contact(input_2)
      end
    end

    def run_menu
      puts "Here is a list of available commands:"
      puts "    new  - Create a new contact"
      puts "    list - List all contacts"
      puts "    show - Show a contact"
      puts "    find - Find a contact"
    end

    def new_contact
      puts "To create a new contact, please provide the follow:"
      puts "A user name:"
      new_username = gets.chomp
      puts "An email address:"
      new_email = gets.chomp
      Contact.create(new_username, new_email)      
    end

    def list_contact
      ContactDatabase.get_all_contacts
    end

    def show_contact(id)
      ContactDatabase.show_contact(id)
    end
    
    def find_contact(input)
      contact_list = CSV.open('contacts.csv', "r").readlines
      # wanted_contact = []
      matched = nil 
      contact_list.each do |line|
        if line.grep(input) != nil
        puts matched.inspect
      end
    end
      # end
        # if wanted_contact == nil 
        #   puts "Not found"
        # else 
          # puts matched.inspect
    end
  end
end 

