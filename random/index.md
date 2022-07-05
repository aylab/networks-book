@def title = "Random Networks"

# Random Graphs

## $G(n,m)$

A random graph is a model network in which the values of certain properties are fixed, but the network is in other respects random. One of the simplest examples of a random graph is the one where we fix only the number of nodes $n$ and the number of edges $m$. That is, we take $n$ nodes and place $m$ edges among them at random. More precisely, we choose $m$ distinct pairs of nodes uniformly at random from all possible pairs and connect them with an edge. This model is often referred to by its mathematical name $G(n, m)$.

Strictly, in fact, a random graph model is defined not in terms of a single randomly generated network, but as an ensemble of networks, i.e., a probability distribution over possible networks. When one talks about the properties of random graphs one typically means the average properties of the ensemble. For instance, the diameter of a random graph normally means the diameter $l(G)$ of an individual network $G$ averaged over the probability distribution of $G$ thus:

$$
\langle l \rangle = \sum_G P(G) l(G)
$$

This is a useful definition for several reasons. First, it turns out to lend itself well to analytic calculations; many such average properties of random graphs can be calculated exactly, at least in the limit of large network size. Second, it often reflects exactly the thing we want to get at in making our model network in the first place. Very often we are interested in the typical properties of networks. We might want to know, for instance, what the typical diameter is of a network with a given number of edges. Certainly there are special cases of such networks that have particularly large or small diameters, but these don’t reflect the typical behavior. If it’s typical behavior we are after, then the ensemble average of a property is often a good guide. Third, it can be shown that the distribution of values for many network measures is sharply peaked, becoming concentrated more and more narrowly around the ensemble average as the size of the network becomes large, so that in the large-$n$ limit, essentially all values one is likely to encounter are very close to the mean.

## $G(n,p)$

In $G(n, p)$ we fix not the number but the probability of edges between nodes. Again we have n nodes, but now we place an edge between each distinct pair with independent probability $p$. In this model the number of edges is not fixed. Indeed it is possible that the network could have no edges at all, or it could have edges between every distinct pair of nodes.

Specifically, $G(n, p)$ is the ensemble of simple networks with $n$ nodes in which each network $G$ appears with probability

$$
P(G) = p^{m}(1-p)^{\binom{n}{2}-m}
$$

where $m$ is the number of edges in the network. $G(n,p)$ it is most closely associated with the names of Paul Erdős and Alfréd Rényi, who published a celebrated series of papers about the model in the late 1950s and early 1960s. If you read scientific papers on this subject, you will sometimes find the model referred to as the “Erdős–Rényi model” or the “Erdős–Rényi random graph” in honor of their contribution.

### Mean edges and mean degree

We have said that the number of edges $m$ in the model is not fixed, but we can calculate its mean $\langle m \rangle$ easily enough: the average number of edges between a single pair of nodes is $p$ by definition, and the average number between all $\binom{n}{2}$ pairs is simply $\binom{n}{2}$ times this, or

$$
\langle m \rangle = \binom{n}{2}p
$$

We can use this result to also calculate the mean degree of a node. The mean
degree in a network with exactly $m$ edges is $2m/n$ and the mean degree $\langle k \rangle$ in $G(n,p)$ is the average of this quantity.

$$
\langle k \rangle = \langle \dfrac{2m}{n} \rangle = \dfrac{2}{n} \binom{n}{2} p = (n-1)p
$$

In other words, the average number of edges connected to a node is equal to the expected number $p$ between the node and any other node, multiplied by the number $n − 1$ of other nodes.

### Degree Distribution

A given node in the network is connected with independent probability $p$ to each of the $n − 1$ other nodes. Thus the probability of being connected to a particular $k$ other nodes and not to any of the remainder is $p^{k}(1-p)^{n-1-k}$. There are $\binom{n-1}{k}$ ways to choose $k$ other nodes, and hence the total probability of being connected to exactly $k$ others is

$$
p_k = \binom{n-1}{k}p^{k}(1-p)^{n-1-k}
$$

### Clustering Coefficient

In a random graph the probability that any two nodes are neighbors is exactly the same -- all such probabilities are equal to $p = c/(n-1)$. Hence,

$$
C = \dfrac{c}{n-1}
$$

This is one of several respects in which the random graph differs sharply from most real-world networks. Real-world networks often have quite high clustering coefficients while $C \rightarrow 0$ in the limit $n \rightarrow \infty$ if the network is sparse.

### Giant Component

Consider the Poisson random graph $G(n, p)$ for $p = 0$. In this case there are no edges in the network at all and it is completely disconnected. Each node is an island on its own and the network has n separate components of exactly one node each. The opposite limit of $p = 1$ is one in in which every possible edge in the network is present and the network is an $n$-node clique in the technical sense of the word.

Thus, the largest component in the network has size 1 in the first of these situations $(p = 0)$ and size $n$ in the second $(p = 1)$. A network component whose size grows in proportion to $n$ we call a _giant component_.

