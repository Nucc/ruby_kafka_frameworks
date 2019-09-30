class UsersConsumer < Racecar::Consumer
  subscribes_to "users"

  # subscribes_to "users", start_from_beginning: false

  def initialize
    # before all
  end

  def process(message)
    puts "[p #{message.partition}, o #{message.offset}] #{message}"
    sleep 0.5
  end

  def teardown
    # after all
  end

  # consumer keeps the state, requests are not isolated,
  # be careful with instance variables
  def session
    @session ||= 'be careful with this'
  end

end