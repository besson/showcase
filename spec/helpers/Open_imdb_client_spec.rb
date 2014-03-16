require "spec_helper"

describe "OpenIMDbClient" do 

  before(:each) do
    @stub = stub_request(:any, "http://www.omdbapi.com/?t=RoboCop&y=1987")
    @client = OpenIMDbClient.new
  end

  it "should downcase returned category" do
    @stub.to_return(:body => '{"Genre": "adventure"}', :status => 200)
    expect(@client.get_genres("RoboCop", "1987")).to eq("adventure")
  end

  it "should return empty when the movie has no genre" do
    @stub.to_return(:body => '{"Genre": ""}', :status => 200)
    expect(@client.get_genres("RoboCop", "1987")).to be_empty()
  end

end
