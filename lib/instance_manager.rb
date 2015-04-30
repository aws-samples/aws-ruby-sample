require "aws-sdk"

# An example using AWS Ruby SDK v2 to list and filter EC2 instances.
class InstanceManager
  # By default manage EC2 instance whose Name tag matches this pattern.
  DEFAULT_NAME_RE = /^example-\d+$/

  attr_reader :ec2_resource
  attr_reader :name_re

  # @param instance [Aws::EC2::Instance]
  # @return [String] Instance name as judged by its Name tag.
  def self.instance_name(instance)
    name_tag = instance.tags.find { |t| t.key == "Name" }
    name_tag.value if name_tag
  end

  # @param ec2_client [Aws::EC2::Client]
  # @param name_re [Regexp] Manage EC2 instance whose Name tag matches this
  # pattern.
  def initialize(ec2_client, name_re = DEFAULT_NAME_RE)
    @ec2_resource = Aws::EC2::Resource.new(:client => ec2_client)
    @name_re = name_re
  end

  # @return [Array<Aws::EC2::Instance>] Instance whose Name tag matches the
  #   given pattern.
  def instances
    ec2_resource.instances.select { |i| name_matches?(i) }
  end

  protected

  # @param instance [Aws::EC2::Instance]
  # @return [Boolean] true if the given instance has a Name tag that matches
  #   the requested pattern.
  def name_matches?(instance)
    name = self.class.instance_name(instance)
    name && name.match(name_re)
  end

end
