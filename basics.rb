require "kafka"

kafka = Kafka.new(["kafka.docker:9092"])

100.times do |i|
  # kafka.producer.produce("Payload #{i}", topic: "users", partition_key: i)
  # kafka.async_producer.produce("Payload #{i}", topic: "users", partition_key: i)
  kafka.deliver_message("Payload #{i}", topic: "users", partition_key: i)
end




consumer = kafka.consumer(group_id: "profile-updater")

consumer = kafka.consumer(
  group_id: "some-group",

  # Increase offset commit frequency to once every 5 seconds.
  offset_commit_interval: 5,

  # Commit offsets when 100 messages have been processed.
  offset_commit_threshold: 100,

  # Increase the length of time that committed offsets are kept.
  offset_retention_time: 7 * 60 * 60
)

consumer.subscribe('users')

consumer.each_message { |message| p message }
consumer.each_message { |message| p message; consumer.commit_offsets }
consumer.each_message(min_bytes: 1000, max_bytes: 10485760, max_wait_time: 30, automatically_mark_as_processed: true) { |message| p message }

# before each_message, create a new consumer if you've already called each_message on the consumer
consumer.seek('users', 0, 0)
