from functools import reduce


# Konstante
DOWN, RIGHT = True, False
TAKEN, FREE = 1, 0

# dictionary koji sadrzi SVE moguce poteze
ALL_MOVES = {"DOWN": [], "RIGHT": []}
for i in range(3):
    for j in range(5):
        ALL_MOVES["DOWN"].append((i, j))
for i in range(4):
    for j in range(4):
        ALL_MOVES["RIGHT"].append((i, j))

# sve domine
ALL_DOMINOES = {(0, 0), (0, 1), (0, 2), (1, 1), (0, 3),
                (1, 2), (1, 3), (2, 2), (2, 3), (3, 3)}


# proverava da li je moguce naraviti potez move na tabeli table sa preostalim dominama dominoes
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


# kreira listu elemenata tipa (potez,preostale_domine_posle_poteza), za sve moguce poteze iz zadatog stanja state na tabeli table sa dominama dominoes
def valid_move(state, table, dominoes):
    valid = []
    # prvo formiramo listu svih poteza koji ne bi prekrili vec zauzeta polja uz odredjivanje skupa preostalih domina posle datog poteza
    for i, j in ALL_MOVES["DOWN"]:
        if state[i][j] == FREE and state[i+1][j] == FREE:
            valid.append(
                ((i, j, DOWN), dominoes-{(table[i+1][j], table[i][j]), (table[i][j], table[i+1][j])}))
    for i, j in ALL_MOVES["RIGHT"]:
        if state[i][j] == FREE and state[i][j+1] == FREE:
            valid.append(((i, j, RIGHT), dominoes -
                         {(table[i][j+1], table[i][j]), (table[i][j], table[i][j+1])}))

    # iz prethodno kreirane liste izbacujemo poteze koji nisu moguci sa dominama koje trenutno imamo
    return list(filter(lambda move: domino_exists(move, dominoes, table), valid))


# funkcija heuristike trenutnog stanja - prednost se daje stanjima sa najmanje slobodnih polja, kod kojih se koriste domine sa najmanjim ID (da bi postajao red prilikom koriscenja domina) i domine koje imaju jednake polove (jer se one najlakse smestaju na tablu i time se smanjuje stablo trazenja)
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
    return int(dom[1] == dom[0])+min(dom)*3+max(dom)+free_count
    # return min(dom)*3+max(dom)+free_count


# provera da li smo dosli do finalnog stanja
def final_state(state):
    for row in state:
        for x in row:
            if x == FREE:
                return False
    return True


# kreiranje nove matrice stanje na osnovu prethodne matrice i poteza
def new_state(state, move):
    i, j, dir = move
    new_state = [[x for x in row] for row in state]
    if dir == DOWN:
        new_state[i][j], new_state[i+1][j] = TAKEN, TAKEN
    if dir == RIGHT:
        new_state[i][j], new_state[i][j+1] = TAKEN, TAKEN
    return tuple(tuple(x for x in row) for row in new_state)


def place_dominoes(table, dominoes=ALL_DOMINOES):
    # pocetno stanje
    start = ((0, 0, 0, 0, 0),
             (0, 0, 0, 0, 0),
             (0, 0, 0, 0, 0),
             (0, 0, 0, 0, 0))
    prev_states = {start: (None, None)}
    # FORMAT: (trenutno_stanje, poslednji_potez, preostale_domine)
    open_set = []
    closed_set = []
    found_end = False
    open_set.append((start, None, dominoes))
    count = 0
    while len(open_set) > 0 and not found_end:
        count += 1
        # jednostavna implementacija reda sa prioritetom
        state, move, remaining_dominoes = None, None, dominoes.copy()
        for next_state, next_move, doms in open_set:
            if state is None or heuristics(next_state, next_move, table) < heuristics(state, move, table):
                state = next_state
                move = next_move
                remaining_dominoes = doms
        # da li smo dosli do finalnog stanja
        if final_state(state):
            found_end = True
            break
        # prolazimo kroz sve dalje moguce poteze
        for next_move, next_doms in valid_move(state, table, remaining_dominoes):
            # kopiranje matrice trenutnog stanja
            next_state = new_state(state, next_move)
            # ako nismo obisli, dodajemo ga u red i postavljamo prethodnika
            if (next_state, next_move, next_doms) not in open_set and (next_state, next_move, next_doms) not in closed_set:
                open_set.append((next_state, next_move, next_doms))
                prev_states[next_state] = (state, move)
        # oznacavamo da je stanje obidjeno
        if (state, move, remaining_dominoes) in open_set:
            open_set.remove((state, move, remaining_dominoes))
        closed_set.append((state, move, remaining_dominoes))
    # kreiranje putanje
    path = []
    path_moves = []
    if found_end:
        while (prev_states[state] != (None, None)):
            path.append(state)
            path_moves.append(move)
            state = prev_states[state][0]
            move = prev_states[state][1]
        path.append(start)
        path.reverse()
        path_moves.reverse()
    return path, path_moves, count


tabla = [[2, 3, 2, 2, 2],
         [3, 0, 3, 0, 0],
         [3, 0, 3, 1, 1],
         [0, 1, 1, 1, 2]]
moves, path_moves, count = place_dominoes(tabla)
# moguce je i samo napisati print(moves), deo ispod je za lepsi prikaz
print("******* ISTORIJA POTEZA ********")
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
for i in range(len(final_table)):
    for j in range(len(final_table[0])):
        final_table[i][j] = chr(ord("A")+final_table[i][j])
# print(path_moves)
print("******* KONACNO POKRIVANJE ********")
temp = ""
for row in final_table:
    temp += reduce(lambda a, b: a+" "+b, row)+"\n"
print(temp)

print("Ukupan broj prolaska kroz stanja: "+str(count))
