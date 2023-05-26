WALL = "#"
START = "S"
END = "E"

"""
    Cvor u grafu predstavljen kao tuple(i,j), gde su i i j 2d koordinate u lavirintu
    Graf predstavljen kao dict: cvor -> lista suseda(cvorova)
        - specijalno preslikavanje "start" -> startni cvor (ulaz)
        - specijalno preslikavanje "end" -> krajnji cvor (izlaz)

    Napomena: Lavirint se prevodi u neorijentisani graf (dvosmerni potezi)
"""


def transform(mat):
    graph = {}
    start, end = None, None
    for i in range(0, len(mat)):
        for j in range(0, len(mat[i])):
            if mat[i][j] != WALL:
                graph[(i, j)] = []
                if i > 0 and mat[i-1][j] != WALL:
                    graph[(i, j)].append((i-1, j))
                if i < len(mat)-1 and mat[i+1][j] != WALL:
                    graph[(i, j)].append((i+1, j))
                if j > 0 and mat[i][j-1] != WALL:
                    graph[(i, j)].append((i, j-1))
                if j < len(mat[i]) and mat[i][j+1] != WALL:
                    graph[(i, j)].append((i, j+1))
            if mat[i][j] == START:
                start = (i, j)
            if mat[i][j] == END:
                end = (i, j)

    graph["start"] = start
    graph["end"] = end
    return graph


def find_path(graph):
    prev_nodes = {}
    visited = set()
    stack = []
    stack.append(graph["start"])
    found_end = False
    while len(stack) > 0:
        el = stack.pop()
        if el == graph["end"]:
            found_end = True
            break
        visited.add(el)
        for next in graph[el]:
            if next not in visited:
                stack.append(next)
                prev_nodes[next] = el
    if found_end:
        path = []
        node = graph["end"]
        while node is not None:
            path.append(node)
            if node in prev_nodes:
                node = prev_nodes[node]
            else:
                node = None
        path.reverse()
        return path


mat = ["###S###",
       "# #   #",
       "# ### #",
       "#     #",
       "#E#####"
       ]
g = transform(mat)
print(g)
print(find_path(g))
