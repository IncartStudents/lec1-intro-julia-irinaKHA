# https://youtu.be/4igzy3bGVkQ

println("I'm excited to learn Julia")

123
456

my_answer = 42
typeof(my_answer)

my_pi = 3.141
typeof(my_pi)

my_name = "Ira"
typeof(my_name)

my_answer = my_name
typeof(my_answer)

# пу-пу комменты на русском?
#=
йеп, русские комменты 
не ломают файл
=#

sum = 3 + 7
difference = 10 - 3
product = 20 * 5
quotient = 100 / 10
power = 10 ^ 2
modulus = 101 % 2 #остаток

##############################################

s1 = "I am a string"
s2 = """ I am also a string"""

"""Look, Mom, no "errors"!!!"""

typeof('a')

name = "Ira"
num_fingers = 10
num_toes = 10

println("Hello, my name is $name.")
println("I have $num_fingers fingers and $num_toes toes. That is $(num_fingers + num_toes) digits")


string("Hom many cats ", "are too many cats?")
string("I don't know, but", 10, "are to few")

s3 = "Hom many cats ";
s4 = "are too many cats?";
s3*s4
"$s3$s4"

#########################################
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

###########################################
n = 0
while n < 10
    n += 1
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

c = [i + j for i in 1:m, j in 1:n]

for n in 1:10
    A = [i + j for i in 1:n, j in 1:n]
    display(A)
end

x = 8
y = 7 

if x > y
    println("$x is larger than $y")
elseif x < y
    println("$y is larger than $x")
else
    println("$x and $y are equal")
end

if x > y
    x
else
    y
end

# a ? b : c -> if a -> b else c end
(x > y) ? x : y

(x > y) && println("$x is larger than $y")
(x < y) && println("$x is smaller than $y")


function sayhi(name)
    println("Hi $name, it's great to see you!")    
end 

function f(x)
    x^2
end

sayhi("Kris")
f(42)

sayhi2(name) = println("Hi $name, it's great to see you")
f2(x) = x^2

sayhi2("mom")
f2(42)

sayhi3 = name -> println("Hi $name, it's great to see you")
f3 = x -> x^2
sayhi3("Chewbacca")
f3(42)

sayhi(55595)
A = rand(3, 3)
A
f(A)

v = rand(3)
f(v) #ошибка вектор в квадрат

v = [3, 5, 2]
sort(v)
v

sort!(v)
v

A = [i + 3*j for j in 0:2, i in 1:3]
f(A)
f.(A)

v = [1, 2, 3]
f(v) #ошибка
f.(v)

##############################
#Пакеты

import Pkg

Pkg.add("Example")
using Example
hello("it's me. I was wodering if after all these years...")

Pkg.add("Colors")
using Colors
palette = distinguishable_colors(100)
rand(palette, 3,3)
##############################
Pkg.add("Plots")
using Plots

x = -3:0.1:3
f(x) = x^2
y = f.(x)


gr() # загружает штуки для строит-а графиков
plot(x, y, label="line")
scatter!(x, y, label="points")

import Pkg; Pkg.add("PlotlyJS")
plotlyjs()
plot(x, y, label="line")
scatter!(x, y, label="points")

globaltemperatures = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8]
numpirates = [45000, 20000, 15000, 5000, 400, 17]
#переворачиваем ось
plot(numpirates, globaltemperatures, legend=false)
scatter!(numpirates, globaltemperatures, legend=false)

xflip!()
xlabel!("number of pirater [approximate]")
ylabel!("global temperatures (C)")
title!("Influence of pirate population on global warming")

#layout=(2,2) - СЕТКА, legend=false - подписи НЕ будет
p1 = plot(x, x)
p2 = plot(x, x.^2)
p3 = plot(x, x.^3)
p4 = plot(x, x.^4)
plot(p1, p2, p3, p4, layout=(2,2),legend=false)
################################
#Множественная диспетчеризация

methods(+)

#возвращает метод, связанный с используемым оператором
@which 3 + 3
@which 3.0 + 3.0
@which 3 + 3.0

import Base: +
"hello " + "world!" #ошибка
@which "hello" + "world!"

+(x::String, y::String) = string(x, y)
"hello " + "world!"
@which "hello " + "world!"

#группа методов с именем foo, которые принимают аргументы разного типа
foo(x, y) = println("duck-typed foo!")
foo(x::Int, y::Float64) = println("foo with an integer and a float")
foo(x::Float64, y::Float64) = println("foo with two floats!")
foo(x::Int, y::Int) = println("foo with two integers")

foo(1, 1)
foo(1., 1.)
foo(1, 1.0)
foo(true, false)

##############################
# ЛИНЕЙНАЯ АЛГЕБРА 

A = rand(1:4,3,3) #ранд цифры от 1 до 4, массив 3х3
B = A
C = copy(A)
[ B C]

A[1]=17
[B C]

x = ones(3)
b = A*x

#Транспонирование. Сопряженное - A.' 
Asum = A + A'
#умнож на Транспонированную
Apd = A'A

# Ах=b
A\b

Atall = A[:,1:2]
display(Atall)
Atall\b #решение находится по методу наим квадратов. Для точного матрица должна б. [n x n]

A = randn(3,3)
[A[:,1] A[:,1]]\b #сингулярная матрица. находит реш по методу "a rank deficient least squares problem

# Неопределенные системы
Ashort = A[1:2, :]
display(Ashort)
Ashort\b[1:2] #А короче b. решениетак же идет по наим. норме


