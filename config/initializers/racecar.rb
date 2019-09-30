Racecar.config.on_error do |exception, info|
  p exception
  puts({topic: info[:topic], partition: info[:partition], offset: info[:offset] })
end


