require "spec_helper"

describe Serializers::User do
  before do
    @user = FactoryGirl.create(:user)
    @sz = described_class.new(:default)
    @serialized_user = @sz.serialize(@user)
  end

  it 'only contains request attributes' do
    expect(@serialized_user.keys).to eq([:created_at, :email, :id, :name, :updated_at])
  end

  it 'represents the user correctly' do
    expect(@serialized_user[:created_at]).to eq(@user.created_at.try(:iso8601))
    expect(@serialized_user[:email]).to eq(@user.email)
    expect(@serialized_user[:id]).to eq(@user.id)
    expect(@serialized_user[:name]).to eq(@user.name)
    expect(@serialized_user[:updated_at]).to eq(@user.updated_at.try(:iso8601))
  end
end
