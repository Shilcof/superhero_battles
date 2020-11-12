class Card

    attr_accessor :bio

    def initialize(hero)
        self.bio = hero
        hero.each do |key, value|
            self.class.attr_accessor(key)
            self.send("#{key}=", value)
        end
    end

    def self.create_from_array(array)
        @@all = array.collect{|hero| Card.new(hero)}
    end

    def self.all
        @@all
    end

end