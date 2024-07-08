require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Threads < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = "threads_basic"
      DEFAULT_FIELDS = "id,username,name,threads_profile_picture_url,threads_biography"

      option :name, "threads"

      option :client_options, {
        site: "https://graph.threads.net/v1.0",
        authorize_url: "https://threads.net/oauth/authorize",
        token_url: "oauth/access_token"
      }

      option :scope, DEFAULT_SCOPE

      uid { raw_info["id"] }

      info do
        {
          name: raw_info["name"],
          nickname: raw_info["username"],
          description: raw_info["threads_biography"],
          image: raw_info["threads_profile_picture_url"]
        }
      end

      credentials do
        {
          token: long_lived_token.token,
          expires_at: long_lived_token.expires_at,
          expires: true
        }
      end

      extra { {raw_info: raw_info} }

      def token_params
        super.tap do |params|
          params[:client_id] = options.client_id
          params[:client_secret] = options.client_secret
        end
      end

      def callback_url
        full_host + callback_path
      end

      def raw_info
        @raw_info ||= long_lived_token.get("/me", params: {fields: DEFAULT_FIELDS}).parsed
      end

      def long_lived_token
        @long_lived_token ||= ::OAuth2::AccessToken.from_hash(client, access_token.get("/access_token", params: {grant_type: "th_exchange_token", client_secret: options.client_secret, access_token: access_token.token}).parsed)
      end
    end
  end
end
