import queue


# vraca dictionary sa minimalnim cenama puteva od source do svakog node-a (posto je neorijentisan, cena puta u oba smera je ista)
def dijkstra_from_source(graf, source):
    open_set = set(source)  # cvorovi koje treba posetiti
    closed_set = set()  # cvorovi koji su poseceni
    g = {}  # stvarna cena puta od polaznog cvora - dict
    g[source] = 0
    while len(open_set) > 0:  # dok ne obradimo svaki
        # trazimo node sa najmanjom cenom puta u setu neobradjenih
        node = None
        for next_node in open_set:
            if node is None or g[next_node] < g[node]:
                node = next_node
        # prolazimo kroz grane trenutnog cvora
        for (m, cost) in graf[node]:
            # ako nema tog cvora
            if m not in open_set and m not in closed_set:
                open_set.add(m)  # dodajemo ga u set neobradjenih
                g[m] = g[node] + cost  # postavljamo stvarnu cenu
            else:
                if g[m] > g[node] + cost:  # inace ako je nova cena manja
                    g[m] = g[node] + cost  # azuriramo cenu
                    # ako smo ga prethodno oznacili kao obradjen - ponistavamo to (jer su se cene puta promenile)
                    if m in closed_set:
                        closed_set.remove(m)
                        open_set.add(m)
        # oznacavamo trenutni cvor kao obradjen
        open_set.remove(node)
        closed_set.add(node)

    return g


# vraca dictionary sa cenama puteva od source do svakog node-a (posto je neorijentisan, cena puta u oba smera je ista)
def breadth_first_from_source(graph, source):
    q = queue.Queue(len(graph)) # red
    visited = set() # set posecenih cvorova
    # prev_nodes = dict() # prethodnici cvorova
    node_cost = {source: 0} # stvarne cene puteva od izvornog to datog cvora
    # prev_nodes[source] = None
    visited.add(source)
    q.put(source)
    while not q.empty(): # obilazimo ceo graf (dok se ne obidju svi cvorovi)
        node = q.get() # uzimamo cvor iz reda
        # u red stavljamo sve sledbenike tog cvora 
        for (next, cost) in graph[node]:
            # ako ga prethodno nismo obisli
            if next not in visited:
                # prev_nodes[next] = node # postavljamo mu prethodnika
                visited.add(next) # dodajemo ga u skup obidjenih
                node_cost[next] = node_cost[node]+cost # postavljamo stvarnu cenu puta
                q.put(next) # dodajemo u red
            # opciona "optimizacija" standardnog BFS
            # elif node_cost[node]+cost<node_cost[next]:
            #     node_cost[next]=node_cost[node]+cost
            #     q.put(next)
    return node_cost # ,prev_nodes


def create_heuristics(graph, g1, g2, traversal):
    # obilazimo graf dva puta na zadat nacin i cuvamo cene puteva
    h1 = traversal(graph, g1)
    h2 = traversal(graph, g2)
    # konstruisemo nov graf sa heuristikom na osnovu pronadjenih cena puteva
    heuristics_graph = {}
    for node in graph:
        heuristics_graph[node] = (min(h1[node], h2[node]), graph[node])
    return heuristics_graph


graf = {
    "A": [("B", 4), ("C", 6), ("F", 1)],
    "B": [("D", 4), ("A", 4)],
    "C": [("D", 4), ("E", 1), ("A", 6)],
    "D": [("E", 2), ("F", 3), ("B", 4), ("C", 4)],
    "E": [("F", 4), ("C", 1), ("D", 2)],
    "F": [("A", 1), ("D", 3), ("E", 4)]
}


print(create_heuristics(graf, "A", "C", dijkstra_from_source))
print(create_heuristics(graf, "A", "C", breadth_first_from_source))
