@def title = "Measures & Metrics"

# Measures & Metrics

## Centrality

### Degree Centrality

The simplest measure of centrality is the _degree centrality_. In undirected networks, the degree centrality of a node $i$ denoted by $x_i$ is simply the number of edges connected to it. For directed networks, we can use either the outgoing edges, incoming edges or both -- depending on the context. Even though degree centrality is a very simple measure, it can provide a lot of information about the structure of the network.

If we have a graph $G$, then the following code can be used to find the degree centrality of a particular node.

```python
# This creates a mapping from the node i to its degree x_i in a variable called x.
x = G.degree()

# To get the degree of node 1
x[1]
```

### Eigenvector Centrality

Degree centrality is only affected by the quantity of connections, but sometimes we want to define centrality in terms of the quality of the connections. Eigenvector centrality extends degree centrality by allocating points to a particular node in proportion to the centrality score of its neighbors. With eigenvector centrality, a node can be influential by knowing just a few influential nodes or by having many connections to nodes with average influence.

Essentially, the eigenvector centrality $x_i$ is defined to be proportional to the sum of the centralities of the neighbors of $i$ given a constant of proportionality $\kappa^{-1}$ such that

$$
x_i = \kappa^{-1} \sum_{j=1}^{n}A_{ij}x_{j}
$$

Without getting into the mathematical details, the multiplicative constant $\kappa^{-1}$ is taken to be the largest _eigenvalue_. This results in the centrality values being arbitrary relative to the constant -- as such, we are more interested in the relative difference in centrality between the nodes in the network.

If we have a graph $G$, we can calculate eigenvector centrality using the following code.

```python
# Creates a mapping from the node i to its degree x_i in a variable called x.
x = nx.eigenvector_centrality(G)

# If you need the centrality of node 2...
x[2]
```

Eigenvector centrality can also be used for directed networks -- in most cases, a node is influential if other (influential) nodes point towards it rather than the node itself pointing to others. Therefore, we make a slight adjustment to the definition...

$$
x_i = \kappa^{-1} \sum_{j} A_{ij}x_{j}
$$

However, there are some issues with this definition. For example, a node with no incoming edges is assigned a centrality of zero. Only nodes that are in a strongly connected component of two or more nodes, or the out-component of such a strongly connected component, can have non-zero eigenvector centrality.

### Katz Centrality

The main idea behind Katz centrality is to give some centrality score to every node for free no matter what. This ensures that every node has some miniscule positive centrality, and since this centrality gets passed on we do not end up with chains of nodes with zero centrality. Essentially, we define the Katz centrality $x_i$ of a node $i$ to be

$$
x_i = \alpha \sum_{j} A_{ij}x_{j} + \beta
$$

Here, $\alpha$ is a variable that weighs how much we value the centrality from the surrounding nodes and is usually chosen to be close to $1/\kappa_1$ where $\kappa_1$ is the largest positive eigvenvalue of the adjacency matrix.

If we have a graph $G$, we can calculate the Katz centrality using the following code.

```python
# Creates a mapping from the node i to its degree x_i in a variable called x.
x = nx.katz_centrality(G)

# You can also specify alpha and beta.
x_prime = nx.katz_centrality(G, alpha = 0.3, beta=0.5)

# If you need the centrality of node 2...
x[2]
```

### PageRank

If a node with high Katz centrality has edges pointing to many others then all of those others also get high centrality. A high-centrality node pointing to one million others gives all one million of them high centrality. One could argue that this is not always appropriate. In many cases it means less if a node is only one among many that are pointed to.

We can define variant of the Katz centrality in which the centrality I derive from my network neighbors is proportional to their centrality divided by their out-degree. Then nodes that point to many others pass only a small amount of centrality on to each of those others, even if their own centrality is high. Essentially,

$$
x_i = \alpha \sum_{j} A_{ij}\dfrac{x_j}{k_{j}^{out}} + \beta
$$

This centrality measure is commonly known as PageRank, which is a name given it by the Google web search corporation.

Given a graph $G$ and a value of $\alpha$, we can calculate the PageRank values for all of the nodes using the following code.

```python
# Calculate PageRank values.
X = nx.pagerank(G, alpha=0.75)

# Get the PageRank value of a particular node (e.g 2)
X[2]
```

### Closeness Centrality

