@def title = "Network Robustness"

# Network Robustness

In this chapter we study the phenomenon of percolation, which leads to an elegant theory of the robustness of networked systems to the failure of their components.

## Percolation

Imagine taking a network and removing some fraction of its nodes, along with the edges connected to those nodes. This process is called percolation and it can be used as a model of a variety of real-world phenomena.

One can see immediately that percolation processes can give rise to some interesting behaviors. The vaccination of an individual in a population, for example, not only prevents that individual from becoming infected but also prevents them from infecting others, and so has a “knock-on” effect in which the benefit of vaccinating one individual is felt by more than one. As we will show, this knock-on effect means that in some cases the vaccination of a relatively small fraction of the population can effectively prevent the spread of disease to anyone, an outcome known as herd immunity.

Similar effects crop up in our Internet example, although in that case they are usually undesirable. The removal or failure of a single router on the Internet prevents that router from receiving data, but also prevents data from reaching others via the failed router, forcing traffic to take another path—possibly longer or more congested—or even cutting off some portions of the network altogether. One of the goals of percolation theory on networks is to understand how the knock-on effects of node removal or failure affect the network as a whole.

Sometimes it is not the nodes in the network that fail but the edges. For instance, communication lines on the Internet can fail, disconnecting routers from one another, even though the routers themselves may still be function- ing perfectly. If we need to distinguish between the two types of percolation process we could refer to them as node percolation on the one hand and edge percolation on the other, but in fact they are more commonly called site percolation and bond percolation,

## Uniform Removal of Nodes

There is more than one way in which nodes can be removed from a network. In the simplest case they could be removed purely at random. This is the most commonly studied form of site percolation, and indeed for many people the word “percolation” refers specifically to this process. Alternatives include removing nodes according to their degree in some fashion or removing nodes with high betweenness centrality.

Consider a network in which some fraction of the nodes, selected uniformly at random, are removed. Traditionally the percolation process is parametrized by a quantity φ equal to the probability that a node is present or functioning in the network. In the parlance of percolation theory, one says that the functional nodes are occupied and $\phi$ is called the occupation probability. Thus $\phi = 1$ indicates that all nodes in the network are occupied and $\phi = 2$ indicates that no nodes are occupied.

When $\phi$ is large the nodes tend to be connected together, forming a giant component that fills most of the network. But as $\phi$ is decreased there comes a point where the giant component breaks apart and we are left only with small components. Conversely, if we increase $\phi$ from zero we first form small components, which grow in size and eventually coalesce to form a giant component that fills a large fraction of the network.

The formation or dissolution of a giant component in this fashion is called a _percolation transition_. When the network contains a giant component we say that it percolates and the point at which the percolation transition occurs is called the _percolation threshold_. The percolation transition is similar in many ways to the phase transition in the Poisson random graph at which a giant component forms. In studies of percolation, the “components” that remain after nodes have been removed are in fact usually called _clusters_.

The percolation transition plays a central role in our interpretation of percolation phenomena. In a network like the Internet, for example, there has to be a giant cluster if the network is to perform its intended function as a communications network. If the network has only small clusters then every node has a connection to, at most, a handful of others and is cut off from everyone else. If there is a giant cluster, on the other hand, then the members of that giant cluster, who are a non-zero fraction of all nodes in the network, are connected and can communicate with one another, although the remainder of the network is still cut off. Thus, the presence of a giant cluster is an indicator of a network that is at least partly performing its intended function, while the size of the giant cluster tells us exactly how much of the network is working.

### Configuration Model

#### Percolation Threshold

To gain some understanding of the percolation transition and the giant cluster, let us consider the behavior of the site percolation process on networks generated using the configuration model. Consider a configuration model network with degree distribution $p_k$ and a percolation process on that network in which nodes are present or occupied with occupation probability $\phi$.

The value of $\phi$ at which the percolation transition occurs, called the critical occupation probability and denoted $\phi_c$ is

$$
\phi_c = \dfrac{\langle k \rangle}{\langle k^2 \rangle - \langle k \rangle}
$$

