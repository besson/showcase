module OmdbRestClient

  def get_genre title, year
    response = RestClient.get "http://www.omdbapi.com", {:params => {:t => title, :y => year}}
    data = JSON.parse(response)
    data["Genre"]
  end
end
