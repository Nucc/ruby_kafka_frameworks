# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] = ENV['RAILS_ENV']
require ::File.expand_path('../config/environment', __FILE__)

return unless Rails.application

Rails.application.eager_load!


# This lines will make Karafka print to stdout like puma or unicorn
if Rails.env.development?
  Rails.logger.extend(
    ActiveSupport::Logger.broadcast(
      ActiveSupport::Logger.new($stdout)
    )
  )
end


class KarafkaApp < Karafka::App

  # https://github.com/karafka/karafka/wiki/Configuration
  # https://github.com/karafka/karafka/blob/master/lib/karafka/setup/config.rb

  setup do |config|
    config.kafka.seed_brokers = %w[kafka://kafka.docker:9092]
    config.client_id = 'example_app'
    config.batch_fetching = false
    config.batch_consuming = false
    config.backend = :inline
    # config.monitor =
    # config.consumer_mapper = # Mapper for building consumer ids
    # config.topic_mapper = # Mapper for hiding Kafka provider specific topic prefixes/postfixes, so internaly we use "pure" topics
    # config.deserializer = Karafka::Serialization::Json::Deserializer
    # config.serializer = Karafka::Serialization::Json::Serializer
    config.shutdown_timeout = 3
    config.logger = Rails.logger
    config.logger.level = :info
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.

  #Karafka.monitor.subscribe(WaterDrop::Instrumentation::StdoutListener.new)
  #Karafka.monitor.subscribe(Karafka::Instrumentation::StdoutListener.new)
  #Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  # Uncomment that in order to achieve code reload in development mode
  # Be aware, that this might have some side-effects. Please refer to the wiki
  # for more details on benefits and downsides of the code reload in the
  # development mode
  #
  # Karafka.monitor.subscribe(
  #   Karafka::CodeReloader.new(
  #     *Rails.application.reloaders
  #   )
  # )

  consumer_groups.draw do

    topic :users do
       consumer UserProfileUpdater
       responder SendProfileUpdateNotification

       backend :inline

       # max_bytes_per_partition 100
       # start_from_beginning true
       # batch_consuming false
    end

    topic :user_profile_update_notifications do
      consumer UserProfileUpdatesConsumer

      #serializer   CustomerSerializer
      #deserializer CustomerDeserializer
    end

    # Each consumer group is one thread (+ 1 ruby-kafka thread)
    #
    # consumer_group :voice do
    #   topic :test2 do
    #     consumer TestTwoConsumer
    #   end

    #   topic :test3 do
    #     consumer TestThreeConsumer
    #   end
    # end

    # consumer_group :bigger_group do
    #   topic :test do
    #     consumer TestConsumer
    #   end
    #
    #   topic :test2 do
    #     consumer Test2Consumer
    #   end
    # end
  end
end

Karafka.monitor.subscribe('app.initialized') do
  # Put here all the things you want to do after the Karafka framework
  # initialization
end

KarafkaApp.boot!
