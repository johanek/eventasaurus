module Eventasaurus
  class Consumer

    attr_writer :topic, :process

    def initialize(hostname, port='61613')
      @client = Stomp::Connection.new("", "", "event", 61613, true)
      @client.subscribe("/queue/Consumer.#{@process}.VirtualTopic.#{@topic}")
    end

    def get
      msg = @client.receive
      JSON.parse(msg.body)
    end
  end
end

