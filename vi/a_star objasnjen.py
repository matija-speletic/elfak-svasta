def a_star(graf, start, end):
    found_end = False
    open_set = set(start) # cvorovi koje treba posetiti
    closed_set = set() # cvorovi koji su poseceni
    g = {} # stvarna cena puta od polaznog cvora - dict
    prev_nodes = {} # prethodnici svakog cvora - dict
    g[start] = 0
    prev_nodes[start] = None
    while len(open_set) > 0 and (not found_end): # dok ne obradimo svaki ili dok ne pronadjemo cilj
        # trazimo node sa najmanjom cenom puta u setu neobradjenih
        node = None
        for next_node in open_set:
            if node is None or g[next_node] + graf[next_node][0] < g[node] + graf[node][0]:
                node = next_node
        # ako smo dosli do kraja
        if node == end:
            found_end = True
            break
        # prolazimo kroz grane trenutnog cvora
        for (m, cost) in graf[node][1]:
            # ako nema tog cvora
            if m not in open_set and m not in closed_set:
                open_set.add(m) # dodajemo ga u set neobradjenih
                prev_nodes[m] = node # postavlajamo mu prethodnika
                g[m] = g[node] + cost # postavljamo stvarnu cenu
            else:
                if g[m] > g[node] + cost: # inace ako je nova cena manja
                    g[m] = g[node] + cost # azuriramo cenu
                    prev_nodes[m] = node # postavljamo mu novog prethodnika
                    if m in closed_set: # ako smo ga prethodno oznacili kao obradjen - ponistavamo to (jer su se cene puta promenile)
                        closed_set.remove(m)
                        open_set.add(m)
        # oznacavamo trenutni cvor kao obradjen
        open_set.remove(node)
        closed_set.add(node)
    path = []
    if found_end:
        prev = end
        while prev_nodes[prev] is not None:
            path.append(prev)
            prev = prev_nodes[prev]
        path.append(start)
        path.reverse()
    return path


graf = {
    "A": (9, [("B", 4), ("C", 6)]),
    "B": (6, [("D", 4), ("A", 2)]),
    "C": (2, [("D", 4), ("E", 1)]),
    "D": (2, [("E", 2), ("F", 3)]),
    "E": (3, [("F", 4)]),
    "F": (0, [("A", 1)])
}

print(a_star(graf, "A", "F"))
