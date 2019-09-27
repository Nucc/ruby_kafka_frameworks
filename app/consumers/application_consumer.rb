# frozen_string_literal: true

# Application consumer from which all Karafka consumers should inherit
# You can rename it if it would conflict with your current code base (in case you're integrating
# Karafka with other frameworks)
class ApplicationConsumer < Karafka::BaseConsumer
  def consume
    puts metadata #=> { batch_size: 200, topic: 'events', partition: 2 }
    puts params
    puts params_batch
  end
end
