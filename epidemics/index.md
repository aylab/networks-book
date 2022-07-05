@def title = "Epidemics on Networks"

# Epidemics on Networks

Diseases spread over networks of contacts between individuals: airborne diseases like influenza and tuberculosis are communicated when two people breathe the air in the same room; other diseases and some parasites are communicated when people touch; sexually transmitted diseases such as HIV are communicated when people have sex. The patterns of such contacts can be represented as networks and a good deal of effort has been devoted to empirical studies of these networks’ structure.

There are also other network processes that can be viewed as generalized “spreading” processes akin to the spread of disease. The spread of news, rumors, or gossip through a population, for instance, has features in common with disease spread.

Another variant of contagious behavior is cascading failure. Consider for instance the electrical power grid. Transmission lines regularly fail in the power grid, sometimes because of overload: if too much power is sent along a particular edge in the network then it can break down. When an edge fails, the power it previously carried must be rerouted some other way around the network in order to reach the consumers who need it, and in doing this we increase the load on other edges. This in turn can push those edges over the limit and cause them to fail too. The end result is a cascading failure in which a problem or fault in one initial spot in the network quickly spreads to a whole region. Cascading failures of this kind are the primary cause of large power outages and blackouts.

In this chapter we describe a range of methods and models for understanding and predicting the behavior of contagion processes and their generalizations on networks of various kinds.

## Models of Infection Spread

In theory if we want to understand fully how diseases spread through populations we need to take all of this biology into account, but in practice that is usually a dauntingly large job and it is rarely, if ever, attempted.

### SI Model

In the typical mathematical representation of an epidemic the within-host dynamics of the disease is reduced to changes between a few basic disease states. Such states are sometimes called compartments, and mathematical models incorporating them are called compartmental models. In the simplest case there are just two states, _susceptible_ and _infected_. An individual in the susceptible state is someone who does not have the disease yet but could catch it if they come into contact with someone who does. An individual in the infected state is someone who has the disease and can, potentially, pass it on if they come into contact with a susceptible individual.

The traditional approach avoids discussing contact networks at all by making use of a fully mixed or mass-action approximation, in which it is assumed that every individual has an equal chance, per unit time, of coming into contact with every other. In the real world, people have contact with only a small fraction of the population, and that fraction is not chosen at random, which is precisely why networks play an important role in the spread of disease and many other things.

Consider a disease spreading through a population of individuals. Let us define $S$ and $X$ to be the average or expected numbers of susceptible and infected individuals The number of infected individuals goes up when susceptible individuals contract the disease from infected ones. Suppose that people meet and make contact sufficient to result in the transmission of disease entirely at random with a per-individual rate $\beta$, meaning that each individual has, on average, $\beta$ contacts with randomly chosen others per unit time.

The disease is transmitted only when an infected person has contact with a susceptible one. If the total population consists of $n$ people, then the average probability that a person you meet at random is susceptible is $S/n$, and hence an infected person has contact with an average of $\beta S/n$ susceptible people per unit time. Since there are on average $X$ infected individuals in total this means the overall average rate of new infections will be $\beta SX/n$ and we can write a differential equation for the rate of change of $X$ thus:

$$
\dfrac{dX}{dt} = \beta \dfrac{SX}{n}
$$

At the same time the number of susceptible individuals goes down at the same rate:

$$
\dfrac{dS}{dt} = -\beta \dfrac{SX}{n}
$$

This simple mathematical model for the spread of a disease is called the fully mixed susceptible–infected model, or SI model for short. Without delving into the mathematics, the number of infected people at a certain time follows the logistic equation:

$$
x(t) = \dfrac{x_0 e^{\beta t}}{1 - x_0 + x_0e^{\beta t}}
$$

Generically, this produces an S-shaped “logistic growth curve” for the fraction of infected individuals. The curve increases exponentially at short times, corresponding to an initial phase of the disease in which most of the population is susceptible, and then saturates as the number of susceptibles dwindles and the disease has a harder and harder time finding new victims.

### SIR Model

The SI model is the simplest possible model of infection. There are many ways in which it can be extended to make it more realistic or more appropriate as a model of a specific disease. One common extension deals with recovery from disease.

