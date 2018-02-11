require "aws-sdk"

RSpec.describe Aws::EC2 do
  let(:client) { Aws::EC2::Client.new(:region => 'us-east-1', :stub_responses => true) }
  let(:resource) { Aws::EC2::Resource.new(:client => client) }

  context "when describe_instances is stubbed to return a single instance" do
    before do
      client.stub_responses(
        :describe_instances, {
          :next_token => nil,
          :reservations => [{:instances=>[{:instance_id => "i-1", :state => {:name => "running"}, :tags =>[{:key => "Name", :value => "example-1" }]}]}]
        }
      )

    end
    context Aws::EC2::Client do
      it "#describe_instances to return 1 instance" do
        expect(client.describe_instances.reservations.first.instances.size).to eq 1
      end
    end

    context Aws::EC2::Resource do
      it "#instances to return 1 instance" do
        expect(resource.instances.to_a.size).to eq 1
      end
    end
  end
end
