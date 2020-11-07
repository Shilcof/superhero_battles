module Players 
    class Computer < Player

        def choice(board)
            (1..6).sample # random player
        end

    end
end