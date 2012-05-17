#!/usr/bin/ruby

require 'rubygems'
require 'stomp'
require 'json'
require 'time'


crap = {
  'ident'     => 'crap',
  'timestamp' => Time.now.utc.iso8601,
  'tags'      => [ 'johan', 'crap'],
  'message'   => "Johan is writing some crap."
}

msg = crap.to_json

stomp = Stomp::Client.new("", "", "event", 61613)
stomp.publish("/topic/VirtualTopic.eventasaurus", msg)
stomp.close
