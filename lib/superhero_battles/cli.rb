class CLI

    @@blu="\e[1;34m"
    @@cyn="\e[1;36m"
    @@white="\e[0m"

    attr_accessor :user

    def call
        puts "#{@@cyn}\n\nWelcome to Superhero Battles!\n#{@@white}
        Collecting your heroes...\n\n"
        Card.create_from_array(API.new.get_heroes)
        # Asks for optional name?
        self.user = Players::Human.new("Player 1")
        menu
    end

    def menu
        puts "#{@@cyn}Please select which option you would like:\n#{@@white}
        1. Play a game of Superhero Battles vs the computer.
        2. View the Superhero Battles cards.
        3. Exit Superhero Battles.\n\n"
        input = gets.strip.to_i
        while !(1..3).include?(input)
            puts "#{@@cyn}\nSorry, that input is invalid, please enter a number from #{@@white}1#{@@cyn} to #{@@white}3#{@@cyn}.#{@@white}\n\n"
            input = gets.strip.to_i
        end

        case input
        when 1
            play
            menu
        when 2
            collection
            menu
        when 3
            puts "#{@@cyn}\nI hope you enjoyed playing Superhero Battles!\n\n#{@@white}"
        end
    end

    def play
        # Game options
        # Which deck would you like to use?
        deck = Deck.new_random
        # What difficulty would you like to play on?
        game = Game.new(user, deck)

        turn(game) until game.winner
        puts "Congratulations #{game.winner.name}"
        # Play again??
    end

    def turn(game)
        puts "\n#{@@white}#{game.player_1.name}#{@@cyn}, your card is:\n\n#{@@white}"
        puts game.display_card

        #   game.turn
        if game.active == user
            puts "\n#{@@white}#{game.player_1.name}#{@@cyn}, select your category!\n\n#{@@white}"
            input = gets.strip.to_i
            while !(1..6).include?(input)
                puts "#{@@cyn}\nSorry, that input is invalid, please enter a number from #{@@white}1#{@@cyn} to #{@@white}6#{@@cyn}.#{@@white}\n\n"
                input = gets.strip.to_i
            end
            input
        else 
            puts "#{@@white}#{game.player_2.name}#{@@cyn} is thinking...\n#{@@white}"
            input = game.player_2.choice
        end
        game.evaluate(input)
    end

    def collection
        navigator
    end
    
    def navigator(page = 1)
        display_cards(page)

        case page
        when 1
            puts "#{@@cyn}Enter #{@@white}\"next\"#{@@cyn} to view the next page, or #{@@white}\"exit\"#{@@cyn} to exit."
        when Card.all.size
            puts "#{@@cyn}Enter #{@@white}\"previous\"#{@@cyn} to view the previous page, or #{@@white}\"exit\"#{@@cyn} to exit."
        else
            puts"#{@@cyn}Enter #{@@white}\"next\"#{@@cyn} to view the next page, #{@@white}\"previous\"#{@@cyn} to view the previous page, or #{@@white}\"exit\"#{@@cyn} to exit."
        end
        puts"#{@@cyn}\nTo view a hero in detail, enter its #{@@white}index#{@@cyn} number.\n\n#{@@white}"
        
        input = gets.strip
        input = input.to_i if input.to_i != 0
        while !((1..Card.all.size).include?(input) || input == "next" || input == "previous" || input == "exit") || (input == "next" && page == Card.all.size) || (input == "previous" && page == 1) 
            puts "#{@@cyn}\nSorry, that input is invalid.\n\n#{@@white}"
            input = gets.strip
            input = input.to_i if input.to_i != 0
        end
        
        case input
        when "exit"
        when "next"
            page += 1
            navigator(page)
        when "previous"
            page -= 1
            navigator(page)
        else
            display_detail(page, input)
        end
    end
    
    def display_cards(page) # MUST IMPLEMENT EDGE CASE HERE!!!!
        puts "#{@@cyn}\nDisplaying page #{@@white}#{page}#{@@cyn} of #{@@white}#{(Card.all.count/60.0).ceil}#{@@cyn}.\n\n#{@@white}"
        (0..19).each {|index|
            a = (page-1)*60 + index*3 + 1
            table_puts("#{a}. #{Card.all[a-1].name}",
            "#{a+1}. #{Card.all[a].name}",
            "#{a+2}. #{Card.all[a+1].name}")
        }
        puts ""
    end

    def table_puts(a, b, c)
        puts "        #{a}#{filler(a)}#{b}#{filler(b)}#{c}#{filler(c)}"
    end

    def filler(a)
        " "*(30 - a.size)
    end

    def display_detail(page, index)
        puts Card.all[index-1].bio
        puts "#{@@cyn}Enter #{@@white}\"back\"#{@@cyn} to go back to the browsing, or #{@@white}\"exit\"#{@@cyn} to return to the main menu.\n\n#{@@white}"
        
        input = gets.strip
        while !(input == "back" || input == "exit") 
            puts "#{@@cyn}\nSorry, that input is invalid.\n\n#{@@white}"
            input = gets.strip
        end
        navigator(page) if input == "back"
    end
end