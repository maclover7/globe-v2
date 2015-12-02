require 'spec_helper'

describe Endpoints::Users do
  include Rack::Test::Methods

  describe 'GET /users' do
    context 'valid user' do
      before do
        @user = FactoryGirl.create(:user)
      end

      it 'returns http 200' do
        get "/users/#{@user.id}", user_auth_token: @user.token
        expect(last_response.status).to eq(200)
      end

      it 'returns correct http body' do
        get "/users/#{@user.id}", user_auth_token: @user.token
        json = MultiJson.load(last_response.body)
        expect(json['created_at']).to_not eq(nil)
        expect(json['email']).to eq(@user.email)
        expect(json['id']).to eq(@user.id)
        expect(json['name']).to eq(@user.name)
        expect(json['updated_at']).to_not eq(nil)
      end
    end

    context 'invalid user' do
      before do
        @user = FactoryGirl.create(:user)
      end

      it 'returns http 404' do
        get '/users/bb7e8fa3-49c9-4dd0-9346-d03f8300422c', user_auth_token: @user.token
        expect(last_response.status).to eq(404)
      end

      it 'returns correct http body' do
        get '/users/bb7e8fa3-49c9-4dd0-9346-d03f8300422c', user_auth_token: @user.token
        expect(last_response.body).to eq('{}')
      end
    end
  end

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
