require 'omniauth-oauth2'

# create a strategy so that omniauth can work with aha oauth2
module OmniAuth
  module Strategies
    class AhaStrategy < OmniAuth::Strategies::OAuth2
      option :name, 'aha_strategy'
      option :client_options, {
        site:          "https://ericatripp.aha.io/",
        redirect_uri:  "https://vierless.com/aha/oauth2/callback",
        authorize_url: "https://ericatripp.aha.io/oauth/authorize",
      }

    end
  end
end