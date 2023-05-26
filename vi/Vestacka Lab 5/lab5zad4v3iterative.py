

def color_graph(graph, colors,traversal_order=None):
    if traversal_order == None:
        traversal_order = [k for k in graph]
    next_node = {"START": traversal_order[0]}
    for i in range(len(traversal_order)-1):
        next_node[traversal_order[i]] = traversal_order[i+1]
    next_node[traversal_order[-1]] = None
    # print(next_node)
    result = None
    candidates = {k: colors.copy() for k in graph}
    stack=[]
    stack.append(({}, next_node["START"], candidates))
    while len(stack)>0:
        assignments,node,color_candidates=stack.pop()
        print()
        print("Obilazim cvor", node)
        # print(assignments)
        # print(color_candidates)

        # Provera da li smo dosli do kraja
        if result != None:
            print("Rezultat pronadjen, vracam se")
            return result
        if len(assignments) == len(graph):
            print("Rezultat pronadjen, vracam se")
            result = assignments
            return result

        # Racunanje LCV heuristike za pojedinacne boje i odredjivanje redosleda obilaska
        if len(color_candidates[node]) > 1:
            # preslikava boja_node->(heuristika_boje,kandidati_posle_dodele)
            color_heuristics = {}
            print("Boje koje se mogu dodeliti ovom cvoru su",
                color_candidates[node], end=". ")
            for c in color_candidates[node]:
                print("Ako mu dodelimo boju", c,
                    "to ce uticati na cvor(ove)", end=" ")
                affected = 0  # broj cvorova na koje dodela node->c utice
                for next in graph[node]:
                    if next not in assignments and next != node:  # ako nismo vec dodelili boju i ako ne obilazimo trenutni cvor
                        # ako je data boja kandidat u susedu, posle ove dodele vise nece biti
                        if c in color_candidates[next]:
                            print(next, end=", ")
                            affected += 1  # zato ova dodela utice na moguce boje ovog cvora
                # za svaku boju cuvamo heuristiku (broj cvorova na koje dodela utice) i novu listu kandidata posle te dodele
                color_heuristics[c] = affected
            ordered_colors = list(
                sorted(list(color_candidates[node]), key=lambda color: color_heuristics[color]))  # sortiranje na osnovu LCV heuristike
            print("Zbog ovoga je LCV heuristika boja", color_heuristics,
                ", pa ih obilazim po redosledu", ordered_colors)
        else:  # ukoliko postoji samo 1 kandidat, nema potrebe da se racuna heuristika, jer postoji samo jedna opcija
            ordered_colors = list(color_candidates[node])
            print("Ovom cvoru mogu dodeliti samo jednu boju i to je", ordered_colors)

        # Backtrack obilazak
        for color in ordered_colors:  # "isprobavamo" redom dodele boja trenutnom cvoru na osnovu LSV
            exit_loop=False
            new_assignments = assignments.copy()  # kopiramo dodele
            new_assignments[node] = color  # trenutnom cvoru dodeljujemo ovu boju
            print("Cvoru", node, "dodeljujemo boju", color)
            new_candidates = {
                k: color_candidates[k].copy() for k in color_candidates}  # kopiramo boje kandidate
            new_candidates[node] = {color}
            # izbacujemo odabranu boju iz kandidata suseda
            for next in graph[node]:
                if next not in assignments and next != node and color in new_candidates[next]:
                    new_candidates[next].remove(color)
                    # ako smo dobili prazan skup znaci da ovakva dodela nije moguca
                    if len(new_candidates[next]) == 0:
                        print("Ako cvoru", node, "dodelimo boju", color, "onda njegovom susednom cvoru", next,
                            "ne mozemo dodeliti nijednu boju,", "sto nam govori da je dodela nevalidna i da se moramo vratiti nazad")
                        exit_loop=True
                        break
                    else:
                        print("Sada susedni cvor", next,
                            "moze uzedi jednu od sledecih boja", new_candidates[next])
            if exit_loop:
                break

            # ako smo svakom cvoru dodelili, onda je to kraj, jer je FC obezbedio da dodele budu validne
            if len(new_assignments) == len(graph):
                print("Sada smo svakom cvoru dodelili boju i vracamo rezultat:")
                result = new_assignments
                return result
            # pozivamo rekurzivno ovu metodu za suseda, prosledjujuci mu odgovarajuci spisak kandidata boja
            next = next_node[node]
            if next not in assignments and next != node:
                print("Prelazimo na sledeci cvor", next)
                stack.append((new_assignments,next, new_candidates))


graph = {
    'A': ['B', 'C'],
    'B': ['A', 'E', 'C'],
    'C': ['A', 'E', 'B', 'D'],
    'D': ['C', 'E'],
    'E': ['C', 'D', 'B']
}

petersen_graph={
    "A":["B","E","F"],
    "B":["A","C","G"],
    "C":["D","H","B"],
    "D":["C","I","E"],
    "E":["J","A","D"],
    "F":["I","H","A"],
    "G":["J","I","B"],
    "H":["C","F","J"],
    "I":["F","G","D"],
    "J":["E","H","G"]
}

colors = {"RED", "GREEN", "BLUE"}

result = color_graph(petersen_graph, colors)
#result = color_graph(graph, colors, ["A", "B", "E", "D", "C"])
print(result)
