class Contact < ActiveRecord::Base
  validates :f_name, presence: true
  validates :l_name, presence: true
  validates :email, presence: true
end 
 
class Application

  private

  class << self
    #to facilitate and redirect command from commandline inputs
    def menu_input(command, option)
      if command == "help"
        run_menu
      elsif command == "new"
        new_contact
      elsif command == "list" 
        list_all(Contact.all)
      elsif command == "show"
        to_string(Contact.find(option))
      elsif command == "find"
        find_contact(option)
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

    def new_contact
      puts "To create a new contact, please provide the follow:"
      puts "A user's first name:"
      new_user_fname = gets.chomp
      puts "A user's last name:"
      new_user_lname = gets.chomp
      puts "An email address:"
      new_email = gets.chomp
      new_contact = Contact.create!(f_name: new_user_fname, l_name: new_user_lname, email: new_email)
      puts
      puts "Your new id is #{new_contact.id}."
      puts
    end

    def find_contact(input)
      arr_of_contact_objects = Contact.all
      contact_list = []

      arr_of_contact_objects.each do |object|
          contact_list << ["#{object.id}: #{object.f_name} #{object.l_name} (#{object.email})"]
      end

      contact_list.each do |line|
        if line.grep(/#{input}/)[0] != nil
          puts line
        end
      end
    end

    def list_all(input)
      input.each do |object|
        to_string(object)
      end
    end

    def to_string(object)
      puts "#{object.id}: #{object.f_name} #{object.l_name} (#{object.email})"
    end
  end
end 
