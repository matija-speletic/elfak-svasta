


def color_graph_backtrack(graph, assignments, node, color_candidates, result,next_node):
   
    print(assignments)
    print(color_candidates)
    print()
    if result != None:
        return result
    if len(assignments) == len(graph):
        result = assignments
        return result
    # preslikava boja_node->(heuristika_boje,kandidati_posle_dodele)
    color_heuristics = {}
    for c in color_candidates[node]:
        affected = 0  # broj cvorova na koje dodela node->c utice
        new_candidates = {
            k: color_candidates[k].copy() for k in color_candidates}  # izmenjena lista kandidata posle dodele node->c
        new_candidates[node] = {c}
        for next in graph[node]:
            if next not in assignments and next != node:  # ako nismo vec dodelili boju i ako ne obilazimo trenutni cvor
                # ako je data boja kandidat u susedu, posle ove dodele vise nece biti
                if c in color_candidates[next]:
                    affected += 1  # zato ova dodela utice na moguce boje ovog cvora
                    # u listi novih kandidata je izbacujemo
                    new_candidates[next].remove(c)
        # za svaku boju cuvamo heuristiku (broj cvorova na koje dodela utice) i novu listu kandidata posle te dodele
        color_heuristics[c] = (affected, new_candidates)
    ordered_colors = list(
        (sorted(list(color_candidates[node]), key=lambda color: color_heuristics[color][0])))  # sortiranje na osnovu LCV heuristike
    for color in ordered_colors:  # "isprobavamo" redom dodele boja trenutnom cvoru na osnovu LSV
        new_assignments = assignments.copy()  # kopiramo dodele
        new_assignments[node] = color  # trenutnom cvoru dodeljujemo ovu boju
        # ako smo svakom cvoru dodelili, onda je to kraj, jer je FC obezbedio da dodele budu validne
        if len(new_assignments) == len(graph):
            result = new_assignments
            return result
        # pozivamo rekurzivno ovu metodu za svakog suseda, prosledjujuci mu odgovarajuci spisak kandidata boja
        next=next_node[node]
        if next not in assignments and next != node:
            candidates = color_heuristics[color][1]
            res = color_graph_backtrack(graph, new_assignments,
                                        next, candidates, result,next_node)
            if res != None:
                return res


def color_graph(graph, colors):
    result = None
    candidates = {k: colors.copy() for k in graph}
    next_node={
        "A":"B",
        "B":"C",
        "C":"D",
        "D":"E"
    }
    result = color_graph_backtrack(
        graph, {}, next(iter(graph)), candidates, result,next_node)
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
