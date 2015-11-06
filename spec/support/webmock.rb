require "webmock/rspec"

WebMock.disable_net_connect!

# Stub Google OAuth requests
def stub_google_oauth_requests
  # Token request
  stub_request(:post, "https://www.googleapis.com/oauth2/v3/token").to_return(
    body: '{"access_token":"fake!"}',
    status: 200,
    headers: { 'Content-Type' => 'application/json' }
  )

  # User info request
  stub_request(:get, "https://www.googleapis.com/oauth2/v1/userinfo?access_token=fake!").to_return(
    # Good request
    { body: '{"hd":"testy.org"}' },
    # Bad request
    { body: '{"hd":"testy1.org"}' },
    status: 200,
    headers: { 'Content-Type' => 'application/json' }
  )
end
