#!/usr/bin/ruby

require 'yaml'

config_file = 'config.yaml'
config = YAML::load(File.open(config_file))

config.each do |x|
  ident = x[0]
  config[ident]['things'].each do |stuff|
    option = config[ident][stuff]
    puts "#{stuff} --ident #{ident} --option #{option}"
  end
end
  
