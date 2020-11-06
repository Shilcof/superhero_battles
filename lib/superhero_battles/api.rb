class API

    def get_heroes
        uri = URI("https://raw.githubusercontent.com/akabab/superhero-api/0.3.0/api/all.json")
        JSON.parse(Net::HTTP.get(uri))
    end

end