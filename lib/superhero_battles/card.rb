class Card

    @@blu="\e[1;34m"
    @@cyn="\e[1;36m"
    @@white="\e[0m"

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

    def bio
        "#{@@blu}\n#{self.name}\n
#{@@cyn}Superhero Battles ratings:\n#{@@white}
        Intelligence: #{self.powerstats["intelligence"]}
        Strength: #{self.powerstats["strength"]}
        Speed: #{self.powerstats["speed"]}
        Durability: #{self.powerstats["durability"]}
        Power: #{self.powerstats["power"]}
        Combat: #{self.powerstats["combat"]}\n
#{@@cyn}Appearance\n#{@@white}
        Gender: #{self.appearance["gender"]}
        Race: #{self.appearance["race"]}
        Height: #{self.appearance["height"]}
        Weight: #{self.appearance["weight"]}
        Eye colour: #{self.appearance["eyeColor"]}
        Hair colour: #{self.appearance["hairColor"]}\n
#{@@cyn}Biography\n#{@@white}
        Full name: #{self.biography["fullName"]}
        Alter egos: #{self.biography["alterEgos"]}
        Aliases: #{self.biography["aliases"]}
        Birth place: #{self.biography["placeOfBirth"]}
        First appearance: #{self.biography["firstAppearance"]}
        Publisher: #{self.biography["publisher"]}
        Alignment: #{self.biography["alignment"]}\n
#{@@cyn}Work\n#{@@white}
        Occupation: #{self.work["occupation"]} 
        Base: #{self.work["base"]}\n
#{@@cyn}Connections\n#{@@white} 
        Affiliated groups: #{self.connections["groupAffiliation"]}
        Relatives: #{self.connections["relatives"]}\n\n"
    end

end