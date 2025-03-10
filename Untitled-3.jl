myphonebook = Dict("cat" => "^o^-_","dog"=>"uou-_")
myphonebook["Kramer"] = "555-FILK"

myphonebook
myphonebook["Kramer"]

pop!(myphonebook, "Kramer")
myphonebook

myfavoriteanimals = ("penguins","cats","dogs")
myfavoriteanimals[1]

myfriends = ["Ted", "Robyn","Lily"]
fibonacci = [1,1,2,3,5,8,13]
mix = [1,2,3.0,"hi"]

myfriends[3]
myfriends[3] = "Baby Bop"

push!(fibonacci,21)
pop!(fibonacci)
fibonacci

favorites = [["koobiden", "chocolate","eggs"],["penguins","cats","dogs"]]
numbers = [[1,2,3],[4,5],[6,7,8,9]]

rand(4,3)
rand(4,3,2) #вызывает две матрицы