In the SI model individuals, once infected, are infected (and infectious) forever. For many real diseases, however, people recover from infection after a certain amount of time. People often retain their immunity to the disease after such a recovery so that they cannot catch it again. To represent this behavior in our model we need a new third disease state, usually denoted R for recovered. The corresponding three-state model is called the susceptible–infected–recovered or SIR model.

With some diseases people do not recover but instead die. Although this is the complete opposite of recovery in human terms, it is essentially the same thing in epidemiological terms: it makes little difference to the disease whether a person is immune or dead—either way they are effectively removed from the pool of potential hosts for the disease. Both recovery and death can be represented by the R state in our model. For this reason some people say that the R stands for removed rather than recovered, so as to encompass both possibilities, and they refer to the corresponding model as the susceptible–infected–removed model.

The dynamics of the fully mixed SIR model has two stages. In the first stage, susceptible individuals become infected when they have contact with infected individuals. Contacts between individuals are assumed to happen at an average rate $\beta$ per person as before. In the second stage, infected individuals recover (or die) at some constant average rate $\gamma$.

Given the value of $\gamma$ we can calculate the length of time that an infected individual is likely to remain infected before they recover which usually follows an exponential distribution. Thus, an infected person is most likely to recover immediately after becoming infected, but might in theory remain in the infected state for quite a long time. Neither of these behaviors is very realistic for most real diseases. With real diseases, most victims remain infected for about the same length of time, such as a week, say, or a month.

Given these assumptions, the fractions $s$, $x$, and $r$ of individuals in the three states are governed by the equations:

$$
\dfrac{ds}{dt} = -\beta s x \\
\dfrac{dx}{dt} = -\beta s x - \gamma x\\
\dfrac{dr}{dt} = -\gamma x
$$

and in addition the three variables must satisfy $s + x + r = 1$.

If we numerically simulate the time evolution of the SIR model we will notice that the number of susceptibles does not go to zero; the curve for $s(t)$ ends a little above the axis. This is because when $x \rightarrow 0$ there are no infected individuals left to infect the remaining susceptibles. Any individuals who survive to late enough times without being infected will probably never get the disease at all. They are the lucky ones who made it through the outbreak and out the other side. Similarly the fraction of recovered individuals does not quite reach one as $t \rightarrow \infty$.

The asymptotic value of r has an important practical interpretation: it is the total number of individuals who ever catch the disease during the entire course of the epidemic—the total size of the outbreak.

The initial conditions for the model can be chosen in a variety of ways, but the most common is to assume that the disease starts with either a single infected individual or a small number $c$ of individuals and everyone else in the susceptible state. As the size of the population $n \rightarrow \infty$ the value of $r$ becomes $1 - e^{-\beta r \gamma}$. Interestingly, this is the same as the equation for the size $S$ of the giant component of a Poisson random graph. This allows us to say several useful things.

First, we know what the size of the epidemic must look like as a function of the parameters $\beta$ and $\gamma$. Second, it tells us that the size of the epidemic goes continuously to zero as $\beta / \gamma$ approaches one from above. And for $\beta / \gamma < 1$, or equivalently $\beta \leq \gamma$, there is no epidemic at all. The simple explanation for this result is that if $\beta \leq \gamma$ then infected individuals recover faster than susceptible individuals become infected, so the disease cannot get a toehold in the population. The number of infected individuals, which starts small, goes down, not up, and the disease dies out instead of spreading.
The transition between the regimes where there is and is not an epidemic happens at the point $\beta = \gamma$, which is called the epidemic threshold. Note that there was no epidemic threshold in the simpler SI model

#### Basic Reproduction Number

An important quantity in the study of epidemics is the basic reproduction number, denoted $R_0$, which is defined as follows. Consider the spread of a disease when it is just starting out, when there are only a few cases of the disease and the rest of the population is susceptible — what is called a naive population in epidemiology — and consider a susceptible person who catches the disease in this early stage of the outbreak. The basic reproduction number is defined to be the average number of additional people that such a person passes the disease on to before they recover.

