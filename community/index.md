@def title = "Network Communities"

# Network Communities

Our task now is to apply what we have learned to gain deeper insight into the function of networked systems.

## Dividing networks into groups

The ability to find groups or clusters in a network can be a useful tool for revealing structure and organization within networks at a scale larger than that of a single node or a few nodes. For example, in a network of friendships between US high school students the network splits into two clear groups or communities which are primarily dictated by students’ ethnicity, and this structure can give us clues about the nature of the social interactions within the population represented by the network.

The ability to find groups also has another practical application: it allows us to take a large network and break it apart into smaller subsets that can be studied separately. Breaking such networks into their component clusters is a useful technique for reducing them to a manageable size -- for example, in network visualization.

## Community Detection

The problem of finding groups of nodes in networks is called community detection.

### Modularity Maximization

Loosely speaking, the goal of community detection is to find the natural divisions of a network into groups of nodes such that there are many edges within groups and few edges between them.

We approach the task of community detection as an optimization problem. Consider a simple undirected, unweighted network. To every possible division of this network into communities we assign a score which is high if that division is “good,” in the above sense of having many edges within communities and few edges between them, and low if it is “bad.”

Let us initially consider the simplest possible community detection problem, the problem of dividing a given network into just two groups or communities. That is, we will for the moment assume that we know there to be exactly two groups in the network and our only task is to determine which nodes belong to which group. For a node $i$, $s_i = +1$ if the node belongs to group 1 and $s_i = -1$ if the node belongs to group 2. The modularity $Q$ can be expressed as

$$
Q = \dfrac{1}{4}\sum_{ij}B_{ij}s_{i}s_{j}
$$

where $B_{ij} = A_{ij} - \dfrac{k_i k_j}{2m}$. Therefore, the modularity maximization problem can be rephrased as follows: given a particular set of values $B_{ij}$ (i.e., a particular network), find the quantities $s_i$ (i.e., the division of the network) that maximize $Q$.

This problem falls within the generic class of discrete optimization problems, problems where we are maximizing the value of a known function of a set of discrete-valued variables. There are a number of general computational methods for finding solutions to such problems, even in cases such as this where the set of possible values of the variables is too large to search through exhaustively. These methods typically only give approximate answers, meaning they can find a solution with a large value of the modularity, but not necessarily the largest overall.

However, if there are solutions that have modularity almost as good as the overall maximum but which correspond to very different divisions of the network, in which the assignment of nodes to groups is completely unlike the optimal division, then modularity maximization may fail. It may find a division with a high modularity score, but that division will not be a good guide to the true optimal division.

Given a graph $G$, the following code will create a mapping between the communities and the list of nodes in that community. For example, `c[0]` contains the nodes in the first (zeroth) community, `c[1]` contains the nodes in the second community and so on.

```python
from networkx.algorithms.community import greedy_modularity_communities
c = greedy_modularity_communities(G)
```

If we want the modularity score of a particular partition of a graph $G$, we can use the following function where $G$ is the original graph and ` [{0, 1, 2}, {3, 4, 5}]`
represents a division of the graph into two communities.

```python
import networkx.algorithms.community as nx_comm
nx_comm.modularity(G, [{0, 1, 2}, {3, 4, 5}])
```

#### Simple Modularity Maximization Algorithm

The algorithm starts by dividing the network into two equally sized groups at random. Then it considers each node in the network in turn and calculates how much the modularity would change if that node were moved to the other group. In terms of the previous equation, this is equivalent to momentarily flipping the sign of each of the variables $s_i$ in turn and calculating the effect on $Q$.
The algorithm then chooses from among the nodes the one that most increases, or least decreases, the modularity and it moves this node. Then it repeats the process, but with the important constraint that a node once moved cannot be moved again, at least on this round of the algorithm. When all nodes have been moved exactly once the current round ends.

