class Deck

    attr_accessor :cards

    def self.new_random
        new.tap{|d| d.cards = Card.all.sample(30)}
    end

    # Add card - reject when deck .cards.size = 30

    # Undo add - .cards.pop

    # View deck/deck list

end