If we had $R_0 = 2$, then each person catching the disease would pass it on to two others on average so that the number of new cases of the disease would double at each round, growing exponentially. Conversely, if $R_0 = 1/2$ the disease would die out exponentially. The point $R_0 = 1$ separates the regimes of growing and shrinking behavior and thus marks the epidemic threshold between cases where the disease multiplies and where it dies out.

### SIS Model

A different extension of the SI model is one that allows for reinfection, i.e., for diseases that don’t confer immunity on their victims after recovery, or confer only limited immunity, so that individuals can be infected more than once. The simplest such model is the SIS model, in which there are just two states, susceptible and infected, and infected individuals move back into the susceptible state upon recovery.

In the SIS model, the number of infected individuals can be modeled as

$$
x(t) = x_0\dfrac{(\beta - \gamma)e^{(\beta - \gamma)t}}{\beta - \gamma + \beta x_0 e^{(\beta - \gamma)t}}
$$

If $\beta > \gamma$ this produces a logistic growth curve similar to that of the basic SI model but differing in one important respect: we never have the whole population infected with the disease. In the limit of long time the system finds a stable state where the rates at which individuals are infected and recover from infection are exactly equal and a steady fraction of the population—but not all of them—is always infected with the disease. In the language of epidemiology the steady state is called an _endemic disease state_.

Note that the fraction infected in the endemic state goes to zero as $\beta$ approaches $\gamma$, and if $\beta < \gamma$ then the disease will die out exponentially. Thus, as in the SIR model, the point $\beta = \gamma$ marks an epidemic threshold between a state in which the disease spreads and one in which it dies out. As before, we can calculate a basic reproduction number $R_0$, which again takes the value $R_0 = \beta /\gamma$.

### SIRS Model

Another epidemic model, which we touch upon only briefly, is the SIRS model, another model incorporating reinfection. In this model individuals recover from infection and gain immunity as in the SIR model, but that immunity is only temporary. After a certain period of time individuals lose it and become susceptible again. We introduce a new parameter $\delta$ to represent the average rate at which individuals lose immunity. The SIRS model cannot be solved analytically, although it can be treated using linear stability analysis and other tricks from the non-linear dynamics toolbox.

### Other Models

One possibility is an initial immune state such that individuals start off immune to disease, lose that immunity and become susceptible, and from there move through the standard stages of infection. Models of this type, such as the MSIR model, are sometimes used to represent the maternally derived immunity that newborn babies possess.

There are also models in which the population can grow as a result of births or immigration, models that distinguish between people who recover fully from disease and those who recover but remain carriers who can pass the disease to others, and many other variants.

## Complex contagion and the spread of information

As mentioned at the start of this chapter, the general ideas of disease spreading can be applied more broadly to shed light also on the spread of other things, such as information, news, rumors, or fashions. In some cases, the exact same models used for biological infections can be applied directly to other types of spreading process, but there are also some interesting variant models that capture unique features of the way information and other “social contagions” spread.

A classic example of a model of information spread is the voter model, originally proposed as a simple representation of the effects of peer pressure on voting behavior. In this model it is assumed that a population of voters is asked to decide among some number of candidates for an election and at any particular moment every individual has a preferred candidate. One can think of these preferred candidates as being like the disease states in our earlier models. Initial preferences are typically assigned at random but individuals’ opinions can subsequently change following a simple algorithm: pairs of individuals meet at random and one of them adopts the preferred candidate of the other. Thus, in this model people’s opinions are affected only by other individuals. In real life many other factors play a role, such as news media, political campaigning, inherent preferences, and so forth, but the model ignores these.

The voter model is superficially similar to a kind of SI model: pairs of people meet and one of them “infects” the other with their opinion. Consider the simplest case where voters are choosing between just two candidates. No matter how many people currently prefer candidate 1, the probabilities of their number increasing or decreasing are identical: there is some probability that people with opposite opinions will meet and when they do one of them infects the other, thereby either increasing or decreasing the ranks of candidate 1’s supporters by one, with equal probability. Thus the model has no inherent preference for either candidate, even if one of them is currently more popular than the other, and the model’s dynamics are therefore best thought of as a kind of random walk or random fluctuation that stops only when the model reaches consensus, meaning that everyone holds the same opinion and no further changes of opinion are possible.

