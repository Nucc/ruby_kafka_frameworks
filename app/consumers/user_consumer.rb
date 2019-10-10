class UserConsumer
  include Phobos::Handler
  # include Phobos::Producer

  def self.start(kafka_client)
    puts "Started, kafka_client:#{kafka_client}"
  end

  def self.stop
    puts "after all"
  end

  def before_consume(payload, metadata)
    puts 'before consume'
  end

  def around_consume(payload, metadata)
    puts 'around consume'

    yield
  end

  def consume(payload, metadata)
    @counter ||= 0
    @counter += 1

    # optionally preprocess payload
    p payload
    p metadata
    p @counter
    sleep 0.5

    # Produce messages
    #
    # producer.async_publish('user_notifications', {key: 'value'}.to_json)
    # producer.publish('user_notifications', {key: 'value'}.to_json)
  end
end
