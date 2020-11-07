class Game

    @@all = []

    attr_accessor :player_1, :player_2, :active

    def initialize(human, deck)
        shuffled_deck = deck.cards.shuffle

        self.player_1 = human
        self.player_1.cards = shuffled_deck[0..14]
        self.player_2 = Players::Computer.new("Computer")
        self.player_2.cards = shuffled_deck[15..29]

        self.active = [self.player_2, self.player_2].sample
        @@all << self
    end

    def winner # refactor to players?
        [player_1, player_2].detect{|p| p.cards.size == 30}
    end

    def display_card
        "\n#{padding(8)}┌" + "─"*30 + "┐\n" +
        empty_card + centre_text(player_1.cards.first.name) + empty_card + empty_card + empty_card + empty_card +
        centre_text("Intelligence: #{player_1.cards.first.powerstats["intelligence"]}") + empty_card +
        centre_text("Strength: #{player_1.cards.first.powerstats["strength"]}") + empty_card +
        centre_text("Speed: #{player_1.cards.first.powerstats["speed"]}") + empty_card +
        centre_text("Durability: #{player_1.cards.first.powerstats["durability"]}") + empty_card +
        centre_text("Power: #{player_1.cards.first.powerstats["power"]}") + empty_card +
        centre_text("Combat: #{player_1.cards.first.powerstats["combat"]}") + empty_card +
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

        #   sees results?
        #   decides who is active
    end

    # def play
    #     board.display
    #     turn until over?
    #     puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    # end

    # def turn
    #     input = current_player.move(board) 
    #     turn unless board.valid_move?(input)
    #     board.update(input, current_player)
    #     board.display
    # end

end