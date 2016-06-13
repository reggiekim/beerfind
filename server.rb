module Sinatra
  class Server < Sinatra::Base

    def getBeer(beerName)
      key = ENV['BREWERYDB_KEY']
      url = 'http://api.brewerydb.com/v2/search?q='+beerName+'&type=beer&key='+key
      data = HTTParty.get(url)
      # binding.pry
      if data['data'] == nil
        return false
      else
        result = data['data'][0]
        myBeerName = result['name']

        if result['labels']
          myBeerLabel = result['labels']['medium']
        else
          myBeerLabel = "/img/no_image.jpg"
        end

        if result['abv']
          myBeerAbv = result['abv']+"%"
        else
          myBeerAbv = "Sorry, no ABV info yet!"
        end

        if result['description']
          myBeerDesc = result['description']
        else
          myBeerDesc = "Aww man, no description for "+myBeerName
        end

        if result['style']
          styleName = result['style']['name']
        else
          styleName = "Sorry, we're not sure what style this beer is"
        end

        if result['style']
          styleInfo = result['style']['description']
        else
          styleInfo = "Sorry, no additional information about this style of beer"
        end

        myBeer = {name: myBeerName, label: myBeerLabel, abv: myBeerAbv, description: myBeerDesc, style: styleName, styleInfo: styleInfo}
        return myBeer
      end

    end

    get "/" do
      erb :index
    end

    get "/search" do
      beerSearch = params[:beer]
      query = beerSearch.gsub(/\s+/, '+')
      @beer = getBeer(query)
      erb :search
    end


  end
end
