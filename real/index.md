@def title = "Structure of Real World Networks"

# Structure of Real World Networks

We discuss component sizes, path lengths and the small-world effect, degree distributions and power laws, clustering coefficients, and network correlations.

## Components

### Undirected Networks

In an undirected network, we typically find that there is a large component
that fills most of the network—usually more than half and not infrequently over 90% of the nodes—while the rest of the network is divided into a large number of small components disconnected from the rest.

A typical example of this kind of behavior is the network of film actors. In this network the nodes represent actors in movies and there is an edge between two actors if they have ever appeared in the same movie. In a version of the network from May 2000, it was found that 440,971 out of 449,913 actors were connected together in the largest component, or about 98%. Thus, just 2% of actors were not part of the largest component.

There are quite a few networks for which the largest component fills the entire network so that $S=1$, meaning that the network has only a single component and no smaller components. The Internet is a communication network — its reason for existence is to provide connections between its nodes. There would be little point in being a part of the Internet if you are not part of its largest component, since that would mean that you are disconnected from and unable to communicate with almost everyone else.

In some other cases the largest component fills the network because of the way the network is measured. Since a crawler can only find a web page if that page is linked to by another page, it follows automatically that all pages found by a single crawl will be connected in a single component.

Can a network have two or more large components that fill a sizable fraction of the entire network? Usually the answer to this question is no. If we had a network of $n$ nodes that was divided into two large components of about $\dfrac{1}{2}n$ nodes each, then there would be $\dfrac{1}{4}n^{2}$ possible pairs of nodes such that one node was in one large component and the other node in the other large component. If there is an edge between any of these pairs of nodes, then the two components are joined together and are in fact just one component. Except in very special cases, it is highly unlikely that not a single such pair would be connected, and hence also highly unlikely that we will have two large components.

Given a graph $G$ ...

```python
# Returns the number of components.
num = nx.number_connected_components(G)

# Returns the connected components of a graph
comps = nx.connected_components(G)

# You can sort this by length.
comp_sorted = sorted(comps, key=len, reverse=True)

# If you only want the largest connected component.
largest_cc = max(nx.connected_components(G), key=len)

# To create the induced subgraph of each component use:
S = [G.subgraph(c).copy() for c in comps]
```

### Directed Networks

The component structure for directed networks is more complicated than for undirected ones. Directed networks have weakly and strongly connected components.

A strongly connected component is a set of nodes such that each can reach and is reachable from all others in the set along a directed path. As with weakly connected components, there is typically one large strongly connected component in a directed network and a selection of small ones. Associated with each strongly connected component is an out-component (the set of all nodes that can be reached along a directed path from any starting point in the strongly connected component) and an in-component (the set of nodes from which the strongly connected component can be reached).

Not all directed networks have a large strongly connected component. In particular, an acyclic network has no strongly connected components of size greater than one since if two nodes belong to the same strongly connected component then by definition there exists a directed path in both directions between them, and hence there is a cycle from one node to the other and back. Real-life networks are not usually perfectly acyclic, but some, such as citation networks, are approximately so (see Section 3.2). Such networks typically have a few small strongly connected components of two or perhaps three nodes each, but no large ones.

```python
# Returns the number of components.
num = nx.number_strongly_connected_components(G)

# Returns the connected components of a graph
comps_0 = nx.strongly_connected_components(G)
comps_1 = nx.kosaraju_strongly_connected_components(G)
comps_2 = nx.strongly_connected_components_recursive(G)
```

## Shortest Paths

One of the most remarkable and widely discussed of network phenomena is the small-world effect, the finding that in many networks—perhaps most—the typical distances between pairs of nodes are surprisingly short.

Let us define $d_{ij}$ to be the length of the shortest path through the network between nodes $i$ and $j$. We define the mean distance $l$ between nodes for the network as a whole as the average of the mean distance over all nodes:

$$
l = \dfrac{1}{n^2}\sum_{ij}d_{ij}
$$

In mathematical terms, the small-world effect is the hypothesis that this mean distance is small. One can well imagine that the small-world effect could have substantial implications for networked systems. Suppose a rumor or a disease is spreading over a social network for instance. Clearly it will reach people much faster if it is only six steps from any person to any other than if it is a hundred, or a million.

One can also examine the diameter of a network which is the length of the longest finite distance between any pair of nodes in the network. The diameter is usually found to be relatively small as well and calculations using network models suggest that it should scale logarithmically with $n$. The diameter of a network could be affected substantially by a small change to only a single node or a few nodes, which makes it a poor indicator of the typical behavior of the network as a whole.

Another interesting twist on the small-world effect was discussed by Mil- gram in his original paper on the problem. He noticed, in the course of his letter-passing experiments, that most of the letters destined for a given target person passed through just one or two acquaintances of the target. This idea, that one or two of your acquaintances are espe- cially well connected and responsible for most of the connection between you and the rest of the world, has been dubbed _funneling_. For instance, in the coauthorship network of physicists we find that, for physicists having five or more collaborators, 48% of shortest paths go through a single neighbor of the average node, the remaining 52% being distributed over the other four or more neighbors. A similar result is seen in the Internet: among nodes having degree five or greater in a May 2005 snapshot of Internet structure at the autonomous system level, an average of 49% of shortest paths go through a single neighbor of the average node.