This equation tells us the minimum fraction of nodes that must be present or
occupied in our configuration model network for a giant cluster to exist. If, for example, the network had a Poisson degree distribution, then $\phi_c = 1/c$. Then if we make $c$ large we will have a network that can withstand the loss of many of its nodes. For $c=4$, for example, we would have $\phi_c = 1/4$, meaning that $3/4$ of the nodes would have to fail before the giant cluster is destroyed. A network that can tolerate the loss of a large fraction of its nodes in this way is said to be robust against random failure.

The degree distribution of the Internet, however, is not Poissonian. The Internet’s degree distribution appears roughly to follow a power law with an exponent $\alpha \approx 2.5$. Power laws with exponents in the range $2 < \alpha < 3$, which includes most real-world examples, have a finite mean $\langle k \rangle$, but their second moment $\langle k^2 \rangle$ diverges. In other words, no matter how many nodes we remove from the network there will always be a giant cluster. Scale-free networks are thus highly robust networks that can survive the failure of any number of their nodes.

In practice the second moment of the degree distribution is never actually infinite in any finite network. It can still become very large, however, which can result in non-zero but very small values of $\phi_c$, so that the network is still highly robust. The structure of the real Internet is not the same as that of a configuration model. Nonetheless, it does appear to be quite robust to random removal of its nodes.

Network robustness also plays an important role in the vaccination example mentioned at the start of the chapter. A disease spreading over a contact network between individuals can only reach a significant fraction of the population if there is a giant cluster in the network. If the network contains only small clusters, then an outbreak of the disease will be hemmed in and unable to spread beyond the small cluster in which it starts. Thus one does not have to vaccinate the entire population to prevent disease spread. One need only vaccinate enough of them to bring the network below its percolation threshold and eliminate the giant cluster.

In the vaccination case, network robustness is a
bad thing. The fewer individuals we have to vac-
cinate to destroy the giant cluster the better. Thus
small values of $phi_c$ are now bad and large values
are good. Unfortunately, we usually don’t have
much control over the degree distributions of con-
tact networks, so we may be stuck with a low value
of $\phi_c$ whether we like it or not. In particular, if the
network in question has a power-law degree distribution, then $phi_c$ may
be very small, implying that almost all nodes have
to be vaccinated to wipe out the disease.

#### Giant Cluster Size

The position of the percolation threshold is not the only quantity important in assessing the robustness of a network. The size of the giant cluster also plays a role because it tells us what fraction of the network will be connected and functional. The size of the giant cluster $S$ varies linearly with $\phi - \phi_c$ just above the percolation transition, going to zero continuously as we approach the transition from above.

This result is important because it implies that the giant cluster becomes very small as we approach the percolation transition from above. In other words, the network may be “functional” in the sense of having a giant cluster, but the functional portion of the network is vanishingly small. If the network is a communication network, for example, then a non-zero fraction of all the nodes in the network can communicate with one another so long as there is a giant cluster, but that fraction becomes very small as we approach the percolation threshold, meaning that in practice most nodes are cut off. Thus, one could argue that it is misleading to interpret the percolation threshold as the point where the network stops functioning: in effect most of it has stopped functioning before we reach this point. To fully describe the functional state of the network one should specify not only whether it contains a giant cluster but also what the size of that cluster is.

It is also important to note that the sharp percolation transition is only truly seen in an infinite network. For networks of finite size — which includes all real networks, of course — the transition gets rounded off.

## Non-Uniform Removal

In the preceding sections we considered the percolation process in which nodes were removed from a network uniformly at random. This is the classical form of percolation long studied by physicists and mathematicians. We mentioned the possibility of removing nodes in order of their degrees, starting with the highest degrees and working down. This might be effective, for example, as a vaccination strategy for preventing the spread of disease. Should they become infected, the high-degree nodes in a network clearly present a heightened disease risk to the population at large because of their many neighbors, so perhaps vaccinating them first would be a sensible approach.

