module Endpoints
  class Users < Base
    namespace "/users" do
      before { content_type :json, charset: 'utf-8' }

      ## POST /users
      post do
        get_token
        get_user_info

        # Check to make sure user doesn't already exist and has valid GA domain
        if @json_user_info['hd'] != ENV['GOOGLE_OAUTH_DOMAIN']
          status 401
          MultiJson.dump({})
        else
          # Return new User
          @user = User.create(email: @json_user_info['email'], name: @json_user_info['name'])
          sz = Serializers::User.new(:default)
          status 201
          MultiJson.dump(sz.serialize(@user))
        end
      end

      private

      def get_token
        # Get OAuth token from Google
        token_response = HTTParty.post(
          'https://www.googleapis.com/oauth2/v3/token',
          :body => {
            :client_id => ENV['GOOGLE_OAUTH_ID'],
            :client_secret => ENV['GOOGLE_OAUTH_SECRET'],
            :code => params['auth_code'],
            :grant_type => 'authorization_code',
            :redirect_uri => 'http://localhost:5000/login'
          }
        )

        json_token_response = MultiJson.load(token_response.body)
        @access_token = json_token_response['access_token']
      end

      def get_user_info
        # Get user information via OAuth token from Google
        user_info_response = HTTParty.get("https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{@access_token}")
        @json_user_info = MultiJson.load(user_info_response.body)
      end
    end
  end
end
