class OpenIMDbClient

  def initialize()
    @url = "http://www.omdbapi.com"
  end

  def get_genres(title, year)
    response = RestClient.get @url, {:params => {:t => title, :y => year}}
    genre = JSON.parse(response)["Genre"]

    genre.downcase unless genre.nil?
  end

end
