#!/usr/bin/ruby

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
require 'rubygems'
require 'stomp'
require 'json'
require 'time'
require 'trollop'
require 'eventasaurus/producer'

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

tags = Array.new
tags = opts[:tags].split(/,/) if (opts[:tags])

crap = {
    'ident'     => opts[:ident],
    'timestamp' => Time.now.utc.iso8601,
    'tags'      => tags,
    'message'   => opts[:message]
}

msg = crap.to_json

stomp = Eventasaurus::Producer.new
stomp.pub(msg)
stomp.close
