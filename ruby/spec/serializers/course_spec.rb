require 'spec_helper'

describe Serializers::Course do
  before do
    @course = FactoryGirl.create(:course, code: 'hi')
    @sz = described_class.new(:default)
    @serialized_course = @sz.serialize(@course)
  end

  it 'only contains request attributes' do
    expect(@serialized_course.keys).to eq([:code, :created_at, :description, :id, :name, :updated_at])
  end

  it 'represents the course correctly' do
    expect(@serialized_course[:code]).to eq(@course.code)
    expect(@serialized_course[:created_at]).to eq(@course.created_at.try(:iso8601))
    expect(@serialized_course[:description]).to eq(@course.description)
    expect(@serialized_course[:id]).to eq(@course.id)
    expect(@serialized_course[:name]).to eq(@course.name)
    expect(@serialized_course[:updated_at]).to eq(@course.updated_at.try(:iso8601))
  end
end
