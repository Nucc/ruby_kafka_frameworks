class UserProfileUpdater < ApplicationConsumer

  # include Karafka::Consumers::Callbacks

  # after_fetch do
  #   puts "after_fetch"
  # end

  # before_stop do
  #   puts "before_stop"
  # end

  # before_poll do
  #   puts "before_poll"
  # end

  # after_poll do
  #   puts "after_poll"
  # end

  def consume
    puts "UserProfileUpdater received (#{params.topic}, #{params.partition} #{params.offset})"
    sleep 0.5

    respond_with(params.payload)

  rescue => exception
    puts exception
  end
end
