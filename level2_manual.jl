# Выболнить большую часть заданий ниже - привести примеры кода под каждым комментарием


#===========================================================================================
1. Переменные и константы, области видимости, cистема типов:
приведение к типам,
конкретные и абстрактные типы,
множественная диспетчеризация,
=#

# Что происходит с глобальной константой PI, о чем предупреждает интерпретатор?
const PI = 3.14159
PI = 3.14

#=ОТВЕТ: "WARNING: redefinition of constant Main.PI. This may fail, 
cause incorrect answers, or produce other errors."
Julia разрешает заменять имена констант/функций (pi, sqrt...) на свои значения, 
но это не рекомендуется, т.к. возможны ошибки
=#
# Что происходит с типами глобальных переменных ниже, какого типа `c` и почему?
a = 1
b = 2.0
c = a + b
#ОТВЕТ:
typeof(a) #Int64
typeof(b) #Float64
typeof(c) #Float64
#сложили переменные разного типа в итоге ответ того типа, который является шире. 

# Что теперь произошло с переменной а? Как происходит биндинг имен в Julia?
a = "foo"
#=ОТВЕТ: а ссылается на ячейку в памяти, в которой хранится "foo". 
Если запустить , a = 2, а затем a = 3, то изменится «имя» a для ссылки на новое значение 3. 
2+2 все равно даст 4, а не 6=#

# Что происходит с глобальной переменной g и почему? Чем ограничен биндинг имен в Julia?
g::Int = 1
g = "hi"

function greet()
    g = "hello"
    println(g)
end
greet()

#=ОТВЕТ: 
1) тип переменной задан глобально, при попытке записать другое значение выходит ошибка:
"ERROR: MethodError: Cannot `convert` an object of type String to an object of 
type Int64. The function `convert` exists, but no method is defined for this combination of argument types."
Глобальную переменную Julia сначала пытается преобразовать в соответствующий тип, используя convert:
для int -> char метод не предопределен, так что переход невозможен =#
#2) биндинг имен для глобальных переменных (при переназначении) ограничен функцией convert. 
#В случае же:
g = 1
g = "hi"
#ошибки не будет, так как переменная локальная
#3) внутри function создается собственная переменная g, не относящаяся к глобальной
greet() #String
typeof(g) #Int64

# Чем отличаются присвоение значений новому имени - и мутация значений?
v = [1,2,3]
z = v
v[1] = 3
v = "hello"
z
#=ОТВЕТ:
присвоение - задать новую переменную для к-л значения ( v = [1,2,3] или z = v )
мутация - изменить значение ( v[1] = 3 или v = "hello" )
при этом в "z" все еще будет храниться сслыка на массив, выдающая: 
3
2
3
=#

# Написать тип, параметризованный другим типом
#ОТВЕТ:
x = 1.5
typeof(x) #Float64
x = Float32(-1.5) 
x #-1.5f0
typeof(x) #Float32

#=
Написать функцию для двух аругментов, не указывая их тип,
и вторую функцию от двух аргментов с конкретными типами,
дать пример запуска
=#
#ОТВЕТ:
function fun1(x, y)
    x + y
end
fun1(3, 4.5) # 7.5

function fun2(x::Int, y::Float64)
    x + y
end
fun2(3, 4.5) # 7.5

#=
Абстрактный тип - ключевое слово?
Примитивный тип - ключевое слово?
Композитный тип - ключевое слово?
=#
#ОТВЕТ:
# (1) Абстрактный тип: 
abstract type «name» end 
#или
abstract type «name» <: «supertype» end # <: - "является подтипом" супертипа
# name - Number|Real|AbstractFloat|Integer|Signed|Unsigned|...
# (2) Примитивный тип:
primitive type «name» «bits» end
primitive type «name» <: «supertype» «bits» end
# name - Float32|Float64|Bool|Char|Int8|UInt8|...
# (3) Композитный тип (пример):
struct X
    a::Int
    b::Float64
end


#=
Написать один абстрактный тип и два его подтипа (1 и 2)
Написать функцию над абстрактным типом, и функцию над её подтипом-1
Выполнить функции над объектами подтипов 1 и 2 и объяснить результат
(функция выводит произвольный текст в консоль)
=#
abstract type Fruits end
color(a::Fruits) = a.color

struct Apple <: Fruits
    color::String
    size::Int
end

struct Banana <: Fruits  
    color::String
    size::Int
end
d = Apple("red", 45)
color(d)
b = Banana("yellow", 50)
color(b)


