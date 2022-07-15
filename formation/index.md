@def title = "Models of Network Formation"

# Models of Network Formation

Random network theory provides a simple basis for analyzing network structure analytically and computationally. Nevertheless, we must ask ourselves: _are real networks genuinely random_? As our intuition suggests, random networks possess some fundamental limitations that prevent them from describing real networks thoroughly. Random networks do not display transitivity nor clustering -- adjacent nodes do not correlate since they are placed randomly. In real networks, however, nearby nodes tend to be correlated and form groups. Random networks are also not scale-free and are not capable of exhibiting hubs.

To understand why random networks cannot create scale-free networks, we need to consider two essential assumptions in random networks. - The number of nodes in a network is fixed - Edges are created randomly.

These assumptions do not always hold in real networks. Nodes are continuously added to existing networks - for example, the internet started with a single lone webpage in 1991 and now contains more than $10^{12}$ pages. Similarly, most nodes in a real network are attracted to nodes with many existing links - a process known as preferential attachment. In this section, we will explore the concept of preferential attachment and understand why it may explain the structure of real networks.

## Generalized Price Model

In the 1950s, economist and future Nobel laureate Herbert Simon noticed that the distribution of people's wealth followed a power law in many cases. Simon hypothesized that people gained wealth at a rate proportional to their accumulated wealth, a.k.a “the rich get richer.” In the 1960s, Derek J. de Solla Price discovered that the citation network of scientific papers followed a similar power-law distribution and adopted Simon's model to understand the citation network structure.
In Price's model, scientists continuously publish new papers, and they always reference previously published papers. None of these papers disappear once they are published, so the size of the network is always growing. Each new node must cite $c$ papers on average. Still, most importantly, Price's model assumes that a new paper cites an old paper with a probability proportional to the number of citations the old paper already has. To account for papers with zero citations, the model adds a constant factor $a$ to the probability.

Let us examine the degree distribution of Price's model. Let $p_q$ denote the fraction of the network that has an indegree of $q$ and let $\alpha = 2 + a/c$. It can be shown that

$$
p_q = \dfrac{B(q + a, 2 + a/c)}{a, 1+a/c} \sim q^{-\alpha} \text{ for large } q
$$

Therefore, Price's simplified and necessarily incomplete model is able to generate the power-law degree distribution that we see in real networks. Price's model did not garner much attention until the 90s when it was independently discovered by Barabasi and Albert. The Barabasi-Albert model is a special case of the much more generalized Price model.

## Barabasi-Albert Model

In the previous model, incoming nodes were allowed to have a variable number of links as long as it averaged to $c$. Moreover, these were directed links since old papers cannot cite newer ones. The Barabasi-Albert model forces the network only to allow undirected edges, and every new node must have exactly $c$ links.

We initialize our network of $m$ nodes with an arbitrary selection of edges such that every node has at least one edge. We then choose $c \leq m$ and begin simulating the growth of the network. At each timestep we add a new node such that it has links to $c$ other nodes in the network. The new node can connect to any other node in the network, but the probability that it connects to a node $i$ is denoted by $\Pi(k_i)$
and is given by

$$
\Pi (k_i) = \dfrac{k_i}{\sum_{j} k_j}
$$

```python
import networkx as nx
G = nx.barabasi_albert(n, m)
```

### First Mover's Advantage

As the size of the network increases, existing nodes have to compete with a larger group of nodes for an incoming node's attention. Therefore, we might expect nodes that arrived early in the timeline to have a higher degree in the long run since they will have a higher opportunity to bind with an incoming node. This phenomenon is called the first mover's advantage - essentially, any profit gained early on will snowball into a huge lead, leaving the rest behind. The Barabasi-Albert model displays the first mover's effect, and hubs are gigantic because they arrived early in the network formation.

The Barabasi-Albert model incorporates growth and preferential attachment which allows networks to grow and older nodes to outcompete younger nodes to form hubs and display scale-free properties.

A Barabasi-Albert graph with a predefined number of nodes $n$ and number of edges $m$ can be created using the following code:

### Necessary Or Sufficient?

We have asserted that the Barabasi-Albert model uses both growth and preferential attachment to generate scale-free networks. Therefore, the natural question is to ask
whether both are necessary for the scale-free properties to emerge.

Consider a network model where we include growth but exclude preferential attachment. As before, we start out with $m$ nodes and whenever we add a new node we add $c$ links to it. However, the probability $Pi(k_i)$ is independent of the number of links the node $i$ currently possesses. It can be shown that the degree distribution of such a network follows an exponential distribution which decays too quickly to support hubs.

On the flipside, consider a model where the number of nodes remains stationary, but we add ages weighed according to the number of existing links. Early in the timeline, the degree distribution of the model follows a power-law tail but as we continue with our time evolution the network converges towards a complete graph where all possible
edges have been used.

Therefore, we can be certain that both growth and preferential attachment are needed to generate the expected behavior.
