# Omniauth::ThreadsAPI

[![Gem Version](https://badge.fury.io/rb/omniauth-threads-api.svg)](https://badge.fury.io/rb/omniauth-threads-api)
[![Build Status](https://github.com/giacomoguiulfo/omniauth-threads-api/workflows/build/badge.svg)](https://github.com/giacomoguiulfo/omniauth-threads-api/actions)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

An OmniAuth strategy for authenticating with the [Threads API](https://developers.facebook.com/docs/threads) via OAuth.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-threads-api'
```

And then execute:

```bash
bundle install
```

## Usage

Here's an example of using it in a Rails application:

```ruby
# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :threads, ENV['THREADS_CLIENT_ID'], ENV['THREADS_CLIENT_SECRET']
end
```

Make sure to set `THREADS_CLIENT_ID` and `THREADS_CLIENT_SECRET` environment variables to your actual credentials or use [Rails encrypted credentials](https://guides.rubyonrails.org/security.html#custom-credentials) (e.g. `Rails.application.credentials.threads`).


## Scopes

The default scope for this strategy is `threads_basic`. To add more scopes simply specify them after your credentials:

```ruby
# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :threads, ENV['THREADS_CLIENT_ID'], ENV['THREADS_CLIENT_SECRET'],
    scope: [
        'threads_basic',
        'threads_content_publish',
        'threads_read_replies',
        'threads_manage_replies',
        'threads_manage_insights',
    ].join(",")
end
```

## Auth Hash

This is an example of what the [Auth Hash](https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema) available in `request.env['omniauth.auth']` would look like:

```ruby
{
  provider: 'threads',
  uid: '123456789',
  info: {
    name: 'John Doe',
    nickname: 'johndoe',
    description: "I'm just a tech",
    image: 'https://scontent-nrt1-1.cdninstagram.com/v/...',
  },
  credentials: {
    token: 'qwertyuiopasdfghjklzxcvbnm',
    expires: true,
    expires_at: 1733097115,
  },
  extra: {
    raw_info: {
      id: "123456789",
      name: "John Doe",
      username: "johndoe":
      threads_biography: "I'm just a tech",
      threads_profile_picture_url: "https://scontent-nrt1-1.cdninstagram.com/v/..."
    }
  }
}
```

The tokens stored in the `credentials` are last for 60 days and can be [refreshed](https://developers.facebook.com/docs/threads/get-started/long-lived-tokens).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).