Let us consider a generalization of our percolation process in which the occupation probability of a node can now depend on its degree. We define $\phi_k$ to be the probability that a node with degree $k$ is present or occupied in our network. If $\phi_k$ is a constant, independent of $k$, then we recover the uniform scenario of previous sections. Alternatively, if $\phi_k = 1$ for all nodes with degree $k < k_0$ for some constant $k_0$,and $\phi_k = 0$ for all $k \geq k_0$, then we effectively remove from the network all nodes with degree $k_0$ or greater. A host of other choices are also possible, resulting in more complex removal patterns.

Now, consider the size of the giant cluster in a network with an exponential degree distribution. The giant cluster in fact disappears completely when only about 8% of the highest-degree nodes in the network have been removed. By contrast, when we removed nodes uniformly at random we had to remove nearly 70% of the nodes to destroy the giant cluster. Though the difference is startling, however, it is also intuitively reasonable. The high-degree nodes have a lot of connections, all of which are lost if we remove those nodes. These results suggest, for example, that were we able to find the highest degree nodes in a network of disease-causing contacts and vaccinate them, thereby effectively removing them from the network, it would be a much more efficient strategy for disease control than simply vaccinating at random.

A particularly striking example of the effect described here arises in net- works with power-law degree distributions. In these networks, as we have seen, uniform removal of nodes never destroys the giant cluster. In contrast, removal of the highest-degree nodes in these networks has a devastating effect. The giant cluster disappears extraordinarily rapidly as the high-degree nodes are removed. Only a few percent of the nodes need be removed to completely destroy the giant cluster, the exact fraction depending on the exponent of the power law. Scale-free networks are thus paradoxically both robust and fragile. On the one hand, they are remarkably robust to the random failure of their nodes, with the giant cluster persisting no matter how many nodes we remove. On the other hand, scale-free networks are very fragile to attacks targeted specifically at their highest-degree nodes. We need remove only the tiniest fraction of the high-degree hubs in such a network to entirely destroy the giant cluster.

The fragility of scale-free networks to targeted attacks is both bad news and good news. It is bad news for networks such as the Internet that we wish to defend against possible attack: a communication network that can easily be brought down by a malicious adversary targeting just a few of its most crucial nodes may be a disaster waiting to happen. On the other hand, results like these could also be exploited to help eradicate or reduce disease by targeting vaccination efforts at network hubs. It is worth noting, however, that it’s not necessarily easy to find the hubs in a network, so that implementation of a targeted vaccination strategy may be difficult. In most cases one does not know the entire network and so cannot simply pick out the high-degree nodes from a list.

One intriguing way of getting around this problem has been put forward by Cohen et al who suggest that we make use of the structure of the network itself to find the high-degree nodes. In their scheme, which they call “acquaintance immunization,” they propose that one choose members of the population at random and then get each of them to nominate an acquaintance. Then that acquaintance receives a vaccination against the disease under consideration. The selection of individuals in the scheme of Cohen et al. is biased towards those with high degree. The selected individuals are not guaranteed to be the highest-degree nodes in the network, but we are a lot more likely to find the hubs this way than if we just choose nodes at random, and in simulations the acquaintance immunization scheme appears to work quite well.

On the other hand it has some drawbacks too. First, contact networks in the real world are of course not configuration models and it is unclear how accurately the theoretical results describe real situations. Second, real contact networks mostly don’t have power-law degree distributions, instead having somewhat shorter tails than the typical power law, which will reduce the effectiveness of the scheme, or indeed of any scheme based on targeting the highly connected nodes. Another issue is that, in asking people to name their acquaintances, the acquaintance immunization scheme necessarily probes the network of who is acquainted with whom, which is in general not the same as the network of disease transmission. We can do our best to make the networks similar, asking participants to name only acquaintances they have seen recently and in person, rather than those they might not have seen for a while or might only have to talked to on the phone. Still, the difference between the two networks means that the scheme might end up focusing vaccination efforts on some of the wrong people. Finally, one cannot guarantee that the acquaintances identified by the process can be located, or that they will consent to being vaccinated.
