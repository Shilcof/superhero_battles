class Card

    def initialize(hero)
        hero.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
    end

    def self.create_from_array(array)
        @@all = array.collect{ |hero|
            Card.new(hero)
        }
    end

    def self.all
        @@all
    end

    # {
    #     "id": 731,
    #     "name": "Zoom",
    #     "slug": "731-zoom",
    #     "powerstats": {
    #       "intelligence": 50,
    #       "strength": 10,
    #       "speed": 100,
    #       "durability": 28,
    #       "power": 100,
    #       "combat": 28
    #     },
    #     "appearance": {
    #       "gender": "Male",
    #       "race": null,
    #       "height": [
    #         "6'1",
    #         "185 cm"
    #       ],
    #       "weight": [
    #         "181 lb",
    #         "81 kg"
    #       ],
    #       "eyeColor": "Red",
    #       "hairColor": "Brown"
    #     },
    #     "biography": {
    #       "fullName": "Hunter Zolomon",
    #       "alterEgos": "No alter egos found.",
    #       "aliases": [
    #         "-"
    #       ],
    #       "placeOfBirth": "-",
    #       "firstAppearance": "Flash Secret Files #3",
    #       "publisher": "DC Comics",
    #       "alignment": "bad"
    #     },
    #     "work": {
    #       "occupation": "-",
    #       "base": "Keystone City, Kansas"
    #     },
    #     "connections": {
    #       "groupAffiliation": "Secret Society of Super Villains, formerly Keystone Police Department, F.B.I.",
    #       "relatives": "Ashley Zolomon (ex-wife)"
    #     },
    #     "images": {
    #       "xs": "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/xs/731-zoom.jpg",
    #       "sm": "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/sm/731-zoom.jpg",
    #       "md": "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/md/731-zoom.jpg",
    #       "lg": "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/images/lg/731-zoom.jpg"
    #     }
    #   }
end