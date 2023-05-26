FREE = 0


def prelazi(slagalica):
    fi = -1  # free i
    fj = -1  # free j
    for i in range(len(slagalica)):
        for j in range(len(slagalica[i])):
            if slagalica[i][j] == FREE:
                fi = i
                fj = j
    sledeca_stanja = []
    if fi > 0:  # zamena sa gornjom
        temp = [slagalica[i][:] for i in range(len(slagalica))]
        (temp[fi][fj], temp[fi-1][fj]) = (temp[fi-1][fj], temp[fi][fj])
        sledeca_stanja.append(temp)
    if fi < len(slagalica)-1:  # zamena sa donjom
        temp = [slagalica[i][:] for i in range(len(slagalica))]
        (temp[fi][fj], temp[fi+1][fj]) = (temp[fi+1][fj], temp[fi][fj])
        sledeca_stanja.append(temp)
    if fj > 0:  # zamena sa levom
        temp = [slagalica[i][:] for i in range(len(slagalica))]
        (temp[fi][fj], temp[fi][fj-1]) = (temp[fi][fj-1], temp[fi][fj])
        sledeca_stanja.append(temp)
    if fj > len(slagalica[fi]):  # zamena sa gornjom
        temp = [slagalica[i][:] for i in range(len(slagalica))]
        (temp[fi][fj], temp[fi][fj+1]) = (temp[fi][fj+1], temp[fi][fj])
        sledeca_stanja.append(temp)
    return sledeca_stanja


def h(slagalica):
    ciljno_stanje = {
        FREE:(1,1),
        1: (0, 0),  # cilj:
        2: (0, 1),  # 1 2 3
        3: (0, 2),  # 8   4
        4: (1, 2),  # 7 6 5
        5: (2, 2),
        6: (2, 1),
        7: (2, 0),
        8: (1, 0)
    }
    h = 0
    for i in range(len(slagalica)):
        for j in range(len(slagalica[i])):
            # heuristika je broj poteza do cilja za svako polje
            # broj poteza do cilja je jednako Menhetn rastojanju
            # od stvarne pozicije do ciljne pozicije
            cilj_i, cilj_j = ciljno_stanje[slagalica[i][j]]
            h += abs(cilj_i-i)+abs(cilj_j-j)
    return h


slagalica = [[7, 2, 3], [5, 8, FREE], [4, 1, 6]]
print(h(slagalica))
print(prelazi(slagalica))
