module Eventasaurus
  class Producer

    attr_writer :topic
    
    def initialize(hostname, port='61613')
      @client = Stomp::Client.new("", "", "event", 61613, true)
    end

    def pub(msg)
      @client.publish("/topic/VirtualTopic.#{@topic}", msg)
    end
    
    def close
      @client.close
    end
  end
end

