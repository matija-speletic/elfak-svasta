from termcolor import colored, cprint


"""
STANJE:
    1. Trenutni cvor
    2. Dodela boja cvorovima (dict: cvor -> boja)
    3. Boje kandidati (domeni) za svaki cvor (dict: cvor -> {skup_boja})
"""


def color_graph_backtrack(graph, assignments, node, color_candidates, result, next_node):

    print()
    cprint("Obilazim cvor " + str(node), attrs=["bold", "underline"])

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
        cprint("LCV analiza:", attrs=["underline"], end=" ")
        color_heuristics = {} # boja -> heuristika_boje
        print("Boje koje se mogu dodeliti ovom cvoru su",
              color_candidates[node], end=". ")
        for c in color_candidates[node]:
            print("Ako mu dodelimo boju", colored(c, c),
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
        print("Ovom cvoru mogu dodeliti samo jednu boju i to je",
              colored(ordered_colors[0], ordered_colors[0]))

    # Backtrack obilazak
    for color in ordered_colors:  # "isprobavamo" redom dodele boja trenutnom cvoru na osnovu LSV
        new_assignments = assignments.copy()  # kopiramo dodele
        new_assignments[node] = color  # trenutnom cvoru dodeljujemo ovu boju
        print("Cvoru", colored(node, attrs=[
              "bold"]), "dodeljujemo boju", colored(color, color))
        new_candidates = {
            k: color_candidates[k].copy() for k in color_candidates}  # kopiramo boje kandidate
        new_candidates[node] = {color}
        # izbacujemo odabranu boju iz kandidata suseda
        color_valid = True
        for next in graph[node]:
            if next not in assignments and next != node and color in new_candidates[next]:
                new_candidates[next].remove(color)
                # Forward Checking
                # ako smo dobili prazan skup znaci da ovakva dodela nije moguca
                cprint("Forward check:", attrs=["underline"], end=" ")
                if len(new_candidates[next]) == 0:
                    print("Ako cvoru", node, "dodelimo boju", colored(color, color), "onda njegovom susednom cvoru", next,
                          "ne mozemo dodeliti nijednu boju, sto nam govori da je dodela nevalidna i da se moramo preci na sledecu boju ili",
                          " se moramo vratiti unazad")
                    color_valid = False
                    break
                else:
                    print("Sada susedni cvor", next,
                          "moze uzeti jednu od sledecih boja", new_candidates[next])
        if not color_valid:
            continue

        # ako smo svakom cvoru dodelili, onda je to kraj, jer je FC obezbedio da dodele budu validne
        if len(new_assignments) == len(graph):
            print("Sada smo svakom cvoru dodelili boju i vracamo rezultat:")
            result = new_assignments
            return result
        # pozivamo rekurzivno ovu metodu za suseda, prosledjujuci mu odgovarajuci spisak kandidata boja
        next = next_node[node]
        if next not in assignments and next != node:
            print("Prelazimo na sledeci cvor", next)
            res = color_graph_backtrack(graph, new_assignments,
                                        next, new_candidates, result, next_node)
            if res != None:
                return res


def color_graph(graph, colors, traversal_order=None):
    if traversal_order == None:
        traversal_order = [k for k in graph]
    next_node = {"START": traversal_order[0]}
    for i in range(len(traversal_order)-1):
        next_node[traversal_order[i]] = traversal_order[i+1]
    next_node[traversal_order[-1]] = None
    # print(next_node)
    result = None
    candidates = {k: colors.copy() for k in graph}
    result = color_graph_backtrack(
        graph, {}, next_node["START"], candidates, result, next_node)
    return result


graph = {
    'A': ['B', 'C'],
    'B': ['A', 'E', 'C'],
    'C': ['A', 'E', 'B', 'D'],
    'D': ['C', 'E'],
    'E': ['C', 'D', 'B']
}

petersen_graph = {
    "A": ["B", "E", "F"],
    "B": ["A", "C", "G"],
    "C": ["D", "H", "B"],
    "D": ["C", "I", "E"],
    "E": ["J", "A", "D"],
    "F": ["I", "H", "A"],
    "G": ["J", "I", "B"],
    "H": ["C", "F", "J"],
    "I": ["F", "G", "D"],
    "J": ["E", "H", "G"]
}

graph2 = {
    "A": ["B", "E", "F", "G"],
    "B": ["A", "C", "G", "F"],
    "C": ["D", "G", "B", "F"],
    "D": ["C", "G", "E", "F"],
    "E": ["G", "A", "D", "F"],
    "F": ["A", "B", "C", "D", "E", "G"],
    "G": ["A", "B", "C", "D", "E", "F"]
}

colors = {"red", "green", "blue"}

# result = color_graph(graph, colors, "ABEDC") # lepo se vidi primena LVC heuristike
result = color_graph(graph, colors, "DCABE") # lepo se vidi vracanje unazad
# result = color_graph(petersen_graph, colors, "ABCDEJHFIG")
# result = color_graph(graph2, {"red", "blue", "green", "yellow", "magenta"})
if result == None:
    print("Nije moguce izvrsiti dodelu ovih boja ovom grafu")
else:
    for node in result:
        print(node, "->", colored(result[node], result[node]))
