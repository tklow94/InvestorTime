class Stock < ApplicationRecord

    def self.new_lookup(ticker_symbol) #self allows us to directly call this from the class not an instance of the class
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
        client.price(ticker_symbol) #return is implied
    end

end
