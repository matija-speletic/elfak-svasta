tabla = [[2, 3, 2, 2, 2],
         [3, 0, 3, 0, 0],
         [3, 0, 3, 1, 1],
         [0, 1, 1, 1, 2]]

# Constants
DOWN, RIGHT = True, False
TAKEN, FREE = 1, 0
all_moves = {"DOWN": [], "RIGHT": []}
for i in range(3):
    for j in range(5):
        all_moves["DOWN"].append((i, j))
for i in range(4):
    for j in range(4):
        all_moves["RIGHT"].append((i, j))
all_dominoes = {(0, 0), (0, 1), (0, 2), (1, 1), (0, 3),
                (1, 2), (1, 3), (2, 2), (2, 3), (3, 3)}


def domino_exists(move, dominoes, table):
    (i, j, dir), doms = move
    dom = (0, 0)
    if dir == DOWN:
        dom = (table[i][j], table[i+1][j])
    if dir == RIGHT:
        dom = (table[i][j], table[i][j+1])
    if dom in dominoes or (dom[1], dom[0]) in dominoes:
        return True
    return False


def valid_move(state, table, dominoes):
    valid = []
    for i, j in all_moves["DOWN"]:
        if state[i][j] == FREE and state[i+1][j] == FREE:
            valid.append(
                ((i, j, DOWN), dominoes-{(table[i+1][j], table[i][j]), (table[i][j], table[i+1][j])}))
    for i, j in all_moves["RIGHT"]:
        if state[i][j] == FREE and state[i][j+1] == FREE:
            valid.append(((i, j, RIGHT), dominoes -
                         {(table[i][j+1], table[i][j]), (table[i][j], table[i][j+1])}))

    def domino_filter(move):
        return domino_exists(move, dominoes, table)
    return list(filter(domino_filter, valid))


def heuristics(state, move, table):
    free_count = 0
    for row in state:
        for x in row:
            if x == FREE:
                free_count += 1
    if move is None:
        return 12+free_count
    i, j, dir = move
    dom = (0, 0)
    if dir == DOWN:
        dom = (table[i][j], table[i+1][j])
    if dir == RIGHT:
        dom = (table[i][j], table[i][j+1])
    return min(dom)*3+max(dom)+free_count


def final_state(state):
    for row in state:
        for x in row:
            if x == FREE:
                return False
    return True


def new_state(state, move):
    i, j, dir = move
    new_state = [[x for x in row] for row in state]
    if dir == DOWN:
        new_state[i][j], new_state[i+1][j] = TAKEN, TAKEN
    if dir == RIGHT:
        new_state[i][j], new_state[i][j+1] = TAKEN, TAKEN
    return tuple(tuple(x for x in row) for row in new_state)


def place_dominoes(table, dominoes=all_dominoes):
    start = ((0, 0, 0, 0, 0),
             (0, 0, 0, 0, 0),
             (0, 0, 0, 0, 0),
             (0, 0, 0, 0, 0))
    prev_nodes = {start: None}
    open_set = list()
    closed_set = list()
    g = {start: 0}
    found_end = False
    open_set.append((start, None, dominoes))
    while len(open_set) > 0 and not found_end:
        state, move, remaining_dominoes = None, None, dominoes.copy()
        for next_state, next_move, doms in open_set:
            if state is None or g[next_state]+heuristics(next_state, next_move, table) < g[state]+heuristics(state, move, table):
                state = next_state
                move = next_move
                remaining_dominoes = doms
        #print(state,move)
        if final_state(state):
            found_end = True
            break
        for next_move, next_doms in valid_move(state, table, remaining_dominoes):
            next_state = new_state(state, next_move)
            if (next_state, next_move, next_doms) not in open_set and (next_state, next_move, next_doms) not in closed_set:
                open_set.append((next_state, next_move, next_doms))
                prev_nodes[next_state] = state
                g[next_state] = 0
        if (state, move, remaining_dominoes) in open_set:
            open_set.remove((state, move, remaining_dominoes))
        closed_set.append((state, move, remaining_dominoes))
    path = []
    if found_end:

        while (prev_nodes[state] is not None):
            path.append(state)
            state = prev_nodes[state]
        path.append(start)
        path.reverse()
    return path


print("******* POTEZI ********")
moves = place_dominoes(tabla)
final_table = [[-1, -1, -1, -1, -1],
               [-1, -1, -1, -1, -1],
               [-1, -1, -1, -1, -1],
               [-1, -1, -1, -1, -1]]
for move in moves:
    temp = ""
    for row in move:
        temp += str(row)+"\n"
    print(temp)
    for i in range(len(move)):
        for j in range(len(move[i])):
            final_table[i][j] += move[i][j]
print("******* SVI POTEZI ********")
temp = ""
for row in final_table:
    temp += str(row)+"\n"
print(temp)
