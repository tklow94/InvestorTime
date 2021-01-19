class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :name, :ticker, presence: true

    def self.new_lookup(ticker_symbol) #self allows us to directly call this from the class not an instance of the class
      ticker_symbole.upcase!  
      client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
          )
        #return custom stock object of what we want
        begin
            new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
        rescue => exception
            return nil
        end
    end

    def self.check_db(ticker_symbol)
        ticker_symbol.upcase!
        where(ticker: ticker_symbol).first
    end

    # def self.update_price_and_performance(stock)
    #     look_up = new_lookup(stock.ticker)
    #     new_price = look_up.last_price
    
    #     return stock unless updated?(stock, new_price, new_performance)
    
    #     stock.last_price = new_price unless !updated_price?(stock, new_price)
    #     stock.save
    #     stock
    #   end

  #     private

  #     def self.updated?(stock, new_price)
  #   updated_price?(stock, new_price)
  # end

  # def self.updated_price?(stock,new_price)
  #   stock.last_price != new_price
  # end


end
