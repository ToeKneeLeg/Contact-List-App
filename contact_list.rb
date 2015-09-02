require_relative 'contact'
require_relative 'contact_database'
 
#Set direction when no parameter given  
if ARGV.empty?
  ARGV[0] = "Please type the word 'help' after the file name for menu." 
  puts ARGV[0]
end
if ARGV[1] == nil
  ARGV[1] = "NOT FOUND"
end

command_para = ARGV[1].clone
command = ARGV[0].clone
ARGV.clear

Menu.process_input(command, command_para)
# puts Menu.find_contact("tony")
# brr = ["one","two","three","four"]
# var = "two"
# crr = brr.grep(var)
# puts crr.inspect
# ContactDatabase.show_contact(12)

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets

