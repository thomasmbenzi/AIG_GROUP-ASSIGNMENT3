
#___________
#Question 1
#___________
using Random
using Revise

 #Variables 
 variables = ["X1", "X2", "X3", "X4", "X5", "X6", "X7","X8","X9"]

 #Variable domains are the same
dX1 = dX2 = dX3 = dX4 = dX5 = dX6 = dX7 = dX8 = dX9 = ["r", "g", "b"]

#An array of the domains
dSet = [dX1, dX2, dX3, dX4, dX5, dX6, dX7,dX8,dX9]

#A function that describes the constraints: Returns true if two chosen states are neigbours
 function constrained(a, b)
    if (a !=b )
        if (a||b == "X1") && (a||b == "X2")
        return true
      elseif (a||b == "X1") && (a||b == "X3")
        return true
      elseif (a||b == "X2") && (a||b == "X3")
        return true
      elseif (a||b == "X3") && (a||b == "X4")
        return true
      elseif (a||b == "X4") && (a||b == "X5")
        return true
      elseif (a||b == "X5") && (a||b == "X6")
        return true
      elseif (a||b == "X6") && (a||b == "X7")
        return true
      elseif (a||b == "X7") && (a||b == "X8")
        return true
      elseif (a||b == "X8") && (a||b == "X9")
        return true
        else
        return false
        end
    end
end
      
#forward checking and propagation function
function forward_prop(d,v)
  for i in 1:length(d)
    for j in 2:length(v)
      d[i] =[randn([d[i]])]
      if constrained(v[i], v[j]) == true  #Forward-Check
      d[j] = setdiff(d[j], d[i])
    elseif constrained(v[i], v[j]) == false #propagation
        d[j]  = d[i]
      end
    end
    println("Current Domains: ", d)
    if d[i] == []
      println("There is no solution at element number: ", i)
    end
    j = j + 1
  end
end

forward_prop(dSet,variables)

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
