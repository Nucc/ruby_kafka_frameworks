class UserConsumer
  include Phobos::Handler

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
  end
end