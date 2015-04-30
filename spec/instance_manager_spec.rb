require "instance_manager"
RSpec.describe InstanceManager do
  let(:ec2_client) do
    Aws::EC2::Client.new(:region => 'us-east-1', :stub_responses => true)
  end

  subject do
    described_class.new(ec2_client)
  end

  context "#instances" do
    before do
      ec2_client.stub_responses(
        :describe_instances,
        { :reservations => [{ :instances => [
          {
            :instance_id => "i-1",
            :state => {:name => "running" },
            :tags => [
              { :key => "Name", :value => "example-1" },
              { :key => "color", :value => "red" },
            ]
          },
          {
            :instance_id => "i-2",
            :state => {:name => "running" },
            :tags => [
              { :key => "Name", :value => "example-2" },
              { :key => "color", :value => "green" },
            ]
          },
          {
            :instance_id => "i-3",
            :state => {:name => "running" },
            :tags => [
              { :key => "Name", :value => "webapp-3" },
              { :key => "color", :value => "green" },
            ]
          },
          {
            :instance_id => "i-4",
            :state => {:name => "stopped" },
            :tags => [],
          },
        ]}]},
      )
    end

    it "returns two matching EC2 instances" do
      expect(subject.instances.to_a.size).to eq 2
    end

    it "returns only EC2 instances with matching Name tag" do
      expect(subject.instances.map(&:id)).to eq ["i-1", "i-2"]
    end
  end
end
