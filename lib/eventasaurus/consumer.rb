#!/usr/bin/ruby

require 'rubygems'
require 'stomp'
require 'json'

module Eventasaurus
  class Consumer
    def initialize
      @client = Stomp::Connection.new("", "", "couchdb", 61613, true)
      rand = (0...50).map{ ('a'..'z').to_a[rand(26)] }.join
      @client.subscribe("/queue/Consumer.#{rand}.VirtualTopic.johan")
    end

    def get
      msg = @client.receive
      JSON.parse(msg.body)
    end
  end
end

