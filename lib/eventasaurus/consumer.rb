module Eventasaurus
  class Consumer

    #require options at initialize
    #rand should be a hash

    def initialize
      @client = Stomp::Connection.new("", "", "event", 61613, true)
      rand = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
      @client.subscribe("/queue/Consumer.#{rand}.VirtualTopic.eventasaurus")
    end

    def get
      msg = @client.receive
      JSON.parse(msg.body)
    end
  end
end

