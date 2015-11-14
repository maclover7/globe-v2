module Endpoints
  class Courses < Base
    namespace '/courses' do
      before { content_type :json, charset: 'utf-8' }

      ## POST /courses
      post do
        # Check to make sure user is a teacher
        @course = Course.new(description: params['course']['description'], name: params['course']['name'])
        @course.code = SecureRandom.hex(3)
        @course.save
        sz = Serializers::Course.new(:default)
        status 201
        MultiJson.dump(sz.serialize(@course))
      end
    end
  end
end
