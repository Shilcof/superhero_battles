class CLI

    @@blu="\e[1;34m"
    @@cyn="\e[1;36m"
    @@white="\e[0m"

    attr_accessor :user

    def start
        puts "#{@@cyn}\n\nWelcome to Superhero Battles!\n\n#{@@white}Collecting your heroes...\n"
        Card.create_from_array(API.new.get_heroes)
        puts "#{@@cyn}\nPlease enter your name.\n#{@@white}"
        self.user = Player.new(gets.strip.capitalize)
        menu
    end

    MENU_OPTIONS = [:play, :collection, :results, :exit]

    def menu(*arg) # Main menu
        options_and_do(MENU_OPTIONS)
    end

    # -------------------------- Play methods -----------------------------

    PLAY_OPTIONS = [:play, :menu]

    def play
        # Game options def options
        # Which deck would you like to use? def deck_selector - if empty do nothing
        deck = Deck.new_random
        Game.new(user, deck)
        turn until current_game.winner
        puts "#{@@cyn}\nCongratulations #{@@white}#{current_game.winner.name}#{@@cyn}!!!\n\n#{@@white}#{@@cyn}Would you like to play again?\n#{@@white}"
        options_and_do(PLAY_OPTIONS)
    end

    def turn
        puts "#{@@white}#{current_game.players[0].name}#{@@cyn}'s turn!#{@@white}\n\n#{@@white}#{user.name}#{@@cyn}, your card is:\n#{@@white}"
        display_active_card
        current_game.evaluate(get_move)
        check_tie
        current_game.update
        puts "#{@@white}\n#{current_game.players[0].name}#{@@cyn} won with #{@@white}#{current_game.players[0].cards[-2].name}\n\n"
    end 

    def get_move
        if current_game.players[0] == user
            puts "#{@@white}\n#{current_game.players[0].name}#{@@cyn}, chose your category and enter #{@@white}\"1 - 6\"!\n\n"
            get_and_validate(1..6)
        else 
            puts "#{@@blu}\n#{current_game.players[0].name}#{@@cyn} is thinking...\n#{@@white}"
            current_game.players[0].choice
        end
    end

    def check_tie
        while current_game.round_score == 0
            puts "#{@@blu}\nTie!#{@@cyn} Please select another category.\n#{@@white}"
            current_game.evaluate(get_move)
        end
    end

    def current_game
        Game.all.last
    end

    # -------------------------- Results methods -----------------------------

    RESULTS_OPTIONS = [:menu]

    def results
        display_results
        options_and_do(RESULTS_OPTIONS)
    end

    def display_results
        if Game.all.size == 0
            puts "#{@@blu}\nThere are no previous games to show.\n#{@@white}"
        else
            puts "#{@@cyn}\nPrevious game results are:\n#{@@white}"
            puts get_results
        end
    end

    def get_results
        Game.all.collect.with_index(1){|game, i| "#{game.winner.name} won game #{i}!\n"}
    end

    # -------------------------- Collection methods -----------------------------

    COLLECTION_OPTIONS = [:detail, :next, :previous, :menu]
    
    def collection(page = 1)
        display_collection(page)
        options_and_do(page_options(page), page)
    end

    def page_options(page)
        case page
        when 1
            [COLLECTION_OPTIONS[0],COLLECTION_OPTIONS[1],COLLECTION_OPTIONS[3]]
        when (Card.all.count/60.0).ceil
            [COLLECTION_OPTIONS[0],COLLECTION_OPTIONS[2],COLLECTION_OPTIONS[3]]
        else
            COLLECTION_OPTIONS
        end
    end

    DETAIL_OPTIONS = [:back, :menu]

    def detail(page)
        puts "#{@@cyn}\nPlease enter the heroes index number.\n#{@@white}"
        display_detail(get_and_validate(1..(Card.all.size))-1)
        options_and_do(DETAIL_OPTIONS, page)
    end

    def next(page)
        collection(page+1)
    end

    def previous(page)
        collection(page-1)
    end

    def back(page)
        collection(page)
    end

    # -------------------------- Exit method -----------------------------

    def exit
        puts "#{@@cyn}\nThank you for playing Superhero Battles!\n#{@@white}"
    end

    # -------------------------- Helper methods -----------------------------

    OPTIONS_HASH = {
        play: "To play a game of Superhero Battles vs the computer.",
        collection: "To view the Superhero Battles cards collection.",
        results: "To view previous game results.",
        exit: "To exit Superhero Battles.",
        next: "To view the next page of the collection.",
        previous: "To view the previous page of the collection.",
        detail: "To view a hero in detail.",
        menu: "To return to the Superhero Battles main menu.",
        back: "To return to browsing."
    }

    def options_and_do(options, arg = nil)
        put_options(options)
        arg ? send(get_and_validate(options), arg) : send(get_and_validate(options))
    end

    def put_options(options)
        puts "\nPlease enter the number for the option that you would like:\n\n" + options.collect.with_index(1){|option, i| "#{i.to_s}#{filler(3, i.to_s.size)}#{@@cyn} #{OPTIONS_HASH[option]}\n#{@@white}"}.join
    end

    def get_and_validate(options)
        input = gets.strip.to_i
        while !(1..options.size).include?(input)
            puts "#{@@cyn}\nSorry, that input is invalid.\n#{@@white}"
            input = gets.strip.to_i
        end
        options.class == Array ? options[input - 1] : input
    end

    # -------------------------- Editing methods -----------------------------

    def display_active_card
        puts card_builder(user.current)
    end

    def card_builder(card)
        [card_top, card_body, card_body(card.name), card_body, card_body, card_body, card_body, 
        card.powerstats.collect{|i| [card_body("#{i[0].capitalize}: #{card.powerstats[i[0]]}"), 
        card_body]}, card_bottom].flatten
    end

    def tab
        " "*8
    end

    def card_top
        tab + "┌" + "─"*30 + "┐"
    end

    def card_body(body = "")
        tab + "|#{filler(15, (body.size/2.0).ceil)}#{body}#{filler(15, (body.size/2.0).floor)}|"
    end

    def card_bottom
        tab + "└" + "─"*30 + "┘"
    end

    def filler(a, b = 0)
        " "*(a - b)
    end

    def display_collection(page)
        puts "#{@@cyn}\nDisplaying page #{@@white}#{page}#{@@cyn} of #{@@white}#{(Card.all.count/60.0).ceil}#{@@cyn}.\n\n#{@@white}" +
        (0..19).collect{|index|
            a = (page-1)*60 + index*3 + 1
            columnise("#{a}. #{check_card_name(a-1)}", "#{a+1}. #{check_card_name(a)}", "#{a+2}. #{check_card_name(a+1)}")
        }.join("\n")
    end

    def check_card_name(index)
        Card.all[index] ? Card.all[index].name : "Coming soon!"
    end

    def columnise(a, b, c)
        tab + a + filler(30, a.size) + b + filler(30, b.size) + c + filler(30, c.size)
    end

    def display_detail(index)
        puts detail_correction(get_details(Card.all[index]))
    end

    DETAIL_LOOK_UP = ["powerstats", "appearance", "biography", "work", "connections"]

    def get_details(card)
        "#{@@blu}\n#{card.name}\n" + 
        DETAIL_LOOK_UP.collect{|topic|
            "#{@@cyn}\n#{topic.to_s.capitalize}:\n\n#{@@white}" + 
            card.send(topic).collect{|category, value|
                tab + "#{category.capitalize}: #{value}\n"
            }.join
        }.join
    end

    CORRECTION_LOOK_UP = [
        ["Superhero Battles ratings", "powerstats"], 
        ["Eye colour", "eyeColor"],
        ["Hair colour", "hairColor"],
        ["Full name", "fullName"],
        ["Alter egos", "alterEgos"],
        ["Birth place", "placeOfBirth"],
        ["First appearance", "firstAppearance"],
        ["Affiliated groups","groupAffiliation"]
    ]

    def detail_correction(string)
        CORRECTION_LOOK_UP.each{|str| string = string.gsub(str[1].capitalize,str[0])}
        string
    end

end