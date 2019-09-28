class TestConsumer
  include Phobos::Handler

  def consume(payload, metadata)
    # optionally preprocess payload
    p payload
    p metadata
    sleep 1
  end
end