We then go back over the divisions through which the network passed during the round and select the one with the highest modularity. We use this division as the starting point for another round of the same process, moving nodes one by one as before. We keep repeating this whole procedure, through as many rounds as are needed until the modularity no longer improves, then we stop. The division with highest modularity encountered on the last round is our best estimate of the community structure in the network.

Overall, this algorithm is a reasonable one, in terms of speed and quality of results, for applications to smaller networks. Moreover, it is simple to understand and implement. But it is not competitive in terms of speed with the fastest current algorithms, which can have time complexity as good as $\mathcal{O}(n \log n)$.

## Information Theoretic Methods

A completely different approach to community detection is to make use of concepts from information theory, the branch of computer science that deals with measures of information content, for instance in text or numbers. The idea behind these methods is that a good division of the nodes of a network into groups or communities tells us a lot about the structure of the network itself. We will use the algorithm known as InfoMap.

Consider a random walk on an undirected network. The sequence of nodes visited by the walk certainly gives us some information about the struc- ture of the network. At the simplest level it tells us a subset of the edges in the network, since any two nodes that appear consecutively in the sequence must be joined by an edge. However, a random walk also contains more subtle information, information about community structure. Since there are many edges inside communities but few edges between them, a random walk on a network with strong community structure will tend to linger inside communities: when there are few between-group edges along which to escape to another community, the walk will take a long time to find those edges.

In order to quantify the information content of a random walk, turn the walk into a bit-string, a unique string of zeros and ones that exactly describes the walk, as shown in Fig. 14.6. We consider a possible division of the network into communities and we give two labels to each community, an “entry label” and an “exit label,” which take the form of short strings of bits. Every time the random walk enters a new community we record the corresponding entry label. When we leave that community again we record the exit label. Movement of the random walk within a community is recorded in a similar way, by assigning binary labels to the nodes and then recording the labels of the nodes the walk passes through. The complete set of labels, entry and exit labels and node labels, in order, forms the bit-string representation of the random walk.

First, we generate a random walk long enough to visit all parts of the network. Then, for each possible division of the network into groups, we find the set of group and node labels that gives the shortest bit-string representation of that random walk. Then we look through all divisions to find the one that gives the shortest bit- string overall, and this is deemed to be the best community structure for the network.

The InfoMap method is in some ways rather similar to modularity maximization: it defines a quality function, in this case the entropy L, which characterizes how good a particular community division is, then optimizes it over possible divisions to find the best one.

InfoMap is not implemented in NetworkX, but can be used from another library known as `cdlib`.

```python
from cdlib import algorithms
coms = algorithms.infomap(G)
```

## Statistical Inference

Some of the most powerful and flexible methods for community detection are those based on statistical inference. These methods work by fitting a network model — typically some kind of random graph — to observed network data. The parameters of the fit can tell us about features of the network, including community structure, in much the same way that the fit of a straight line through a set of data points can tell us about their slope.

Given a network model, meaning any process that can generate a network, we can fit that model to data—i.e., to a particular network structure—by finding the values of the model parameters that give the highest likelihood. In effect, we are saying, “If this network was generated by this model, what is our best guess at the values of the model parameters that were used?”

## Other Methods

### Betweenness

A completely different approach to the problem is to look for the edges in the network that lie between communities. If we can find and remove these edges, we will be left with just the isolated communities. We can define an edge betweenness that counts the number of shortest paths that run along edges, and edges that lie between communities can be expected to have high values of this edge betweenness.

Our algorithm for detecting communities is then as follows. We calculate the betweenness scores of all edges in our network, then find the edge with the highest score and remove it. In removing this edge we will change the betweenness scores of some other edges, because any shortest paths that previously traversed the removed edge will now have to be rerouted another way. So we recalculate the betweenness scores following the removal, then we search again for the edge with the highest score and remove it, and so forth.

