from itertools import zip_longest


def uredi(l1, l2):
    return list(map(lambda x: (x[0], x[1], "Da" if x[0] > x[1] else "Ne"),
                zip_longest(l1, l2, fillvalue=0)))


print(uredi([1, 6, 2, 5], [2, 3, 3]))


def proveri(kombinacija):
    resenje = [5, 2, 4, 3]
    pogodjeni = 0
    for i, el in enumerate(kombinacija):
        if el == resenje[i]:
            pogodjeni += 1
    return pogodjeni


def next_guesses(guess):
    ind = -1  # trazimo prvi el jednak nuli
    for i in range(4):
        if guess[i] == 0:
            ind = i
            break
    if ind == -1:
        return []
    ret = []
    for i in range(1, 10):
        temp = list(guess[:])
        temp[ind] = i
        ret.append(tuple(temp))

    return ret


tempp = next_guesses([1, 7, 0, 0])
tempp.sort(key=lambda x: proveri(x))
print(tempp)


def h(guess):
    return 4-proveri(guess)


def hill_climb():
    stack = [(0, 0, 0, 0)]
    found_end = False
    while len(stack) > 0 and not found_end:
        guess = stack.pop()
        print("Pogadjam:", guess)
        if h(guess) == 0:
            found_end = True
            break
        next_states = next_guesses(guess)
        next_states.sort(key=lambda x: proveri(x))
        stack += next_states
    print("Pogodak!")


hill_climb()