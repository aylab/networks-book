# This file was generated, do not modify it. # hide
#hideall
using GraphRecipes
using Plots

n = 3
const B = [0 1 1; 1 0 0; 1 0 0]

graphplot(B,
          markersize = 0.2,
          markercolor = range(colorant"yellow", stop=colorant"red", length=n),
          names = 1:3,
          fontsize = 10,
          linecolor = :darkgrey
          )

savefig(joinpath(@OUTPUT, "simple_graph.png"))