This distinction between the two cases is an important one. In many applications of networks it is crucial that there be a component that fills most of the network. It doesn’t necessarily have to fill the entire network, but it should at least fill a large fraction.

So let us consider the largest component of our random graph, which has constant size 1 when $p = 0$ and extensive size $n$ when $p = 1$. An interesting question to ask is how the transition between these two extremes occurs if we gradually increase the value of $p$, starting at $0$ and ending up at $1$. We might guess, for instance, that the size of the largest component also increases gradually, becoming truly extensive only in the limit where $p = 1$. In reality, however, something much more interesting happens. As we will see, the size of the largest component undergoes a sudden change, or phase transition, from constant size to extensive size at one particular value of $p$.

Consider the following process. Let us find a small connected set of nodes somewhere in our network — say a dozen or so. In the limit of large $n$ such a set is bound to exist somewhere in the network, so long as the probability of an edge is non-zero. We will divide the set into its core and its periphery. The periphery is the nodes that have at least one neighbor outside the set—the lighter gray region in the figure. The core is the nodes that only have connections inside the set—the darker gray.

Now imagine enlarging our set by adding to it all those nodes that are immediate neighbors, connected by at least one edge to the set. Now the old periphery is part of the core and there is a new periphery consisting of the nodes just added. How big is this new periphery? We know that each node in the old periphery is connected with independent probability $p$ to every other node. If there are $s$ nodes in our set, then there are $n − s$ nodes outside the set, and the average number of connections a node in the periphery has to outside nodes is

$$
p(n-s) = c \dfrac{n-s}{n-1} \approx c
$$

where the equality becomes exact in the limit $n \rightarrow \infty$. This means that the average number of immediate neighbors of the set — the expected size of the new periphery when we grow the set — is $c$ times the size of the old periphery.

We can repeat this argument as many times as we like, growing the set again and again, and each time the average size of the periphery will increase by a factor of $c$. Thus if $c > 1$ the average size of the periphery will grow exponentially. On the other hand, if $c < 1$ it will shrink exponentially and eventually dwindle to zero. If it grows exponentially, our connected set of nodes will eventually form a component comparable in size to the whole network — a giant component — while if it dwindles the set will only ever have finite size and no giant component will form. So we see that indeed we expect a giant component if (and only if) $c > 1$.

As a side note, a graph cannot have more than one giant component.

### Small Components

We have seen that in a random graph with $c > 1$ there exists a giant component whose size grows in proportion to $n$ and which fills an extensive fraction of the network. It cannot contain additional giant components so it must be made up of components whose size grows slower than $n$. We call these the small components. Since their size grows slower than $n$ there must necessarily be many of them as $n$ becomes large and they can in general have a range of sizes, some larger than others.

The general picture we have is one in which the small components get larger up to $c = 1$, where they diverge and the giant component appears, then smaller again as the giant component grows larger. Although the random graph is certainly not a realistic model of most net- works, this general picture of the component structure of the network turns out to be a good guide to the behavior of networks in the real world. If a network has a low density of edges, then typically it consists only of small components, but if the density becomes high enough then a single large component forms, usually accompanied by some separate small components.

## Problems with the Random Graph

The Poisson random graph is one of the best studied models of networks. In the decades since its first proposal it has given us a tremendous amount of insight into the expected structure of networks of all kinds.

The random graph does, however, have some severe shortcomings as a network model. There are ways in which it is completely unlike the real-world networks we have seen in previous chapters. One clear problem is that it shows essentially no transitivity or clustering. We saw that the clustering coefficient of a random graph is $C = c/(n − 1)$, which tends to zero in the limit of large $n$

The random graph also differs from real-world networks in other ways. For instance, there is no correlation between the degrees of adjacent nodes -- necessarily so, since the edges are placed completely at random. The degrees in real networks, by contrast, are usually correlated.

Many, perhaps most, real-world networks also show grouping of their nodes into “communities" but random graphs have no such structure. And there are many other examples of interesting structure in real networks that is absent from the random graph.

However, perhaps the most significant respect in which the properties of random graphs depart from those of real-world networks is the shape of their degree distribution. Real networks typically have right-skewed degree distributions, with most nodes having low degree but with a small number of high-degree “hubs” in the tail of the distribution. The random graph, on the other hand, has a Poisson degree distribution, which is not right-skewed to any significant extent. It turns out that this difference has a profound effect on all sorts of properties of the network. This makes the Poisson random graph inadequate to explain many of the interesting phenomena we see in networks today, including resilience phenomena, epidemic spreading processes, percolation, and many others.

# Configuration Model

We looked at the classic random graph model in which pairs of nodes are connected at random with uniform probability. Although this model has proved tremendously useful as a source of insight into the structure of networks, it also has a number of serious shortcomings. Chief among these is its degree distribution, which follows the Poisson distribution and is quite different from the right-skewed degree distributions seen in most real-world networks.

