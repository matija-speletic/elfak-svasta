

def color_graph_backtrack(graph, assignments, node, color_candidates, result):

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
    if len(color_candidates) > 1:
        # preslikava boja_node->(heuristika_boje,kandidati_posle_dodele)
        color_heuristics = {}
        for c in color_candidates[node]:
            affected = 0  # broj cvorova na koje dodela node->c utice
            for next in graph[node]:
                if next not in assignments and next != node:  # ako nismo vec dodelili boju i ako ne obilazimo trenutni cvor
                    # ako je data boja kandidat u susedu, posle ove dodele vise nece biti
                    if c in color_candidates[next]:
                        affected += 1  # zato ova dodela utice na moguce boje ovog cvora
            # za svaku boju cuvamo heuristiku (broj cvorova na koje dodela utice) i novu listu kandidata posle te dodele
            color_heuristics[c] = affected
        ordered_colors = list(
            sorted(list(color_candidates[node]), key=lambda color: color_heuristics[color]))  # sortiranje na osnovu LCV heuristike
        print("Boje koje mogu dodeliti ovom cvoru su:",
              color_candidates[node], "i njihova LCV heuristika je", color_heuristics, ", pa ih obilazim po redosledu", ordered_colors)
    else:  # ukoliko postoji samo 1 kandidat, nema potrebe da se racuna heuristika, jer postoji samo jedna opcija
        ordered_colors = list(color_candidates[node])
        print("Ovom cvoru mogu dodeliti samo jednu boju i to je",ordered_colors)

    # Backtrack obilazak
    for color in ordered_colors:  # "isprobavamo" redom dodele boja trenutnom cvoru na osnovu LSV
        new_assignments = assignments.copy()  # kopiramo dodele
        new_assignments[node] = color  # trenutnom cvoru dodeljujemo ovu boju
        print("Cvoru",node,"dodeljujemo boju",color)
        new_candidates = {
            k: color_candidates[k].copy() for k in color_candidates}  # kopiramo boje kandidate
        new_candidates[node] = {color}
        # izbacujemo odabranu boju iz kandidata suseda
        for next in graph[node]:
            if next not in assignments and next != node and color in new_candidates[next]:
                new_candidates[next].remove(color)
                print("Sada susedni cvor",next,"moze uzedi jednu od sledecih boja",new_candidates[next])
                # ako smo dobili prazan skup znaci da ovakva dodela nije moguca
                if len(new_candidates[next]) == 0:
                    print("Medjutim, to je prazan skup, sto nam govori da ova dodela nije validna, pa se zato vracamo")
                    return None
        # ako smo svakom cvoru dodelili, onda je to kraj, jer je FC obezbedio da dodele budu validne
        if len(new_assignments) == len(graph):
            print("Sada smo svakom cvoru dodelili boju i vracamo rezultat")
            result = new_assignments
            return result
        # pozivamo rekurzivno ovu metodu za svakog suseda, prosledjujuci mu odgovarajuci spisak kandidata boja
        for next in graph[node]:
            if next not in assignments and next != node:
                print("Prelazimo na sledeci cvor",next)
                res = color_graph_backtrack(graph, new_assignments,
                                            next, new_candidates, result)
                if res != None:
                    print("Rezultat je pronadjen, nema potrebe obilaziti ostale cvorove")
                    return res


def color_graph(graph, colors):
    result = None
    candidates = {k: colors.copy() for k in graph}
    result = color_graph_backtrack(
        graph, {}, next(iter(graph)), candidates, result)
    return result


graph = {
    'A': ['B', 'C'],
    'B': ['A', 'E', 'C'],
    'C': ['A', 'E', 'B', 'D'],
    'D': ['C', 'E'],
    'E': ['C', 'D', 'B']
}

colors = {"R", "G", "B"}

result = color_graph(graph, colors)
print(result)
