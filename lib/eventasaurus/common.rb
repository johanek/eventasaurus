module Eventasaurus
  class << self

    def publish(ident, message)
      stomp = Eventasaurus::Producer.new('event')
      stomp.topic = 'eventasaurus'
      msg = {
        'ident' => ident,
        'timestamp' => Time.now.utc.iso8601,
        'message' => message
      }
      stomp.pub(msg.to_json)
      stomp.close
    end
    
  end
end