# This file was generated, do not modify it. # hide
#hideall
using GraphRecipes
using Plots

const n = 3
A = [0 1 1;1 0 1;1 1 0]


graphplot(A,
          markersize = 0.2,
          markercolor = range(colorant"yellow", stop=colorant"red", length=n),
          names = 1:n,
          fontsize = 10,
          linecolor = :darkgrey
          )

savefig(joinpath(@OUTPUT, "test.png"))