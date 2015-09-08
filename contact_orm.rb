require 'pg'

class Contact_ORM
 
  attr_accessor :f_name, :l_name, :email
  attr_reader :id

  def initialize(f_name, l_name, email, id = nil)
    @f_name = f_name
    @l_name = l_name
    @email = email
    @id = id
  end

  #allows us to insert/update a row in the database
  def save
    sql = "INSERT INTO contacts (f_name, l_name, email) VALUES ($1, $2, $3);"
    self.class.connect.exec_params(sql, [@f_name, @l_name, @email])
    true
  rescue PG::Error => e
    false
    puts e
  end

  def destroy
    sql = "DELETE FROM contacts WHERE id = $1"
    self.class.connect.exec_params(sql, [@id])
  end
 
  class << self

    #to simplify connection to database
    def connect
      PG.connect(dbname: "contact_list")
    end

    #SELECT a contact row from database by id and return a Contact instance
    def find_by_id(id)
      sql = "SELECT * FROM contacts WHERE id = $1;"
      connect.exec_params(sql, [id]) do |response|
        result = response.values[0]
        if result.nil?
          puts "Contact Not Found"
        else
        Contact_ORM.new(result[1], result[2], result[3], result[0])
        end
      end
    rescue PG::Error
      nil
    end

    #to show all the records in the database
    def show_all
      sql = "SELECT * FROM contacts"
      retrieved_contacts = []
      connect.exec(sql) do |response| response.values.each do |row|
        retrieved_contacts << Contact_ORM.new(row[1], row[2], row[3], row[0])
        end
      end
      if retrieved_contacts[0] != nil
        retrieved_contacts
      else
        puts "No record found"
      end
    end

    #allows us to find all record with the given last name
    def find_all_by_lastname(l_name)
      sql = "SELECT * FROM contacts AS c WHERE c.l_name = $1;"
      find_all_function(sql, l_name)
    end

    #allows us to find all record with the given first name
    def find_all_by_firstname(f_name)
      sql = "SELECT * FROM contacts AS c WHERE c.f_name = $1;"
      find_all_function(sql, f_name)
    end

    #allows us to find all record with the given email
    def find_by_email(email)
      sql = "SELECT * FROM contacts AS c WHERE c.email = $1;"
      find_all_function(sql, email)
    end

    #to allow other find_all methods to reuse this function
    def find_all_function(sql, input)
      retrieved_contacts = []
      connect.exec_params(sql, [input]) do |response| response.values.each do |row|
        retrieved_contacts << Contact_ORM.new(row[1], row[2], row[3], row[0])
        end
      end
      if retrieved_contacts[0] != nil
        retrieved_contacts
      else
        puts "No record found"
      end
    end
  end
end
