puts "You called the #{$0} script"
print "You passed the arguments "
i = 0
ARGV.each do |arg|
  if ARGV.last != arg
    print arg + ", "
  else
    print arg + ".\n"
  end
end