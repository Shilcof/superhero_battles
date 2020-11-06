class CLI

    def call
        puts "\n\nWelcome to Superhero Battles!\n
        Collecting your heroes...\n\n"
        Card.create_from_array(API.new.get_heroes)
        # Asks for optional name?
        menu
    end

    def menu
        puts "Please select which option you would like:\n
        1. Play a game of Superhero Battles vs the computer.
        2. View the Superhero Battles cards.
        3. Exit Superhero Battles.\n\n"
        input = gets.strip.to_i
        while !(1..3).include?(input)
            puts "\nSorry, that input is invalid, please enter a number from 1 to 3.\n\n"
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
            puts "\nI hope you enjoyed playing Superhero Battles!\n\n"
        end
    end

    def play
        Game.new.play
        puts Card.all.size
    end

    def collection
        navigator
    end
    
    def navigator(page = 1)
        display_cards(page)

        case page
        when 1
            puts "Enter \"next\" to view the next page, or \"exit\" to exit."
        when Card.all.size
            puts "Enter \"previous\" to view the previous page, or \"exit\" to exit."
        else
            puts"Enter \"next\" to view the next page, \"previous\" to view the previous page, or \"exit\" to exit."
        end
        puts"\nTo view a hero in detail, enter its index number.\n\n"
        
        input = gets.strip
        input = input.to_i if input.to_i != 0
        
        while !((1..Card.all.size).include?(input) || input == "next" || input == "previous" || input == "exit") || (input == "next" && page == Card.all.size) || (input == "previous" && page == 1) 
            puts "\nSorry, that input is invalid.\n\n"
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
            display_detail(input)
        end
        
    end
    
    def display_cards(page) # MUST IMPLEMENT EDGE CASE HERE!!!!
        puts "\nDisplaying page #{page} of #{(Card.all.count/60.0).ceil}\n\n"
        (0..19).each {|index|
            a = (page-1)*60 + index*3 + 1
            table_puts("#{a}. #{Card.all[a].name}",
            "#{a+1}. #{Card.all[a+1].name}",
            "#{a+2}. #{Card.all[a+2].name}")
        }
        puts ""
    end

    def table_puts(a, b, c)
        puts "        #{a}#{filler(a)}#{b}#{filler(b)}#{c}#{filler(c)}"
    end

    def filler(a)
        Array.new(30 - a.split("").size, " ").join
    end

    def display_detail(index) # MUST UPDATE THIS TO RUN PROPERLY ----- Back to navigator, or exit!!
        hero = Card.all[index-1]
        puts "
        #{hero.name}
        "
    end
    
end