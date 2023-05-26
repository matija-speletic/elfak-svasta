from functools import reduce

# 12. zadatak
# Korišdenjem programskog jezika Python, napisati funkciju izracunaj, koja u listi koja se sastoji od brojeva i
# podlisti, menja svaki broj njegovim kvadratom, dok listu zamenjuje zbirom kvadrata brojeva koji je čine.
# Zabranjeno je korišdenje petlji (osim u comprehension sintaksi).


def izracunaj(lista: list) -> list:
    return [x**2 if type(x) == int else reduce(lambda acc, el:acc+el**2, x, 0) for x in lista]
    # return list(map(lambda x: x**2 if isinstance(x, int) else reduce(lambda acc, el: acc+el**2, x, 0), lista))


print(izracunaj([2, 4, [1, 2, 3], [4, 2], 2, [9, 5]]))
