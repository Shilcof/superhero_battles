module Players 
    class Human < Player

        def choice(board)
            puts "#{self.name}, please pick a category 1 - 6."
            gets.strip
        end

    end
end