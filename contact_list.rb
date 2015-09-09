require_relative 'setup'
 
# #Set direction when no parameter given  
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

Application.menu_input(command, command_para)

