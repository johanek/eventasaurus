#!/usr/bin/ruby

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
require 'rubygems'
require 'eventasaurus'
require 'twitter'

Twitter.configure do |config|
  config.consumer_key = 'tSKiN18pWke9WoiFbT2row'
  config.consumer_secret = ''
  config.oauth_token = '191964787-68zDqt6kJ9w5nYyHkVOtaWYK35Gga2kQnUFFQs34'
  config.oauth_token_secret = ''
end

crap = Eventasaurus::Consumer.new

loop do
  begin
    msg = crap.get
    out = "at #{msg['timestamp']} received #{msg['message']}"
    msg['tags'].each do |tag|
      out += " #" + tag
    end
    Twitter.update(out)
  end
end
