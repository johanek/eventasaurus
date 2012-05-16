#!/usr/bin/ruby

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
require 'rubygems'
require 'eventasaurus'
require 'net/smtp'

def send_email(from, to, subject, message)
  msg = <<END_OF_MESSAGE
From: <#{from}>
To: <#{to}>
Subject: #{subject}

  #{message}
END_OF_MESSAGE

  Net::SMTP.start('localhost') do |smtp|
    smtp.send_message msg, from, to
  end
end

crap = Eventasaurus::Consumer.new

loop do
  begin
    msg = crap.get
    out = "at #{msg['timestamp']} received #{msg['message']}"
    msg['tags'].each do |tag|
      out += " #" + tag
    end
    ident = msg['ident']
    send_email(ident, 'johan.vandendorpe@gmail.com', 'Crap', out)
  end
end