As we remove one edge after another, an initially connected network will eventually split into two pieces, then into three, and so on. The progress of the algorithm can be represented using a tree or dendrogram. This algorithm is thus somewhat different from previous ones, in that it doesn’t give a single decomposition of a network into communities, but a set of different possibilities, ranging from coarse divisions into just a few large communities (at the top of the dendrogram) to fine divisions into many small communities (at the bottom). It is up to the user to decide which of the many divisions represented is most useful for their purposes.

NetworkX implements the `Girvan-Newman` algorithm for betweenness-based edge removal. If we have a graph $G$, then the following code returns the first split in the dendogram

```python
comp = girvan_newman(G)
tuple(sorted(c) for c in next(comp))
```

For further details see the [documentation](https://networkx.org/documentation/stable/reference/algorithms/generated/networkx.algorithms.community.centrality.girvan_newman.html).

### Hierarchical Clustering

Hierarchical clustering is not so much a single algorithm as a class of algorithms, with many variations and alternatives. Hierarchical clustering is an agglomerative technique in which we start with the individual nodes of a network and join them together to form groups. The basic idea is to define a measure of similarity or connection strength between nodes, based on the network structure, and then join together the most similar nodes to form groups.

That there are many choices of similarity measures is both a strength and a weakness of the hierarchical clustering method. It gives the method flexibility and allows it to be tailored to specific problems, but it also means the method gives different answers depending on the choices we make, and in many cases there is no way to know in advance if one choice is more correct or will yield more useful information than another. Most often the choice of a similarity measure is determined more by experience or experiment than by argument from first principles.

Once a similarity measure is chosen, we calculate it for all pairs of nodes in the network, then group together those nodes having the highest similarities. The basic strategy for doing this is to start by joining together the pairs of nodes with the highest similarities, forming groups of size two. Then we further join together the groups that are most similar to form larger groups, and so on. This, however, brings up another problem: in order to join together the most similar groups we need a measure of group similarity, but what we have is a measure of node similarity. The usual solution to this problem is to combine the node similarities somehow to create similarities for the groups. There are three common ways of doing this, called single-, complete-, and average-linkage clustering.

In the single-linkage clustering method, the similarity between the two groups is defined to be the similarity of the most similar of these n1n2 pairs of nodes. At the other extreme, complete-linkage clustering defines the similarity be- tween two groups to be the similarity of the least similar pair of nodes. In between these two extremes lies average-linkage clustering, in which the similarity of the two groups is defined to be the mean similarity among all the pairs of nodes. Average-linkage clustering is probably the most satisfactory choice of the three, being a moderate one. It is, however, relatively rarely used, for reasons that are not entirely clear.

## Tests on Real World Networks

Tests of community detection on real-world networks rely on being able to find example networks where we know—or believe we know—the true division into communities, sometimes called the ground truth division. In most cases, the ground truth is established through a combination of insider knowledge of the network in question and consensus results from the application of many different community detection methods to the same network.

Classic examples of networks whose community structure have been extensively studied include the Karate club network, the Dolphin social network and the political blog network of Adamic and Glance. Some of these are included in NetworkX.

```python
import networkx as nx
G = nx.karate_club_graph()
```

### Artificial Test Networks

While real-world networks provide a test of community detection performance in life-like situations, they are limited in that there are a relatively small number of accepted test networks, their ground-truth community structure is not always 100% certain, and their structure cannot be varied to probe algorithm behavior. We cannot, for instance, make their communities larger or smaller, or change their number.

A solution to these problems is to use artificial test networks, sometimes called synthetic networks, which contain a specific level or type of community structure planted within them. We can then test to see whether our community detection algorithms can detect this planted structure. While artificial networks are generally less realistic than their real-world counterparts, their structure can be varied in any way we please, and we can generate as many of them as we want, which gives us considerable flexibility to quantify the performance of our algorithms. In practice, algorithms are often tested on both real and synthetic networks, to make the most of the advantages each has to offer.
