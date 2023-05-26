import queue


# vraca dictionary sa cenama puteva od source do svakog node-a (posto je neorijentisan, cena puta u oba smera je ista)
def breadth_first_heuristics(graph, source):
    queue_nodes = queue.Queue(len(graph)) # red
    visited = set() # set posecenih cvorova
    # prev_nodes = dict() # prethodnici cvorova
    node_cost = {source: 0} # stvarne cene puteva od izvornog to datog cvora
    graph[source]=(0,graph[source][1])
    # prev_nodes[source] = None
    visited.add(source)
    queue_nodes.put(source)
    while not queue_nodes.empty(): # obilazimo ceo graf (dok se ne obidju svi cvorovi)
        node = queue_nodes.get() # uzimamo cvor iz reda
        # u red stavljamo sve sledbenike tog cvora 
        for (dest, cost) in graph[node][1]:
            # ako ga prethodno nismo obisli
            if dest not in visited:
                # prev_nodes[dest] = node # postavljamo mu prethodnika
                visited.add(dest) # dodajemo ga u skup obidjenih
                node_cost[dest] = node_cost[node]+cost # postavljamo stvarnu cenu puta
                if graph[dest][0]==-1 or graph[dest][0]>graph[node][0]+cost:
                    graph[dest]=(graph[node][0]+cost,graph[dest][1])
                queue_nodes.put(dest) # dodajemo u red
    return graph # ,prev_nodes



graf = {
    "A": (-1,[("B", 4), ("C", 6), ("F", 1)]),
    "B": (-1,[("D", 4), ("A", 4)]),
    "C": (-1,[("D", 4), ("E", 1), ("A", 6)]),
    "D": (-1,[("E", 2), ("F", 3), ("B", 4), ("C", 4)]),
    "E": (-1,[("F", 4), ("C", 1), ("D", 2)]),
    "F": (-1,[("A", 1), ("D", 3), ("E", 4)])
}

print(breadth_first_heuristics(breadth_first_heuristics(graf,"A"),"C"))
