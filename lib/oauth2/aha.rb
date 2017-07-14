module Aha

  class Client < OAuth2::Client
    
    # Return a new OAuth2::Client object specific to the app.
    def initialize
      super(
        Rails.application.secrets[:aha][:oauth2][:client_id],
        Rails.application.secrets[:aha][:oauth2][:client_secret],
        {
          :site => Rails.application.secrets[:aha][:oauth2][:site],
          :redirect_uri => Rails.application.secrets[:aha][:oauth2][:redirect_uri]
        }
      )
    end

  end

  class Token < OAuth2::AccessToken
    
    # Return an OAuth2::AccessToken specific to the app
    # and the session with the given token hash.
    def self.from_hash(token_hash)

      super(
        Aha::Client.new,
        token_hash
      )

    end
    
  end
  
end