If one puts it on a network, however, so that individuals can only be “infected” by their neighbors and not by anyone, then it becomes more interesting. The time to reach consensus depends strongly on the structure of the network. On networks with community structure, for instance, isolated groups of nodes can form with opinions contrary to the rest of the network, preventing the system from reaching consensus for long periods of time.

Another class of information spreading processes of particular interest are the complex contagions, those in which infection is communicated not by just a single contact between individuals but by multiple contacts or a particular pattern of contacts. Imagine, for instance, that news of a particularly surprising or extraordinary event is spreading through a community. When you first hear the news, from a friend or co-worker perhaps, it seems incredible and you don’t really believe it, or at least not enough to feel confident passing it along to anyone else. But then you hear it a second time from a different person and you realize that it’s actually true, and at that point you start telling other people. In other words, you need to be infected twice before you become infectious

## Epidemic Models on Networks

The traditional approach to epidemic modeling assumes “full mixing” of the population, meaning that any individual can have contact with and potentially transmit disease to any other. In the real world, however, this is not a realistic assumption. The pattern of people’s regular contacts can be represented as a network and the structure of that network can have a strong effect on the way a disease spreads.

Let us define the transmission rate or infection rate for our network disease process to be the probability per unit time that infection will be transmitted between two individuals, one susceptible and one infected, who are connected by an edge in the appropriate network. To put that another way, it is the rate at which contact sufficient to spread the disease occurs between any two individuals connected by an edge. The two parameters are not exactly equivalent since $\beta$ in the fully mixed case is the rate of contacts between an infected individual and all others in the population, whereas in the network case it is the rate of contact with just one other.

The transmission rate is partly a property of the disease being considered: some diseases are transmitted more easily than others and so have higher transmission rates. But transmission rate is also a property of the social and behavioral parameters of the population. Some communities may favor more close physical contact between acquaintances than others. Such differences could produce a significant difference in transmission rates.

## Outbreak Sizes and Percolation

### Outbreaks in the SI Model

Given a value for the transmission rate one can define models for the spread of disease over a network. Consider the SI model, for instance. There is one important quantity that is straightforward to calculate, namely the total size of the disease outbreak. It is clear that in the limit of long time in this model every individual who can be infected by the disease is infected: since infected individuals remain infected forever, their susceptible neighbors will always, in the end, also become infected, no matter how small the transmission rate, so long as it is not zero. The only condition for a node to be infected therefore is that there must be at least one path to that node through the network from one of the initially infected individuals. This means that in the limit of long time the disease will spread from every initial carrier to infect all nodes in the component to which the carrier belongs.

Most networks have one large component that contains a significant fraction of all nodes in the network, plus, typically, a selection of smaller components. If we start with a single infected individual, and if that individual turns out to belong to the large component, then the disease will infect the large component and we will have a large outbreak. If the individual belongs to one of the small components, however, the disease will only infect the few members of that small component and then die out. If the initial carrier of the disease is chosen uniformly at random from the network, then the probability that it will fall in the large component and we get a large outbreak is simply equal to the fraction $S$ of the network occupied by the large component, and the size of the outbreak as a fraction of the network will also be $S$. Conversely, with probability $1 − S$ the initial carrier will fall in one of the small components and the outbreak will be small, with size given by the size of the appropriate small component.

This constitutes a new type of behavior not seen in fully mixed models. In fully mixed models the possible behaviors are also either a run-away epidemic that affects a large fraction of the population, or an outbreak that affects only a few then dies out. But the choice between these outcomes was uniquely determined by the choice of model and the model parameters. In our network model, however, the behavior depends on the network structure and on the position in the network of the first infected individual. Thus there is a new stochastic element in the process: with identical model parameters and an identical network the disease sometimes takes off and sometimes dies out.

### Outbreaks in the SIR Model

The situation becomes more interesting still when we look at the SIR model. In the SIR model individuals remain infectious for only a finite amount of time and then they recover, so it is in general no longer true that the susceptible neighbor of an infected individual will always get infected in the end. If they are lucky such neighbors may never catch the disease. The probability of this happening is $\phi$. We will refer to this quantity as the transmission probability.

