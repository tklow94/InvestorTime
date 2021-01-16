class Stock < ApplicationRecord

    def self.new_lookup(ticker_symbol) #self allows us to directly call this from the class not an instance of the class
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
        #return custom stock object of what we want
        new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    end

end
