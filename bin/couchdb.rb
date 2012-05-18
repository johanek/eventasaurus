#!/usr/bin/ruby

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
require 'rubygems'
require 'eventasaurus'
require 'trollop'
require 'digest/md5'
require 'time'
require 'net/http'
require 'json'

opts = Trollop::options do
  banner <<-EOS
daemon to send eventasaurus events to couchdb

Usage:
       couchdb [options]
where [options] are:
  EOS

  opt :ident, "Event ident to listen for", :type => String
  opt :option, "Email address to send events to", :type => String
end

#Couchdb stuff

@host = "couchdb"
@port = 5984

def request(req)
  res = Net::HTTP.start(@host, @port) { |http|http.request(req) }
  unless res.kind_of?(Net::HTTPSuccess)
    handle_error(req, res)
  end
  res
end

def handle_error(req, res)
  e = RuntimeError.new("#{res.code}:#{res.message}\nMETHOD:#{req.method}\nURI:#{req.path}\n#{res.body}")
  raise e
end

def put(uri, json)
  req = Net::HTTP::Put.new(uri)
  req["content-type"] = "application/json"
  req.body = json
  request(req)
end

# Event stuff
stomp = Eventasaurus::Consumer.new

loop do
  begin
    msg = stomp.get
    uri = "/eventasaurus/" + Time.now.utc.iso8601 + "_" + Digest::MD5.hexdigest(msg['message'])
    put(uri, msg.to_json)
  end
end