class UserProfileUpdatesConsumer < ApplicationConsumer
  def consume
    puts "UserProfileUpdatesConsumer (#{params.topic}, #{params.partition} #{params.offset})"
    puts "PAYLOAD: #{params.payload}"
    sleep 0.5

  rescue => e
    puts e
  end
end