For simplicity, let us suppose that every infected individual remains infectious for the same length of time. With this assumption, the transmission probability φ is a constant across the network. Every susceptible individual has equal probability of catching the disease from their infected neighbor. Let us take our network and “fill in” or “occupy” each edge with probability $\phi$, or not with probability $1-\phi$. This is exactly the bond percolation process where a fraction $\phi$ of edges are occupied uniformly at random. The occupied edges represent those along which disease will be transmitted if it reaches either of the nodes at the ends of the edge. That is, the occupied edges represent contacts sufficient to spread the disease, but not necessarily actual disease transmission: if the disease doesn’t reach either end of an edge, then it will not be transmitted along that edge.

With this in mind consider now the spread of a disease that starts at a randomly chosen node. We can immediately see that the set of nodes to which the disease will ultimately spread is precisely the set reachable from the initial node via paths that go along occupied edges — the disease simply passes from one node to another by traversing occupied edges until all reachable nodes have been infected. The end result is that the disease infects all members of the bond percolation cluster to which the initial carrier belongs.

It is important to appreciate that this process does not give us any information about the temporal evolution of the disease outbreak. Individual infection events are stochastic and a calculation of the curve of infections as a function of time requires a more complicated analysis that takes their randomness into account. However, if we want to know only about long-time behavior, about the overall total number of individuals infected by the disease, then all we need do is count the nodes in the appropriate percolation cluster.

For low edge occupation probability here are just a few occupied bonds which form small clusters disconnected from one another. But as $\phi$ increases there comes a point, the percolation transition, where the disconnected clusters grow large enough to join together and form a giant cluster, although usually there are also other small clusters that are not joined to the giant cluster.

Translating these ideas into the language of epidemiology, we see that for small values of $\phi$ the cluster to which the initial carrier of a disease belongs must be small, since all clusters are small. Thus, in this regime we will have only a small disease outbreak and most members of the population will be uninfected. Once we reach the percolation transition, however, and a giant cluster forms, then a large outbreak of the disease — an epidemic — becomes possible, although not guaranteed. If the giant cluster of the percolation process occupies a fraction $S$ of the entire network, then our randomly chosen initial carrier will fall within it with probability $S$, and if it does then the disease will spread to infect the whole giant cluster, creating an epidemic reaching a fraction of the population also equal to $S$. With probability $1 − S$, on the other hand, the initial carrier will fall in one of the small clusters and we will have only a small outbreak of the disease. As $\phi$ increases, $S$ also increases and hence both the probability and the size of an epidemic increase with $\phi$.

A disease can die out because, just by chance, its first victims happen not to pass the disease on to others. Our theory tells us that the probability of this happening is $1 − S$, where $S$ is the size of the giant cluster for bond percolation on the network, which is also the size of the epidemic if it does happen. The value of $1 − S$ is usually small when we are well above the epidemic threshold, but can be quite large if we are only a little above the threshold, meaning that the probability of the disease dying out can be large in this regime.

It is also important to bear in mind that percolation is a stochastic process. Two outbreaks happening under the same conditions on the same network would not necessarily spread along the same edges and the shapes of the percolation clusters would not necessarily be the same.

### Complex Contagion

The spread of information over networks can be modeled as a contagion-like process, and leads us to consider so-called complex contagions, in which a node only becomes infectious after being infected by two or more others: being infected by only one other is not enough.

Consider an SIR-style model of complex contagion in which infectious individuals spread the infection to their neighbors with transmission probability $\phi$, but a node only becomes infectious itself after it has received the infection from $q$ others. A crucial point to notice about this process is that we can no longer start the outbreak at just a single node. Since the infection only spreads once a node receives it from two or more others, it will never spread at all if it starts at only one node.

Indeed, in a large network it is not even adequate to start the disease with a fixed number of initial carriers, since the chances of two or more of them being adjacent to the same node vanishes as the size of the network becomes large. In order to get a significant outbreak of a complex contagion, therefore, we must start the infection on a non-vanishing fraction $\rho$ of all nodes. Let us suppose these initial carriers are selected uniformly at random, so that every node has the same probability $\rho$ of having the infection at the start of the outbreak.
