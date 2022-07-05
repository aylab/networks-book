@def title = "Introduction to Network Science"

# Introduction to Network Science

This is a test.

> A graph with no vertices and no edges is the null graph, regarded by some authors as a _pointless_ concept. - Gordon Royle

## Degree

The degree of a node represents the number of connections it has. For example, a high degree node in a social network can signify
a popular individual. Similarly, a research paper with a significantly large degree might be influential in the field. The degree
of a node $i$ is designated as $k_i$.

For an _undirected graph_, the degree of a node is simply the number of nodes it is adjacent to. Moreover, the total number of
edges $|E|$ can also be derived by summing the degree of every node and halving the sum to account for the fact that each edge is counted twice.

$$
|E| = \dfrac{1}{2} \sum_{i=1}^{N}k_i
$$

Similarly, the average degree is simply this sum over the number of nodes without adjusting for the double counting.

$$
\langle k \rangle = \dfrac{1}{N} \sum_{i=1}^{N}k_i = \dfrac{2|E|}{N}
$$

Consider the following undirected network. There are 5 vertices and each of them are connected to 4 others. Since this is the maximum amount of edges each node in this
graph can have, this is known as the complete graph with 5 vertices or $K_5$.

```julia:./code/degree
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
```

\fig{output/degree.png}

The degree metrics for $K_5$ are as follows: $|E| = \dfrac{4 + 4 + 4 + 4 + 4}{2} = 10$ and $\langle k \rangle = \dfrac{2 \cdot 10}{5} = 4$.

```python
# Code for creating K_5 and calculating |E| and <k>

G = nx.complete_graph(5)
E = sum([x for _, x in G.degree()]) / 2
avg = 2*E/G.number_of_nodes()
```

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

## Paths

## Transitivity
