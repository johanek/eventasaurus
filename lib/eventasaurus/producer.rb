module Eventasaurus
  class Producer
    def initialize
      @client = Stomp::Client.new("", "", "event", 61613, true)
    end

    def pub(msg)
      @client.publish("/topic/VirtualTopic.eventasaurus", msg)
    end
    
    def close
      @client.close
    end
    
  end
end

