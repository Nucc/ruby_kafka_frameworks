# frozen_string_literal: true

# Application consumer from which all Karafka consumers should inherit
# You can rename it if it would conflict with your current code base (in case you're integrating
# Karafka with other frameworks)
class TestTwoConsumer < ApplicationConsumer
  def consume
    puts "TestTwoConsumers"
    puts "#{params.topic}, #{params.partition} #{params.offset}: "
    sleep 0.5
  rescue => e
    p e
  end
end
