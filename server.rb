module Sinatra
  class Server < Sinatra::Base

    def getBeer(beerName)
      key = ENV['BREWERYDB_KEY']
      # beerName = "stella+artois"
      url = 'http://api.brewerydb.com/v2/search?q='+beerName+'&format=json&type=beer&key='+key
      # url = 'http://api.brewerydb.com/v2/search?q=stella+artois&format=json&type=beer&key=210ad75e065422c7930f7b65df4d1bd1'
      data = HTTParty.get(url)
      @results = data['data']
      binding.pry


    end

    get "/" do
      @beer = getBeer("stella+artois")
      erb :index
    end

    get "/new" do
      @beer = getBeer
    end


  end
end
