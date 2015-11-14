require 'spec_helper'

describe Endpoints::Courses do
  include Rack::Test::Methods

  describe 'POST /courses' do
    context 'valid params' do
      it 'returns http 201' do
        post 'courses', 'course' => FactoryGirl.attributes_for(:course)
        expect(last_response.status).to eq(201)
      end

      it 'returns correct http body' do
        post 'courses', 'course' => FactoryGirl.attributes_for(:course)
        json = MultiJson.load(last_response.body)
        expect(json['created_at']).to_not eq(nil)
        expect(json['description']).to_not eq(nil)
        expect(json['id']).to_not eq(nil)
        expect(json['name']).to_not eq(nil)
        expect(json['updated_at']).to_not eq(nil)
      end
    end
  end
end
