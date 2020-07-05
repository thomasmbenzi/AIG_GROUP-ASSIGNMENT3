
#___________
#Question 1
#___________
function forward_prop(v,d,c)
    re = []

    for i in v
        for j in d
            append!(re,Dict(v[1] => d[1]))
            splice!(d,1)
            println(re,"  ===>  ",d)

            append!(re,Dict(v[2] => d[1]))
            filter!(e->e≠"g",d)
            println(re,"  ===>  ",d)

            a = ["r","g","b"]
            append!(re,Dict(v[3] => d[1]))
            filter!(e->e≠"b",a)
            println(re,"  ===>  ",a)

            append!(re,Dict(v[4] => a[1]))
            filter!(e->e≠"r",a)
            println(re,"  ===>  ",a)

            b = ["r","g","b"]
            append!(re,Dict(v[5] => a[1]))
            filter!(e->e∉["r","g"],b)
            println(re,"  ===>  ",b)

            append!(re,Dict(v[6] => b[1]))
            filter!(e->e∉["g","b"],b)
            println(re,"  ===>  ",b)

            c = ["r","g","b"]
            append!(re,Dict(v[7] => c[1]))
            filter!(e->e≠"r",c)
            println(re,"  ===>  ",c)

            append!(re,Dict(v[8] => c[1]))
            filter!(e->e≠"g",c)
            println(re,"  ===>  ",c)

            append!(re,Dict(v[9] => c[1]))
            break
        end
    end
    return re
end

v = ["X1","X2","X3","X4","X5","X6","X7","X8","X9"]
d = ["r","g","b"]
c = true

print(forward_prop(v,d,c))

#__________________
#Question 2
#__________________
function simultaneousGame(P1,P2)
    a = [3,2]
    b = [2,5]
    c = [-2,2]
    d = [3,0]

    #player 1
    function player1(P1)
        if P1[1] > P1[3] && P1[2] > P1[4]
            return (a,"a is strictly dominant and b is dominated strategy");
        elseif P1[3] > P1[1] && P1[4] > P1[2]
            return (b,"b is strictly dominant and a is dominated strategy");
        elseif P1[1] >= P1[3] && P1[2] >= P1[4]
            return (a,"a is weakly dominant");
        elseif P1[3] >= P1[1] && P1[4] >= P1[2]
            return (b,"b is a strictly dominant strategy");
        else
            return "P1, does not have a dominant strategy!"
        end # if
    end # function

    #Player 2
    function player2(P2)
        if P2[1] > P2[3] && P2[2] > P2[4]
            return (a,"In P2, a is strictly dominant and b is dominated strategy");
        elseif P2[3] > P2[1] && P2[4] > P2[2]
            return (b,"In P2, b is strictly dominant and a is dominated strategy");
        elseif P2[1] >= P2[3] && P2[2] >= P2[4]
            return (a,"In P2, a is weakly dominant");
        elseif P2[3] >= P2[1] && P2[4] >= P2[2]
            return (b,"In P2, b is a strictly dominant strategy");
        else
            return "P2, does not have a dominant strategy!"
        end # if
    end # function

    #mixed strategy
    p = 0
    q = 0


    return player1(P1),player2(P2)
end

P1 = [3,2,2,5]
P2 = [-2,2,3,0]

println(simultaneousGame(P1,P2))


#___________
#Question 3
#___________

#value iteration function
function MDP(S,A,R,y)
    viter = 0
    policy = 0

    for (i,value) in enumerate(S)
        for (j,v) in enumerate(A)
            if value == "S0"
                if v == "a0b" || v == "a1b"
                    viter = R[1]+y * (max(0.1*0.29,0.5*0.29+0.5*0.29))
                    println(viter)
                end
            end
            if value == "S1"
                if v == "a0c" || v == "a1c"
                    viter = R[2]+y*(max(0.8*0.0,0.1*0.0+0.9*0.0))
                    println(viter)
                end
                if v == "a1c" || v == "a2c"
                    viter = R[2]+y*(max(0.1*0.0,0.4*0.0+0.6*0.0))
                    println(viter)
                end
            end
            if value == "S2"
                if v == "a0d" || v == "a1d"
                    viter = R[3]+y*(max(0.7*0.7,0.4*0.0+1.0*0.0))
                    println(viter)
                end
                if v == "a1d" || v == "a2b"
                    viter = R[3]+y*(max(0.9*0.0,0.2*0.0+0.8*0.0))
                    println(viter)
                end
            end
        end
    end
    return viter
end

S = ["S0","S1","S2","S3"]
A = ["a0b","a1b","a2b"]
R = [40,60,80,100]
y = 0.5

print("Result: ",MDP(S,A,R,y))
