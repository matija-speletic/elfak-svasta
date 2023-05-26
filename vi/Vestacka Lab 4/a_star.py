from functools import reduce


def valid_move(node, tabla):
    if node[0] < 0 or node[0] > 7 or node[1] < 0 or node[1] > 7 or tabla[node[0]][node[1]] == 1:
        return False
    return True


def get_destination(node, tabla):
    all_destinations = [(node[0] - 2, node[1] - 1), (node[0] - 2, node[1] + 1),
                        (node[0] - 1, node[1] - 2), (node[0] - 1, node[1] + 2),
                        (node[0] + 1, node[1] - 2), (node[0] + 1, node[1] + 2),
                        (node[0] + 2, node[1] - 1), (node[0] + 2, node[1] + 1)]
    return list(x for x in all_destinations if valid_move(x, tabla))


def h_function(node):
    return 7 - node[0]


def a_star(start, tabla):
    found_end = False
    open_set = set()
    closed_set = set()
    g = {}
    prev_nodes = {}
    g[start] = 0
    prev_nodes[start] = None
    open_set.add(tuple(start, ))
    while len(open_set) > 0 and (not found_end):
        node = None
        for next_node in open_set:
            if node is None or g[next_node] + h_function(next_node) < g[node] + h_function(node):
                node = next_node
        if node[0] == 7:
            found_end = True
            break
        for destination in get_destination(node, tabla):
            if destination not in open_set and destination not in closed_set:
                open_set.add(destination)
                prev_nodes[destination] = node
                g[destination] = g[node] + 3
            else:
                if g[destination] > g[node] + 3:
                    g[destination] = g[node] + 3
                    prev_nodes[destination] = node
                    if destination in closed_set:
                        closed_set.remove(destination)
                        open_set.add(destination)
        open_set.remove(node)
        closed_set.add(node)
    path = []
    if found_end:
        while prev_nodes[node] is not None:
            path.append(node)
            node = prev_nodes[node]
        path.append(start)
        path.reverse()
    return path


a = ((0, 1, 1, 0),
     (1, 1, 0, 0),
     (0, 0, 0, 1))
free_count = 12-reduce(lambda a, b: a+b,
                       [reduce(lambda a, b:a+b, row) for row in a])
print(free_count)
