@def title = "Evolving Networks"

# Evolving Networks

We have explored the first mover's advantage in the Barabasi-Albert model. Consequently, a node that appears later in the time evolution
of a network is unlikely to become the biggest hub in the network. However, this is not reflective of reality -- in many cases, newcomers
enter and disrupt the network and become the talk of the town. This section will explore some models that take this magnetism into account.

## Bianconi-Barabasi

A node can have a _fitness_, denoted by $\eta$, associated with it. This fitness accounts for a node's ability to overcome its competitors.
To incorporate fitness into the Barabasi-Albert model, we assume that preferential attachment is influenced by both the node's degree and its fitness.
Firstly, whenever we add a new node to the network we also draw a random number from a fitness distribution $p(\eta)$ and assign it as the fitness of the inserted
node. This fitness does not change throughout the time evolution of the network. Secondly, the probability that a new node connects to node $i$ is proportional
to the product of its degree and its fitness. Hence, for a node $i$ it is given by

$$
\Pi_i = \dfrac{\eta_i k_i}{\sum_{j} \eta_j k_j}
$$

This model is known as the Bianconi-Barabasi model. In this model, if two nodes have the same degree then the one with the higher fitness is assigned a greater
probability of linkage. Moreover, the degree growth rate is proportional to the fitness of an individual node -- hence node's with a higher fitness will eventually overtake nodes with lower fitness. Similarly, the degree distribution is also a function of the fitness. For example, when the fitness of all the nodes are equal the Bianconi-Barabasi model reduces to the Barabasi-Albert model; when the fitness is drawn from a $\mathcal{U}(0,1)$ distribution it follows a power law with $\gamma = 2.255$.

The Bianconi-Barabasi model incorporates the fact that different nodes can acquire links at different rates as a _fitness_ parameter and allows us to analyze the network using a fitness distribution $p(\eta)$.

## Bose-Einstein Condensation

The shape of the fitness distribution $p(\eta)$ defines the network structure of the system. We will transform a Bianconi-Barabasi network model into a Bose gas
in order to understand this behavior.

We map the fitness of the $i$th node $\eta_i$ to an energy level using the formula $\varepsilon_i = -\log{\eta_i} / \beta_{t}$. The energy of a node is inversely proportional to its fitness. For every link from node $i$ to node $j$, we assign a particle that the $\varepsilon_j$ energy level. Whenever a
new node $k$ is added, we add a new energy level $\varepsilon_k$ and assign the $c$ new particles to the appropriate energy levels. This mapping creates
two distinct phases in the evolution of the network: the **scale-free** phase and the **condensation** phase.

The network displays a "fit gets rich" structure for most fitness distributions. At any point in time, the degree distribution of the network follows a power law.
However, the formation of a Bose-Einstein is possible for some fitness distributions. For networks, Bose-Einstein condensation involves the transformation of the fittest node(s) into a super hub. In this transformation, the fittest node(s) grab a finite proportion of the links resulting in the network losing its scale-free properties. Rather than being a "fit gets rich" or "rich gets richer" network it becomes a "winner takes all" network. The network moves into a star-like formation.