#===========================================================================================
2. Функции:
лямбды и обычные функции,
переменное количество аргументов,
именованные аргументы со значениями по умолчанию,
кортежи
=#

# Пример обычной функции
#ОТВЕТ:
function f(x, y)
    x + y
end
# Пример лямбда-функции (аннонимной функции)
#ОТВЕТ:
x -> x^2 + 2x - 1
#ИЛИ
function (x)
    x^2 + 2x - 1
end
# Пример функции с переменным количеством аргументов
#ОТВЕТ:
fun(a, b, x...) = (a, b, x)  
fun(1, 2) #(1, 2, ())
fun(1, 2, 3) #(1, 2, (3,))
x = (2, 3, 4)
fun(1, x...) #(1, 2, (3, 4))
# Пример функции с именованными аргументами
function plot(x, y; style="solid", width=1, color="black")
    ###
end
# Функции с переменным кол-вом именованных аргументов
function plot(x...; style="solid")
    ###
end
#=
Передать кортеж в функцию, которая принимает на вход несколько аргументов.
Присвоить кортеж результату функции, которая возвращает несколько аргументов.
Использовать splatting - деструктуризацию кортежа в набор аргументов.
=#
#ОТВЕТ:
fun(a, x...)  = (a, x)  
Z = (2, 3, 4)
tuple = (fun(1, Z), 5)
tuple[1] #(1, (2, 3, 4), ())

#===========================================================================================
3. loop fusion, broadcast, filter, map, reduce, list comprehension
=#

#=
Перемножить все элементы массива
- через loop fusion и
- с помощью reduce
=#
#ОТВЕТ: 
fun(a) = 3*a 
A = [1.0, 2.0, 3.0]
[2*fun(A[i]) for i in [1,2,3]]

fun(a) = 3*a 
fun(A)
#=
Написать функцию от одного аргумента и запустить ее по всем элементам массива
с помощью точки (broadcast)
c помощью map
c помощью list comprehension
указать, чем это лучше явного цикла?
=#
#ОТВЕТ: занимает намного меньше места
B = [1.0, 2.0, 3.0]
fun(a) = 3*a 
broadcast(fun, B)

map(fun, B)

C = [4*B[i] for i=1:3]
# Перемножить вектор-строку [1 2 3] на вектор-столбец [10,20,30] и объяснить результат
#ОТВЕТ: матрица (1 х 3) умножается на (3 х 1) получаем одно число 
str1 = [1 2 3]
str2 = [10, 20, 30]
str1*str2 # 1x1


# В одну строку выбрать из массива [1, -2, 2, 3, 4, -5, 0] только четные и положительные числа
#ОТВЕТ:
A = [1, -2, 2, 3, 4, -5, 0]
D = [x for x in A if x > 0 && x % 2 == 0]
D

# Объяснить следующий код обработки массива names - что за number мы в итоге определили?
using Random
Random.seed!(123)
names = [rand('A':'Z') * '_' * rand('0':'9') * rand([".csv", ".bin"]) for _ in 1:100]
# ---
same_names = unique(map(y -> split(y, ".")[1], filter(x -> startswith(x, "A"), names)))
numbers = parse.(Int, map(x -> split(x, "_")[end], same_names))
numbers_sorted = sort(numbers)
number = findfirst(n -> !(n in numbers_sorted), 0:9)

# Упростить этот код обработки:
using Random
Random.seed!(123)
names = [string(rand('A':'Z'), '_', rand('0':'9'), rand([".csv", ".bin"])) for _ in 1:100]
same_names = unique([split(y, ".")[1] for y in names if startswith(y, "A")])
numbers = sort(parse.(Int, map(x -> split(x, "_")[end], same_names)))
number = findfirst(n -> !(n in numbers), 0:9)
#=
ОТВЕТ: элементы массива names имеют вид "B_9.bin"
код рассматривает элементы, что начинаются на А и сохраняет их цифру и после сортирует 
("А_0.bin" -> A_0 -> 0)
в findfirst создается массив элементов от 0 до 9, ищется первый элемент, который не 
встречается в векторе numbers_sorted и выводит его порядковый номер 
(где 0:9, если нет 1 - то результат: 2)
=#

#===========================================================================================
4. Свой тип данных на общих интерфейсах
=#

#=
написать свой тип ленивого массива, каждый элемент которого
вычисляется при взятии индекса (getindex) по формуле (index - 1)^2
=#
#ОТВЕТ:
struct Lazyarr
    length::Int
