import networkx as nx

G = nx.complete_graph(5)
E = sum([x for _, x in G.degree()]) / 2
avg = 2*E/G.number_of_nodes()

print(f"The degree sum is {E} and the average degree is {avg}")