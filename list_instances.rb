#!/usr/bin/env ruby

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "instance_manager"

name_re = Regexp.new(ARGV[0] || InstanceManager::DEFAULT_NAME_RE)
client = Aws::EC2::Client.new(:region => 'us-east-1')
manager = InstanceManager.new(client, name_re)

puts "Listing instances with Name tag matching #{manager.name_re}"

manager.instances.each do |instance|
  name = InstanceManager.instance_name(instance)
  # Stopped instances do not have any private IP address.
  private_ip_display = " (#{instance.private_ip_address})" if instance.private_ip_address
  puts "#{name} (#{instance.id}) => #{instance.state.name}#{private_ip_display}"
end
