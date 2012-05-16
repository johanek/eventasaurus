#!/usr/bin/ruby

require 'rubygems'
require 'stomp'
require 'json'
require 'time'
require 'trollop'

opts = Trollop::options do
  banner <<-EOS
Eventasaurus-rex is an awesome program that sends events all over the place.

Usage:
       eventasaurus-rex [options]
where [options] are:
EOS

  opt :ident, "Ident for event", :type => String, :default => 'public'
  opt :tags, "Tags for event", :type => String
  opt :message, "Message", :type => String
end

Trollop::die :message, "need a message" if !opts[:message]


crap = {
    'ident'     => opts[:ident],
    'timestamp' => Time.now.utc.iso8601,
    'tags'      => opts[:tags],
    'message'   => opts[:message]
}

msg = crap.to_json

stomp = Stomp::Client.new("", "", "couchdb", 61613)
stomp.publish("/topic/VirtualTopic.johan", msg)
stomp.close