Given a graph $G$...

```python
# Returns shortest path between specified node and target.
single = nx.shortest_path(G, source=0, target=4)

# Returns multiple shortest paths if they exist.
multiple = [p for p in nx.all_shortest_paths(G, source=0, target=2)]

# Returns shortest paths for all pairs of nodes.
all_pairs = dict(nx.all_pairs_shortest_path(G))

# Returns the shortest path for weighted graphs.
weighted = nx.dijkstra_path(G, 0, 4)
```

## Degree Distributions

Consider an undirected network. Let us define $p_k$ to be the fraction of nodes that have degree $k$. The quantities $p_k$ represent the degree distribution of the network. They tell us the frequency with which nodes of different degrees appear in the network.
The value pk can also be thought of as a probability. It is the probability that a randomly chosen node in the network has degree $k$.

It is probably obvious, but bears saying anyway, that a knowledge of the degree distribution (or degree sequence) does not, in most cases, tell us the complete structure of a network. For most choices of node degrees there is more than one network with those degrees.

It is often illuminating to make a plot of the degree distribution of a large network as a function of $k$. The figure reveals something interesting: most of the nodes in the network have low degree—one or two or three—but there is a significant “tail” to the distribution, corresponding to nodes with substantially higher degree. We call such a well-connected nodes a hub.

In fact, it turns out that almost all real-world networks have degree distributions with a tail of high-degree hubs like this. In the language of statistics we say that the degree distribution is right-skewed.

```python
# Returns the degree sequence of a graph.
degree_sequence = [d for n, d in G.degree()]
```

### Power Laws

Another interesting feature of the degree distribution of right-skewed networks is that when they are plotted on logarithmic scales degree distribution roughly follows a straight line. In mathematical terms that means the logarithm of $p_k$ is a linear function of the logarithm of $k$, thus:

$$
\ln p_k = -\alpha \ln k + c
$$

where $\alpha$ and $c$ are constants. Taking the exponential of both sides of the euqation, we can also write the relation between $p_k$ and $k$ in the form

$$
p_k = Ck^{-\alpha}
$$

where $C= e^{c}$ is another constant. Distributions of this form, varying as a power
of k, are called power laws. This is, in fact, a common pattern seen in quite a few networks. The constant $\alpha$ is known as the exponent of the power law. Values in the range $2 \leq \alpha \leq 3$ are typical, although values a little outside this range are possible and are observed occasionally.

A true power-law distribution is monotonically decreasing over its entire range and hence the degree distribution must in this case deviate from the true power law in the small-k regime. This is typical. A common situation is that the power law is obeyed in the tail of the distribution, for large values of k, but not in the small-k regime. When one says that a particular network has a power-law degree distribution one usually means only that the tail of the distribution has this form. Networks with power-law degree distributions are often called scale-free networks.

Power laws turn up in a wide variety of places, not just in networks. They are found in the sizes of city populations, earthquakes, moon craters, solar flares, computer files, and wars; in the frequency of use of words in human languages, the frequency of occurrence of personal names in most cultures, the numbers of papers scientists write, and the number of hits on web pages; in the sales of books, music recordings, and almost every other branded commodity; and in the numbers of species in biological taxa.

## Distributions of Other Measures

### Centrality

Given its similarity to degree centrality, it is perhaps not surprising to learn that eigenvector centrality, like degree, often has a right-skewed distribution. Betweenness centrality also tends to have right-skewed distributions in most networks. An exception to this pattern is the closeness centrality, which is the reciprocal of the mean shortest-path distance from a node to all other reachable nodes. The values of the mean distance typically have quite a small range—they are bounded above by the diameter of the network and bounded below by 1. This means in practice that the closeness centrality cannot have a broad distribution or a long tail.

### Clustering

If we consider a network with a given degree distribution in which connections between nodes are made at random, the clustering coefficient takes the value

$$
C = \dfrac{1}{n} \cdot \dfrac{(\langle k^2 \rangle - \langle k \rangle)^2}{\langle k \rangle^3}
$$

where $\langle k \rangle$ and $\langle k^2\rangle$ are the mean degree and mean-square degree in the network, respectively. We expect the clustering coefficient to be very small in large networks, but many of them turn out to be much larger than the estimate given by equation.

This large difference is likely indicative of real social effects at work -- researchers apparently do not choose their collaborators at random, and moreover choose them in a way that gives rise to a high density of triangles and hence a high value of $C$. There are a number of reasons why a real collaboration network might contain more triangles than one would expect by chance. One possibility is that people might introduce pairs of their collaborators to each other and those pairs might then go on to collaborate themselves.

However, it is not always the case that the measured clustering coefficient greatly exceeds the expected value given by equation -- i.e the Internet. In some other networks, such as food webs or the World Wide Web, clustering is neither higher nor lower than expected, taking values roughly comparable with those derived.
