@def title = "Introduction to Network Science"

# Introduction to Network Science

> A graph with no vertices and no edges is the null graph, regarded by some authors as a _pointless_ concept.

## Graph Connectivity

One of the most common questions you can ask about a network is whether nodes $u$ and $v$ are connected or not. For example,
if you are planning a road trip you need to know if it's even possible to reach your destination by car. Graph connectivity
is also related to the resilience of a network -- a power grid that requires the destruction of 20 power plants to cause a total
blackout is much more robust than one that disconnects after one explosion. Therefore, let's first formally define what we mean by connectivity.

A **_path_** from $u$ to $v$ is finite sequence of distinct edges that
begin at $u$ and end at $v$. A **_graph_** is said to be connected if there is a path between _any_ two vertices. Now, take a look at the following network. Is there a path from node $2$ to node $20$? Is the graph connected?

```julia:./code/ex1
#hideall
using GraphRecipes
using Plots

const n = 22
const A = Float64[ rand() < 0.65 ? 0 : rand() for i=1:n, j=1:n]
for i=1:n
    A[i, 1:i-1] = A[1:i-1, i]
    A[i, i] = 0
end

graphplot(A,
          markersize = 0.2,
          node_weights = 1:n,
          markercolor = range(colorant"yellow", stop=colorant"red", length=n),
          names = 1:n,
          fontsize = 10,
          linecolor = :darkgrey
          )

savefig(joinpath(@OUTPUT, "test.png"))
```

\fig{output/test.png}