end

Base.getindex(arr::Lazyarr, i::Int) = (i - 1)^2  

A = Lazyarr(15) 
println(A[15])
#=
Написать два типа объектов команд, унаследованных от AbstractCommand,
которые применяются к массиву:
`SortCmd()` - сортирует исходный массив
`ChangeAtCmd(i, val)` - меняет элемент на позиции i на значение val
Каждая команда имеет конструктор и реализацию метода apply!
=#
abstract type AbstractCommand end
apply!(cmd::AbstractCommand, target::Vector) = error("Not implemented for type $(typeof(cmd))")

abstract type AbstractCommand end
apply!(cmd::AbstractCommand, target::Vector) = error("Not implemented for type $(typeof(cmd))")

struct Sort <: AbstractCommand
end

struct ChangeAt <: AbstractCommand
    index::Int
    val::Any
end

function apply!(cmd::Sort, target::Vector)
    sort!(target)
end

function apply!(cmd::ChangeAt, target::Vector)
    target[cmd.index] = cmd.val
end

A = [4, 5, 6, 1, 0]
B = Sort() 
apply!(B, A)
println(A)

C = ChangeAt(2, 44)
apply!(C, A)
println(A)
# Аналогичные команды, но без наследования и в виде замыканий (лямбда-функций)
function Sort2()
    return (target::Vector) -> sort!(target)
end

function ChangeAt2(index::Int, val::Any)
    return (target::Vector) -> target[index] = val
end

UseSort2 = Sort2()
UseChangeAt2 = ChangeAt2(2, 44)

A = [4, 5, 6, 1, 0]
UseSort2(A)
println(A)
UseChangeAt2(A)
println(A)

#===========================================================================================
5. Тесты: как проверять функции?
=#

# Написать тест для функции
using Test
foo(x) = length(x)^2
@test foo("bar") == 9

#===========================================================================================
6. Дебаг: как отладить функцию по шагам?
=#

#=
Отладить функцию по шагам с помощью макроса @enter и точек останова
=#
function foo(x, y)
    a = x + y
    b = a^2 # x=5 y=3 a=8
    return b # x=5 y=3 b= 64 a=8
end

@enter foo(5, 3)

#===========================================================================================
7. Профилировщик: как оценить производительность функции?
=#
using Profile
функция для профилировки
#профилирование включается для данного вызова с помощью @profil eмакроса.
@profile 'имя функции'
#Получить результаты профилирования
Profile.print()
#=
Оценить производительность функции с помощью макроса @profview,
и добавить в этот репозиторий файл со скриншотом flamechart'а
=#

import Pkg
Pkg.add("ProfileView")
using Profile
function generate_data(len)
    vec1 = Any[]
    for k = 1:len
        r = randn(1,1)
        append!(vec1, r)
    end
    vec2 = sort(vec1)
    vec3 = vec2 .^ 3 .- (sum(vec2) / len)
    return vec3
end
generate_data(4)
@time generate_data(4); # 0.000041 seconds (45 allocations: 1.328 KiB)
@profview generate_data(1_000_000)


# Переписать функцию выше так, чтобы она выполнялась быстрее:
using ProfileView

function generate_data(len::Int) 
    vec1 = Vector{Float64}(undef, len)
    for i = 1:len
        vec1[i] = randn()
    end
    vec2 = sort(vec1)
    vec3 = vec2 .^ 3 .- (sum(vec2) / len)
    return vec3
end
generate_data(4)
@time generate_data(4); #0.000004 seconds (6 allocations: 288 bytes)
@profview generate_data(1_000_000);

#===========================================================================================
8. Отличия от матлаба: приращение массива и предварительная аллокация?
=#

#=
Написать функцию определения первой разности, которая принимает и возвращает массив
и для каждой точки входного (x) и выходного (y) выходного массива вычисляет:
y[i] = x[i] - x[i-1]
=#
x = [10, 2, 3, 4, 4]

function fun(x)
    n = length(x)
    y = Vector(undef, n-1)

    for i in 1:(n-1)
    y[i] = x[i+1] - x[i]
    end
    return y
end

d = fun(x)
#=
Аналогичная функция, которая отличается тем, что внутри себя не аллоцирует новый массив y,
а принимает его первым аргументом, сам массив аллоцируется до вызова функции
=#
x = [10, 2, 3, 4, 4]
y = Vector(undef, length(x)-1)

