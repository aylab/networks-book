# This file was generated, do not modify it. # hide
#hideall
using GraphRecipes
using Plots

n = 5
const C = [0 1 1 1 1;1 0 1 1 1;1 1 0 1 1;1 1 1 0 1;1 1 1 1 0]

graphplot(C,
          markersize = 0.2,
          markercolor = range(colorant"yellow", stop=colorant"red", length=n),
          names = 1:3,
          fontsize = 10,
          linecolor = :darkgrey
          )

savefig(joinpath(@OUTPUT, "degree.png"))