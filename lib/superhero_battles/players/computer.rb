module Players 
    class Computer < Player

        def choice
            sleep(1)
            rand(1..6) # random player
        end

    end
end