function fun(y, x)
    n = length(x)
    for i in 1:(n-1)
    y[i] = x[i+1] - x[i]
    end
    return y
end

d = fun(x)

#=
Написать код, который добавляет элементы в конец массива, в начало массива,
в середину массива
=#
x = [10, 2, 4, 4, 10]
y = ["meow", "meow"]
z = Vector(undef, length(x)+length(y))

function beginning(z, x, y)
    for i in 1:(length(y))
    z[i] = y[i]
    end
    for i in 1:(length(x))
    z[length(y)+i] = x[i]
    end
    return z
end
d = beginning(z, x, y)

function middle(z, x, y)
    n = div(length(x), 2)

    for i in 1:n
        z[i] = x[i]
    end
    for i in 1:(length(y))
        z[n+i] = y[i]
    end
    for i in (n+1):length(x)
        z[length(y)+i] = x[i]
    end
    return z
end
d = middle(z, x, y)


function ending(z, x, y)
    for i in 1:(length(x))
        z[i] = x[i]
        end
        for i in 1:(length(y))
        z[length(x)+i] = y[i]
        end
        return z
end
d = ending(z, x, y)

#===========================================================================================
9. Модули и функции: как оборачивать функции внутрь модуля, как их экспортировать
и пользоваться вне модуля?
=#


#=
Написать модуль с двумя функциями,
экспортировать одну из них,
воспользоваться обеими функциями вне модуля
=#
module Foo
    export foo
    end
 function foo(x, y) x^2 + 2x - 1
end
foo2(a, b) = a + b
 using .Foo
foo(2, 3)
foo2(1, 4)


#===========================================================================================
10. Зависимости, окружение и пакеты
=#

# Что такое environment, как задать его, как его поменять во время работы?
#= ОТВЕТ:
Переменная окружения - глобальная переменная, задается через ENV
значением этой переменной могут быть:
место размещения файлов в системе, рабочие директории, модули, пакеты
ENV["переменная"] = "значение" 
get(ENV, "переменная окружения", "значение если переменной нет")
 можено добавлять пакеты в окружение с помощью команды add
 можете сменить окружение, выполнив команду activate в режиме Pkg:
=#
my_variable1 = get(ENV, "var1", "Default value")
println(my_variable)

ENV["var2"] = "раз" 
my_variable2 = get(ENV, "var2", "Default value")
println(my_variable2)

# Что такое пакет (package), как добавить новый пакет?
#= ОТВЕТ:
Пакет - встроенный дополнительный функционал,
import Pkg
Pkg.add("Example") # где в "" - указан нужный пакет
using Example # для запуска/использования пакета
=#

# Как начать разрабатывать чужой пакет?
#= ОТВЕТ:
1. добавить пакет (Pkg.add("MyPackage"))
2. клонировать репозиторий к себе (git clone https://.../MyPackage.jl)
3. Перейти в каталог пакета (cd MyPackage.jl)
4. Активировать пакет 
using Pkg
Pkg.activate(".") 
=#

#=
Как создать свой пакет?
(необязательно, эксперименты с PkgTemplates проводим вне этого репозитория)
=#
mutable struct Animal
    cat::String
    dog::String
end

Base.show(i0::IO, animal::Animal) = print(i0, "Animal(cat=\"", animal.cat, "\", dog=\"", animal.dog, "\")")
my_animal = Animal("Имя_кота", "Имя_собаки")
println(my_animal)

Base.copy(animal::Animal) = Animal(animal.cat, animal.dog) 
Base.show(i0::IO, animal::Animal) = print(i0, "Animal(cat=\"", animal.cat, "\", dog=\"", animal.dog, "\")")
my_animal_2 = copy(my_animal)
println("копия ", my_animal_2)
my_animal_2.cat = "Милли"
println("копия ", my_animal_2)

#===========================================================================================
11. Сохранение переменных в файл и чтение из файла.
Подключить пакеты JLD2, CSV.
=#

# Сохранить и загрузить произвольные обхекты в JLD2, сравнить их

# Сохранить и загрузить табличные объекты (массивы) в CSV, сравнить их


#===========================================================================================
12. Аргументы запуска Julia
=#

#=
Как задать окружение при запуске?
=#

#=
Как задать скрипт, который будет выполняться при запуске:
а) из файла .jl
б) из текста команды? (см. флаг -e)
=#

#=
После выполнения задания Boids запустить julia из командной строки,
передав в виде аргумента имя gif-файла для сохранения анимации
=#
