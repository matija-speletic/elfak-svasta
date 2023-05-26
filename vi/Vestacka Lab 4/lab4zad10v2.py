from functools import reduce
from termcolor import cprint


# Konstante
DOWN, RIGHT = True, False
TAKEN, FREE = 1, 0

# dictionary koji sadrzi SVE moguce poteze
ALL_MOVES = {
    "DOWN": [(i, j)for i in range(3) for j in range(5)],
    "RIGHT": [(i, j) for i in range(4) for j in range(4)]
}

# sve domine
ALL_DOMINOES = {(0, 0), (0, 1), (0, 2), (1, 1), (0, 3),
                (1, 2), (1, 3), (2, 2), (2, 3), (3, 3)}


# DEPRECATED - proverava da li je moguce naraviti potez move na tabeli table sa preostalim dominama dominoes
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
def valid_moves(state, table, dominoes):
    valid = []
    # prvo formiramo listu svih poteza koji ne bi prekrili vec zauzeta polja uz odredjivanje skupa preostalih domina posle datog poteza
    for i, j in ALL_MOVES["DOWN"]:
        if state[i][j] == FREE and state[i+1][j] == FREE:
            # preostale domine posle ovog poteza

            # ako se u skupu dominoes nije nalazila nijedna od ove dve varijante domine, znaci da ovaj potez nije moguce napraviti, inace odredjujemo preostale domine posle tog poteza i stavljamo potez u listu validnih poteza
            if (table[i+1][j], table[i][j]) in dominoes or (table[i][j], table[i+1][j]) in dominoes:
                remaining_dominoes = dominoes - \
                    {(table[i+1][j], table[i][j]),
                     (table[i][j], table[i+1][j])}
                valid.append(((i, j, DOWN), remaining_dominoes))
    for i, j in ALL_MOVES["RIGHT"]:
        if state[i][j] == FREE and state[i][j+1] == FREE:
            if (table[i][j+1], table[i][j]) in dominoes or (table[i][j], table[i][j+1]) in dominoes:
                remaining_dominoes = dominoes - \
                    {(table[i][j+1], table[i][j]),
                     (table[i][j], table[i][j+1])}
                valid.append(((i, j, RIGHT), remaining_dominoes))

    # iz prethodno kreirane liste izbacujemo poteze koji nisu moguci sa dominama koje trenutno imamo
    # return list(filter(lambda move: domino_exists(move, dominoes, table), valid))
    return valid


# funkcija heuristike trenutnog stanja - prednost se daje stanjima sa najmanje slobodnih polja, kod kojih se koriste domine sa najmanjim ID (da bi postajao red prilikom koriscenja domina) i domine koje imaju jednake polove (jer se one najlakse smestaju na tablu i time se smanjuje stablo trazenja)
def heuristics(state, move, table):
    free_count = 20-reduce(lambda a, b: a+b,
                           [reduce(lambda a, b:a+b, row) for row in state])
    if move is None:
        return 12+free_count
    i, j, dir = move
    dom = (table[i][j], table[i+1][j] if dir == DOWN else table[i][j+1])
    domino_id = min(dom)*3+max(dom)
    return (1-int(dom[1] == dom[0]))+domino_id+free_count
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
    start = tuple(tuple(FREE for _ in range(5)) for _ in range(4))
    # FORMAT: stanje -> (prethodno_stanje, potez)
    # FORMAT poteza: (rb_vrste, rb_kolone, smer: DOWN | RIGHT )
    prev_states = {start: (None, None)}
    # FORMAT: trenutno_stanje -> (poslednji_potez, preostale_domine: set)
    open_set = dict()
    closed_set = set()
    found_end = False
    open_set[start] = (None, dominoes)
    while len(open_set) > 0 and not found_end:
        # jednostavna implementacija reda sa prioritetom
        state, move, remaining_dominoes = None, None, dominoes.copy()
        for next_state in open_set:
            next_move, doms = open_set[next_state]
            if state is None or heuristics(next_state, next_move, table) < heuristics(state, move, table):
                state = next_state
                move = next_move
                remaining_dominoes = doms
        # da li smo dosli do finalnog stanja
        if final_state(state):
            found_end = True
            break
        # prolazimo kroz sve dalje moguce poteze
        for next_move, next_doms in valid_moves(state, table, remaining_dominoes):
            # kopiranje matrice trenutnog stanja
            next_state = new_state(state, next_move)
            # ako nismo obisli, dodajemo ga u red i postavljamo prethodnika
            if next_state not in open_set and next_state not in closed_set:
                open_set[next_state] = (next_move, next_doms)
                prev_states[next_state] = (state, next_move)
        # oznacavamo da je stanje obidjeno
        if state in open_set:
            open_set.pop(state)
        closed_set.add(state)
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
    return path, path_moves


def run_test(tabla):
    moves, path_moves = place_dominoes(tabla)
    # moguce je i samo napisati print(moves), deo ispod je za lepsi prikaz
    print("******** ISTORIJA POTEZA ********")
    final_table = [[-1, -1, -1, -1, -1],
                   [-1, -1, -1, -1, -1],
                   [-1, -1, -1, -1, -1],
                   [-1, -1, -1, -1, -1]]
    k = 0
    for move in moves:
        temp = ""
        for row in move:
            temp += str(row)+"\n"
        print(temp)
        if k < 10:
            print("Potez:", path_moves[k][:2],
                  "DOWN" if path_moves[k][2] == DOWN else "RIGHT")
        k += 1
        for i in range(len(move)):
            for j in range(len(move[i])):
                final_table[i][j] += move[i][j]
    for i in range(len(final_table)):
        for j in range(len(final_table[0])):
            final_table[i][j] = chr(ord("A")+final_table[i][j])
    print("******** KONACNO POKRIVANJE ********\n")
    # print(final_table)
    colors = {"A": "white", "B": "white", "C": "white", "D": "white",
              "E": "white", "F": "white", "G": "white", "H": "grey", "I": "magenta", "J": "magenta"}
    background = {"A": "on_magenta", "B": "on_red", "C": "on_green", "D": "on_yellow", "E": "on_blue",
                  "F": "on_grey", "G": "on_cyan", "H": "on_white", "I": "on_green", "J": "on_cyan"}
    for i in range(len(final_table)):
        for j in range(len(final_table[0])):
            cprint(" "+str(tabla[i][j])+" ", colors[final_table[i][j]],
                   background[final_table[i][j]], attrs=["bold"], end="")
        print()


tabla1 = [[2, 3, 2, 2, 2],
          [3, 0, 3, 0, 0],
          [3, 0, 3, 1, 1],
          [0, 1, 1, 1, 2]]

tabla2 = [[1, 2, 3, 1, 2],
          [0, 3, 1, 3, 0],
          [1, 3, 2, 2, 0],
          [1, 0, 2, 3, 0]]

tabla3 = [[2, 3, 3, 0, 0],
          [2, 1, 3, 0, 0],
          [2, 1, 1, 2, 0],
          [3, 3, 1, 2, 1]]

tabla4 = [[2, 3, 3, 0, 0],
          [2, 1, 3, 1, 0],
          [2, 0, 2, 1, 0],
          [3, 3, 1, 2, 1]]

run_test(tabla3)
