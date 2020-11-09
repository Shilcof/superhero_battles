class Game

    @@all = []

    attr_accessor :players, :round_score

    def initialize(human, deck)
        shuffled_deck = deck.cards.shuffle
        self.players = human, Players::Computer.new("Computer")
        self.players[0].cards = shuffled_deck[0..14]
        self.players[1].cards = shuffled_deck[15..29]
        self.round_score = 0
        self.players.shuffle
        @@all << self
    end

    def winner
        players.detect{|p| p.cards.size == 30}
    end

    def evaluate(input)
        self.round_score = card_score(0, input) - card_score(1, input)
    end

    def card_score(player, input)
        players[player].current.powerstats.values[input-1].to_i
    end

    def update
        self.players = self.players.reverse if self.round_score < 0
        players[0].cards.push(players[0].cards.shift, players[1].cards.shift)
    end

    def self.all
        @@all
    end

end