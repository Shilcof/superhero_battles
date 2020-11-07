class Game

    LOOK_UP = ["intelligence", "strength", "speed", "durability", "power", "combat"]

    @@all = []

    attr_accessor :player_1, :player_2, :active

    def initialize(human, deck)
        shuffled_deck = deck.cards.shuffle

        self.player_1 = human
        self.player_1.cards = shuffled_deck[0..14]
        self.player_2 = Players::Computer.new("Computer")
        self.player_2.cards = shuffled_deck[15..29]

        self.active = [self.player_1, self.player_2].sample
        @@all << self
    end

    def winner # refactor to players?
        [player_1, player_2].detect{|p| p.cards.size == 30}
    end

    def display_card
        "\n#{padding(8)}┌" + "─"*30 + "┐\n" +
        empty_card + centre_text(player_1.cards.first.name) + empty_card + empty_card + empty_card + empty_card +
        LOOK_UP.collect{|i| centre_text("#{i.capitalize}: #{player_1.cards.first.powerstats[i]}") + empty_card }.join +
        "#{padding(8)}└" + "─"*30 + "┘\n\n"
    end

    def empty_card
        "#{padding(8)}|#{padding(30)}|\n"
    end

    def centre_text(a)
        "#{padding(8)}|#{padding(15, (a.size/2.0).ceil)}#{a}#{padding(15, (a.size/2.0).floor)}|\n"
    end

    def padding(a, b = 0)
        " "*(a - b)
    end

    def evaluate(input)
        player_1.cards.first.powerstats[LOOK_UP[input-1]].to_i - player_2.cards.first.powerstats[LOOK_UP[input-1]].to_i
    end
    
end