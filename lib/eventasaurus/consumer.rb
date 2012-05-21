module Eventasaurus
  class Consumer

    def initialize(topic, process, hostname, port='61613')
      @client = Stomp::Connection.new("", "", hostname, port, true)
      @client.subscribe("/queue/Consumer.#{process}.VirtualTopic.#{topic}")
    end

    def get
      msg = @client.receive
      JSON.parse(msg.body)
    end
  end
end