Closeness centrality is a centrality score that measures the mean distance from a node to other nodes. Suppose $d_{ij}$ is the shortest distance from node $i$ to node $j$. Then the mean shortest distance from $i$ to every node in the network is

$$
l_i = \dfrac{1}{n}\sum_{j} d_{ij}
$$

The mean distance li is not a centrality measure in the same sense as the others in this chapter, since it gives low values for more central nodes and high values for less central ones, which is the opposite of our other measures. We can calculate the inverse instead which is called the closeness centrality $C_i$ as

$$
C_i = \dfrac{1}{l_i} = \dfrac{n}{\sum_{j} d_{ij}}
$$

The problem with this definition is that it does not make sense for networks with more than one component. In that case, we can redefine closeness in terms of the harmonic mean distance between nodes, i.e., the average of the inverse distances:

$$
C_{i}' = \dfrac{1}{n-1}\sum_{j \neq i}\dfrac{1}{d_{ij}}
$$

If we have a graph $G$, we can calculate the Closeness centrality using the following code.

```python
# Creates a mapping from the node i to its degree x_i in a variable called x.
x = nx.closeness_centrality(G)

# If you need the centrality of node 2...
x[2]
```

### Betweenness Centrality

A different concept of node importance is captured by betweenness centrality, which measures the extent to which a node lies on paths between other nodes. Let us make the simple assumption that every pair of nodes in the network exchanges messages at the same average rate and that messages always take the shortest available path though the network, or one such path chosen at random if there are several. The number of messages passing through each node is proportional to the number of shortest paths the node lies on. This number of shortest paths is what we call the betweenness centrality, or just betweenness for short.

The nodes with highest betweenness are also the ones whose removal from the network will most disrupt communications between other nodes in the sense that they lie on the largest number of paths taken by messages. If a node with high betweenness is removed then all the messages that would have passed through that node must now be rerouted another way.

Let $n^{i}_{st}$ be 1 if node $i$ lies on the shortest path from $s$ to $t$ and 0 if it does not or if there is no such path. Then the betweenness centrality $x_i$ is given by

$$
x_i = \sum_{st}n^{i}_{st}
$$

However, there may be multiple shortest paths between two nodes. The standard extension of betweenness to this case gives each path between two nodes a weight equal to the inverse of the number of paths, so that, for instance, if there are two shortest paths between a given pair of nodes, each of them gets weight $\frac{1}{2}$. Formally, we redefine $n^{i}_{st}$ to be the number of shortest paths from $s$ to $t$ that pass through $i$ and we define $g_{st}$ to be the total number of shortest paths from $s$ to $t$. Then the betweenness centrality of node $i$ on a general network is

$$
x_i = \sum_{st}\dfrac{n^{i}_{st}}{g_{st}}
$$

where we adopt the convention that $\dfrac{n^{i}_{st}}{g_{st}}=0$ if both $n^{i}_{st}$ and $g_{st}$ are zero.

```python
# Creates a mapping from the node i to its degree x_i in a variable called x.
x = nx.betweenness_centrality(G)

# You can also specify whether you want your results to be normalized,
# whether to include the endpoints and if your graph is large how many samples to take.
x = nx.betweenness_centrality(G, k = 10, normalized=False, endpoints=True)

# If you need the centrality of node 2...
x[2]
```

## Groups of Nodes

### Cliques

A clique is a set of nodes within an undirected network such that every member of the set is connected by an edge to every other. The occurrence of a clique in an otherwise sparsely connected network is normally an indication of a highly cohesive subgroup. In a social network, for instance, one might encounter a set of individuals each of whom was acquainted with each of the others, and such a clique would probably indicate that the individuals in question are closely connected.

Finding cliques is a computationally complex task. The following code block shows how to perform basic operations on a graph $G$ w.r.t cliques, but they might take a long time or never finish running depending on the size of the graph.

```python
# Returns all of the cliques in the graph.
all_cliques = nx.enumerate_all_cliques(G)

# For each node, returns the largest clique containing it. You can specify nodes
# of interest.
f_clique = nx.find_clique(G)
f_clique_prime = nx.find_clique(G, [0,1,2])

# Returns the size of the largest clique.
c_number = nx.graph_clique_number(G)
```

### $k$-cores

For many purposes a clique is too stringent a notion of grouping to be useful and it is natural to ask how one might define something more flexible. One possibility is the $k$-core. A $k$-core is a connected set of nodes where each is joined to at least k of the others.

