@def title = "Introduction to Network Science"

# Introduction to Network Science

> A graph with no vertices and no edges is the null graph, regarded by some authors as a _pointless_ concept. - Gordon Royle

## Graph Connectivity

One of the most common questions you can ask about a network is whether nodes $u$ and $v$ are connected or not. For example,
if you are planning a road trip you need to know if it's even possible to reach your destination by car. Graph connectivity
is also related to the resilience of a network -- a power grid that requires the destruction of 20 power plants to cause a total
blackout is much more robust than one that disconnects after one explosion. Therefore, let's first formally define what we mean by connectivity.

A **_path_** from $u$ to $v$ is finite sequence of distinct edges that
begin at $u$ and end at $v$. A **_graph_** is said to be connected if there is a path between _any_ two vertices. For example, the following graph is connected because
the paths $(1,3)$, $(1,2)$ and $(3,1),(1,2)$ connect every pair of vertices.

```julia:./code/ex1
#hideall
using GraphRecipes
using Plots

const B = [0 1 1; 1 0 0; 1 0 0]

graphplot(B,
          markersize = 0.2,
          markercolor = range(colorant"yellow", stop=colorant"red", length=n),
          names = 1:3,
          fontsize = 10,
          linecolor = :darkgrey
          )

savefig(joinpath(@OUTPUT, "simple_graph.png"))
```

\fig{output/simple_graph.png}

```python
# Code to generate this tree.
# [] is a called list. [1,2,3] is the collection of numbers 1,2 and 3.

lst = [(1,2),(1,3)] # Each (x,y) pair consists of the starting and endpoint of each edge.
G = nx.from_edgelist(lst) # Create a graph G from the edgelist called lst.
```

Now, take a look at the following network. Is there a path from node $2$ to node $20$? Is the graph connected? This is a much more laborious problem to solve which is why we will later learn to leverage computers to solve such problems for us.

```julia:./code/ex2
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
