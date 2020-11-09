class Player

    attr_accessor :cards, :name

    def initialize(name)
        self.name = name
    end

    def current
        cards.first
    end

end