require 'spec_helper'

describe Endpoints::Users do
  include Rack::Test::Methods

  describe 'POST /users' do
    before :each do
      stub_google_oauth_requests
    end

    context 'valid Google Apps custom domain (hd) and no pre-existing user' do
      it 'returns http 201' do
        post 'users', 'auth_code' => 'good'
        expect(last_response.status).to eq(201)
      end

      it 'returns correct http body' do
        post 'users', 'auth_code' => 'good'
        json = MultiJson.load(last_response.body)
        expect(json['created_at']).to_not eq(nil)
        expect(json['email']).to eq('hi@hi.com')
        expect(json['id']).to_not eq(nil)
        expect(json['name']).to eq('hi')
        expect(json['updated_at']).to_not eq(nil)
      end
    end

    context 'valid Google Apps custom domain (hd) and pre-existing user' do
      before do
        User.create(email: 'hi@hi.com', name: 'hi')
      end

      it 'returns http 200' do
        post 'users', 'auth_code' => 'good'
        expect(last_response.status).to eq(200)
      end

      it 'returns correct http body' do
        post 'users', 'auth_code' => 'good'
        json = MultiJson.load(last_response.body)
        expect(json['created_at']).to_not eq(nil)
        expect(json['email']).to eq('hi@hi.com')
        expect(json['id']).to_not eq(nil)
        expect(json['name']).to eq('hi')
        expect(json['updated_at']).to_not eq(nil)
      end
    end

    context 'invalid Google Apps custom domain (hd)' do
      it 'returns http 401' do
        post 'users', 'auth_code' => 'bad'
        expect(last_response.status).to eq(401)
      end

      it 'returns correct http body' do
        post 'users', 'auth_code' => 'bad'
        expect(last_response.body).to eq('{}')
      end
    end
  end
end
