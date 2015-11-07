require "webmock/rspec"

WebMock.disable_net_connect!

# Stub Google OAuth requests
def stub_google_oauth_requests
  # Token request (Bad request)
  stub_request(:post, "https://www.googleapis.com/oauth2/v3/token")
    .with(:body => "client_id=blah&client_secret=blah&code=bad&grant_type=authorization_code&redirect_uri=http%3A%2F%2Flocalhost%3A5000%2Flogin")
    .to_return(
      body: '{"access_token":"bad!"}',
      status: 200,
      headers: { 'Content-Type' => 'application/json' }
    )

  # Token request (Good request)
  stub_request(:post, "https://www.googleapis.com/oauth2/v3/token")
    .with(:body => "client_id=blah&client_secret=blah&code=good&grant_type=authorization_code&redirect_uri=http%3A%2F%2Flocalhost%3A5000%2Flogin")
    .to_return(
      body: '{"access_token":"good!"}',
      status: 200,
      headers: { 'Content-Type' => 'application/json' }
    )

  # User info request (Bad request)
  stub_request(:get, "https://www.googleapis.com/oauth2/v1/userinfo?access_token=bad!").to_return(
    body: '{"hd":"testy2.org"}',
    status: 200,
    headers: { 'Content-Type' => 'application/json' }
  )

  # User info request (Good request)
  stub_request(:get, "https://www.googleapis.com/oauth2/v1/userinfo?access_token=good!").to_return(
    body: '{"hd":"testy.org"}',
    status: 200,
    headers: { 'Content-Type' => 'application/json' }
  )
end
