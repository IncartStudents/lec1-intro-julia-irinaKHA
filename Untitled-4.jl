n = 0
while n < 10
    n +=1
    println(n)
end

myfriends = ["Tea","Robyn","Barney"]
i = 1
while i <= length(myfriends)
    friend = myfriends[i]
    println("Hi $friend, it's great to see you!")
    i +=1
end

for n in 1:10
    println(n)
end

myfriends = ["Tea","Robyn","Barney"]
i = 1
for friend in myfriends
    println("Hi $friend, it's great to see you!")
end

for n = 1:10
    println(n)
end

m, n = 5, 5
A = zeros(m,n)

for i = 1:m
    for j = 1:n
        A[i, j] = i +j 
    end
end
A

B = zeros(m, n)
for i = 1:m, j = 1:n
    B[i, j] = i + j 
end
B

