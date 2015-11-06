require "spec_helper"

describe Endpoints::Users do
  include Rack::Test::Methods

  describe "POST /users" do
    before :each do
      stub_google_oauth_requests
    end

    context "valid Google Apps custom domain (hd)" do
      it "returns http 201" do
        post "users", { "auth_code" => "hi" }
        expect(last_response.status).to eq(201)
      end

      it "returns correct http body" do
        post "users", { "auth_code" => "hi" }
        expect(last_response.body).to eq("{}")
      end
    end

    context "invalid Google Apps custom domain (hd)" do
      it "returns http 401" do
        post "users", { "auth_code" => "hi" }
        # this should be returning 201, but isn't
        # for some reason, the second hd body isn't being triggered
        expect(last_response.status).to eq(401)
      end

      it "returns correct http body" do
        post "users", { "auth_code" => "hi" }
        expect(last_response.body).to eq("{}")
      end
    end
  end
end
