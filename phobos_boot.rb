# Use this file to load your code
puts <<~ART
  ______ _           _
  | ___ \\ |         | |
  | |_/ / |__   ___ | |__   ___  ___
  |  __/| '_ \\ / _ \\| '_ \\ / _ \\/ __|
  | |   | | | | (_) | |_) | (_) \\__ \\
  \\_|   |_| |_|\\___/|_.__/ \\___/|___/
ART
puts "
phobos_boot.rb - find this file at #{File.expand_path(__FILE__)}

"

require_relative 'app/consumers/user_consumer'

# Instrumentation
#
# https://github.com/phobos/phobos#-instrumentation
#
Phobos::Instrumentation.subscribe('listener.start') do |event|
  puts(event.payload)
end


