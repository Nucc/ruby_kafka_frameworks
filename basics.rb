config = {
  :"bootstrap.servers" => "kafka.docker:9092",
  :"group.id" => "ruby-test"
}

consumer = Rdkafka::Config.new(config).consumer
consumer.subscribe("users")

consumer.each do |message|
  puts "Message received: #{message}"
end


delivery_handles = []
producer = Rdkafka::Config.new(config).producer
100.times do |i|
  delivery_handles << producer.produce(
      topic:   "users",
      payload: "Payload #{i}",
      key:     "Key #{i}"
  )

delivery_handles.each(&:wait)