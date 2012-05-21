module Eventasaurus
  class Consumer

    #require options at initialize
    #rand should be a hash

    def initialize(process)
      @client = Stomp::Connection.new("", "", "event", 61613, true)
      @client.subscribe("/queue/Consumer.#{process}.VirtualTopic.eventasaurus")
    end

    def get
      msg = @client.receive
      JSON.parse(msg.body)
    end
  end
end