Now, we introduce the configuration model, a more sophisticated kind of random graph which can have any degree distribution and yet is still exactly solvable for many properties in the limit of large network size. For many purposes it strikes an ideal balance between realism and simplicity, and is frequently the first model that network scientists turn to when studying a new question or process.

The configuration model is actually a model of a random graph with a given degree sequence, rather than degree distribution. That is, the exact degree of each individual node in the network is specified, rather than merely the probability distribution from which those degrees are chosen. Thus this model is in some ways analogous to the G(n, m) random graph model, which also fixes the number of edges in the network. It is quite simple, however, to modify the configuration model for cases where only the degree distribution is known and not the exact degree sequence. We describe how this is done at the end of this section.

Suppose then that we specify the degree $k_i$ of each node $i = 1 \dots n$ in our network. We can create a random network with these degrees. We give each node $i$ a total of $k_i$ “stubs” of edges, also sometimes called “half-edges.” There are $\sum_i k_i = 2m$ stubs in total, where $m$ is the total number of edges. Now we choose two of the stubs uniformly at random and connect them together to form an edge. Then we choose another pair from the remaining $2m−2$ stubs, connect those, and so on until all the stubs are used up. The end result is a network in which every node has exactly the desired degree. More specifically, the end result is a particular matching of the stubs and the configuration model is defined as an ensemble of matchings in which each matching with the chosen degree sequence appears with the same probability and those with any other degree sequence have probability zero.

There are a couple of catches with the network generation process described here. First, there must be an even number of stubs overall if we want to end up with a network consisting only of nodes and edges, with no dangling stubs left over. This means that the sum $\sum_i k_i$ of the degrees must add up to an even number.

A second issue is that the network might contain self-edges or multiedges, or both. There is nothing in the network generation process that prevents us from creating an edge that connects a node to itself or that connects two nodes that are already connected by another edge. One might imagine that one could avoid this by rejecting the creation of any such edges during the matching process, but it turns out that this is not a good idea. A network so generated is no longer drawn uniformly from the set of possible matchings, which means that properties of the model can no longer be calculated analytically, at least by any means currently known. It can also mean that the network creation process breaks down completely. In practice, therefore, it makes more sense to allow the creation of both multiedges and self-edges in our networks and the standard configuration model does so. However, the density of self-edges and multiedges in the configuration model tends to zero as the network becomes large, which means that their effect on our calculations will typically be negligible so long as we work with reasonably large networks.

We are sometimes interested in the case where it is the degree distribution of the network that is specified rather than the degree sequence. That is, we specify the probability distribution $p_k$. We can define an obvious extension of the configuration model to this case: we draw a degree sequence from the specified distribution and then generate a network with that degree sequence using the technique described above. More precisely, we define an ensemble in which each degree sequence $\{k_i\}$ appears with probability $\Pi_i p_{k_i}$ and the probability of a particular matching of stubs is equal to the probability of generating the corresponding degree sequence times the probability of the matching within the standard configuration model.

One small catch with this model is that we must make sure that the degrees $k_i$ that we generate add to an even number. This is not a big problem however. If we find that we have generated degrees that add to an odd number, we just throw them away and generate another set.

Two important special cases of the model with specified degree distribution are the cases with Poisson and power-law distributions. If we choose a Poisson distribution of node degrees and then generate the corresponding configuration model network, we recover—very nearly—the standard random graph $G(n, p)$. The two are not quite the same since the configuration model can, as we have said, contain multiedges and self-edges, while $G(n, p)$, as normally defined, cannot. Since the density of multiedges and self-edges is small, however, the difference can often be ignored and, in particular, most properties of the configuration model and the Poisson random graph are the same in the limit of large $n$. Although Poisson degree distributions are rare in real-world networks, the Poisson case can serve as a useful check on our calculations when working with the configuration model. A power-law degree distribution provides a more interesting special case.

## Properties of the Configuration Model

### Clustering Coefficient

The clustering coefficient for the configuration model is

$$
C = \dfrac{1}{n} \dfrac{\left[ \langle k^2 \rangle - \langle k \rangle \right]^2}{\langle k \rangle^3}
$$

Like the clustering coefficient of the Poisson random graph this
expression goes as $n^{−1}$ and so vanishes in the limit of large system size, as long as the moments $\langle k \rangle$ and $\langle k^2 \rangle$ of the degree distribution are fixed. Hence, like the Poisson random graph, the configuration model appears to be an unpromising model for real-world networks with high clustering. However, it contains the second moment $\langle k^2 \rangle$ in its numerator which can become large, for instance in networks with power-law degree distributions. This can result in surprisingly large values of $C$.

### Locally Tree-Like Networks

Another important property of the configuration model is that the networks it generates are locally tree-like, meaning that any local neighborhood in such a network takes the form of a tree.