A simple way to find them is to start with a given network and remove from it any nodes that have degree less than k, along with their attached edges. Note that we are not necessarily left with a single k-core—there’s no guarantee that the network will be connected once we are done pruning it, even if it was connected to start with.

Given a graph $G$ and a value of $k$, we can find the $k$-cores using the following code.

```python
x = nx.k_core(G, k=2)
```

### $k$-components

A component in an undirected network is a (maximal) set of nodes such that each is reachable by some path from each of the others. A useful generalization of this concept is the $k$-component. A $k$-component is a set of nodes such that each is reachable from each of the others by at least $k$ node-independent paths.

Given a graph $G$, the following code finds all $k$-components in the graph.

```python
x = nx.k_components(G)
```

## Clustering

### Clustering Coefficient

In mathematics a relation $\circ$ is said to be transitive if $a \circ b$ and $b \circ c$ together imply $a \circ c$. The fundamental type of relation between nodes in a network is “connected by an edge.” If the “connected by an edge” relation were transitive it would mean that if node $u$ is connected to node $v$, and $v$ is connected to $w$, then $u$ is also connected to $w$.

Perfect transitivity only occurs in networks where every component is a clique, but partial transitivity can be useful. In many networks, particularly social networks, the fact that $u$ knows $v$ and $v$ knows $w$ doesn’t guarantee that $u$ knows $w$, but makes it much more likely.

Let $\sigma(k)$ denote number of paths of length $k$ and let $\sigma_c(k)$ denote number of closed paths of length $k$. We define the clustering coefficient16 to be the fraction of paths of length two in the network that are closed.

$$
C = \dfrac{\sigma_c(2)}{\sigma(2)}
$$

$C=1$ implies perfect transitivity. $C=0$ implies no closed triads.

Given a graph G, we can calculate the average clustering coefficient for every node using the following code.

```python
C = nx.average_clustering(G)
```

### Local Clustering Coefficient

The clustering coefficient of the previous section is a property of an entire network. It quantifies the extent to which pairs of nodes with a common neighbor are also themselves neighbors, averaged over the whole network. It is, however, also sometimes useful to define a clustering coefficient for a single node.

Let $\Pi(i)$ denote the number of neighbors of $i$ and let $\Pi_c(i)$ denote the number of pairs of neighbors of $i$ that are connected to each other. For a node $i$, we can define

$$
C_i = \dfrac{\Pi_c(i)}{\Pi(i)}
$$

In many networks local clustering is found empirically to have a rough dependence on degree, nodes with higher degree having a lower local clustering coefficient on average. Local clustering can be used as an indicator of so-called “structural holes” in a network. While it is common in many networks, especially social networks, for the neighbors of a node to be connected among themselves, it does sometimes happen that these expected connections between neighbors are missing. The missing links are called structural holes. If we are interested in the efficient spread of information or other traffic around a network then structural holes are a bad thing -- they reduce the number of alternative routes information can take through the network.

The local clustering coefficient measures how influential a node is in this sense, taking lower values the more structural holes there are in the surrounding network. Thus, local clustering can be regarded as a type of centrality measure, albeit one that takes small values for powerful individuals rather than large ones. Local clustering is like a local version of betweenness that measures control over flows between just a node’s immediate neighbors.

```python
# Calculate the clustering coefficient for every node.
c = nx.clustering(G)

# Calculate the clustering coefficient for a particular node
c_zero = nx.clustering(G, 0)

# Get the clustering coefficient for node 0.
c[0]
```

## Structural Balance

In some social networks, and occasionally in other networks, edges are allowed to be either “positive” or “negative.” Such networks are sometimes called signed networks and their edges are called signed edges.

Networks containing only loops with even numbers of minus signs are said to show structural balance, or sometimes just balance. A balanced network can be divided into connected groups of nodes such that all connections between members of the same group are positive and all connections between members of different groups are negative. Networks that can be divided into groups like this are said to be clusterable.

Many real social networks are naturally found to be in a balanced or mostly balanced state. In such cases it would be possible, therefore, for the network to divide into groups such that everyone likes the people they know in their own group and dislikes those in other groups. Structural balance and clusterability is thus a model for the evolution of cliquishness or insularity, with people tending to stick together in like-minded groups and disdaining everyone outside their immediate community.
