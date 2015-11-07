require "spec_helper"

describe Endpoints::Root do
  include Rack::Test::Methods

  describe "GET /" do
    it "returns http 200" do
      get "/"
      expect(last_response.status).to eq(200)
    end

    it "returns correct body" do
      get "/"
      expect(last_response.body).to eq("hello.")
    end
  end
end
