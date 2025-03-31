module GameOfLife
using Plots

#=
Живая ячейка с менее чем двумя живыми соседями умирает, как будто от недонаселения.
Живая ячейка с двумя или тремя живыми соседями выживает до следующего поколения.
Живая ячейка с более чем тремя живыми соседями умирает, как будто от перенаселения.
Мертвая ячейка ровно с тремя живыми соседями становится живой, как будто от размножения.
=#

mutable struct Life
    current_frame::Matrix{Int}
    next_frame::Matrix{Int}
end

function step!(state::Life)
    curr = state.current_frame
    next = state.next_frame
    rows, cols = size(curr)

    for i in 1:rows
        for j in 1:cols
            sum = 0
            for x in -1:1
                for y in -1:1
                    if x == 0 && y == 0
                        continue
                    end

                    neight_row = mod1(i + x, rows)
                    neight_col = mod1(j + y, cols)

                    sum += curr[neight_row, neight_col]
                end
            end

            if curr[i, j] == 1 #если ячейка жива
                if sum < 2
                    next[i, j] = 0  #смерть от недонаселения
                elseif sum > 3
                    next[i, j] = 0 #смерть от перенаселения
                else
                    next[i, j] = 1  #выживает до следующего поколения
                end
            else  #если ячейка мертва
                if sum == 3
                    next[i, j] = 1  #становится живой
                else
                    next[i, j] = 0  #ничего
                end
            end
        end
    end

state.current_frame, state.next_frame = state.next_frame, state.current_frame 
return nothing
end


function (@main)(ARGS)
    n = 30
    m = 30
    init = rand(0:1, n, m)

    game = Life(init, zeros(n, m))

    anim = @animate for time = 1:100
        step!(game)
        cr = game.current_frame
        heatmap(cr)
    end
    gif(anim, "life.gif", fps = 10)
end

export main

end

using .GameOfLife
GameOfLife.main("")
