from itertools import zip_longest, islice, pairwise, starmap, groupby
from functools import reduce
import re


# 1. poredak
def poredak(l1, l2):  # moze map i comp
    return list(
        map(lambda x: (x[0], x[1], "Jeste" if x[1] == 2*x[0] else "Nije"),
            zip_longest(l1, l2, fillvalue=0)))


print("1. poredak:", poredak([1, 7, 2, 4], [2, 5, 2]))


# 2. spojidict
def spojidict(l1, l2):  # moze map i comp
    return [{"prvi": x[0], "drugi":x[1]} for x in zip_longest(l1, l2, fillvalue="-")]


print("2. spojidict:", (spojidict([1, 7, 2, 4], [2, 5, 2])))


# 3. spoji
def spoji(l1, l2):
    return [(x[0], x[1], x[0]+x[1]) if x[0] <= x[1] else (x[1], x[0], x[0]+x[1])
            for x in zip_longest(l1, l2, fillvalue=0)]


print("3. spoji:", (spoji([1, 7, 2, 4], [2, 5, 2])))


# 4. suma
def suma(l):
    # prvo spojimo liste pa nadjemo zbir
    return reduce(lambda x, y: x+y, reduce(lambda x, y: x+y, l, []), 0)
    # return reduce(lambda x, y: x+y, [reduce(lambda x, y: x+y, l1, 0) for l1 in l], 0) # nadjemo podzbirove, pa zbir
    # return reduce(lambda x,y:x+y,[el for sublist in l for el in sublist]) # raspakujemo listu pa nalazimo zbir


print("4. suma", suma([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))


# 5. proizvod
def proizvod(l1, l2):
    return [a*b for a, b in zip([reduce(lambda x, y:x+y, sublist, 0) for sublist in l1], l2)]


print("5. proizvod", proizvod([[1, 2, 3], [4, 5, 6], [7, 8, 9]], [1, 2, 3]))


# 6. objedini
def objedini(l1, l2):
    return [x if x[0] <= x[1] else (x[1], x[0]) for x in zip_longest(l1, l2, fillvalue=0)]


print("6. objedini", objedini([1, 7, 2, 4, 5], [2, 5, 2]))


# 7. objedini2
def objedini2(l):
    # return {x[0]: list(x[1:]) if len(x) > 1 else None for x in l}
    return {x[0]: list(islice(x, 1, len(x))) if len(x) > 1 else None for x in l}


print("7. objedini2", objedini2(
    [(1,), (3, 4, 5), (7,), (1, 4, 5), (6, 2, 1, 3)]))


# 8. izracunaj
def izracunaj(l):
    return [reduce(lambda x, y:x*y, x, 1) if isinstance(x, list) else x for x in l]


print("8. izracunaj", izracunaj([1, 5, [1, 5, 3], [4, 2], 2, [6, 3]]))


# 9. zamena
def zamena(l, x):
    return [reduce(lambda a, b:a+b, l[ind+1:], 0) if y < x else y for ind, y in zip(range(len(l)), l)]
    # enumerate(l) moze umesto ovog zip


print("9. zamena",  zamena([1, 7, 5, 4, 9, 1, 2, 7], 5))


# 10. stepen
def stepen(l):
    return list(starmap(lambda x, y: x**y, pairwise(l)))


print("10. stepen", stepen([1, 5, 2, 6, 1, 6, 3, 2, 9]))


# 11. proizvod2
def proizvod2(l):
    # return reduce(lambda x, y: x*y, reduce(lambda x, y: x+y, l, []), 1)
    # return reduce(lambda x, y: x*y, [reduce(lambda x, y: x*y, l1, 1) for l1 in l], 1) # nadjemo podzbirove, pa zbir
    # raspakujemo listu pa nalazimo zbir
    return reduce(lambda x, y: x*y, [el for sublist in l for el in sublist], 1)


print("11. proizvod", proizvod2([[1, 3, 5], [2, 4, 6], [1, 2, 3]]))


# 12. izracunaj2
def izracunaj2(l):
    return list(map(lambda x: x**2 if type(x) == int else reduce(lambda x, y: x+y**2, x, 0), l))


print("12. izracunaj", izracunaj2([2, 4, [1, 2, 3], [4, 2], 2, [9, 5]]))


# 13. skupi
def skupi(l):
    return [list(map(lambda a:a[0]+a[1], zip_longest(x[0], x[1], fillvalue=0))) for x in pairwise(l)]


print("13. skupi", skupi([[1, 3, 5], [2, 4, 6], [1, 2]]))


# 14. suma2
def suma2(l):
    return [reduce(lambda x, y:x+y, l1, 0) for l1 in l]


print("14. suma", suma2([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))


# 15. promeni
def promeni(l, x):
    return list(map(lambda a: a+x if a <= x else a-x, l))


print("15. promeni", promeni([7, 1, 3, 5, 6, 2], 3))


# 16. broj
def broj(s):
    return reduce(lambda x, y: x+y, [int(s[2*i+1:2*i+3], 16)*256**(2-i) for i in range(3)])


print("16. broj", broj("#FA0EA0"))


# 17. tekst
def tekst(st: str) -> str:
    lista = list([x if ord(x) in range(65, 91) or ord(x) in range(97, 123) or ord(
        x) in range(48, 58) else "\\u"+str(hex(ord(x))).upper() for x in st])
    return ''.join(map(str, lista))


print(tekst("Otpornost 10Ω."))


# 18. brojevi
def brojevi(txt: str) -> list:
    # return  list(map(lambda x: int(x), list(re.findall(r"(\d+)", text))))
    return [int(s) for s in re.split('[ ; + = * ]', txt) if s.isdigit()]


print(brojevi("42+10=52;10*10=100"))


# 19. brojanje
def brojanje(lista: list):
    return len(list(filter(lambda x: x > 1, [len(list(g)) for k, g in groupby(lista)])))


print(brojanje("aatesttoviicc"))


print(brojanje("aaaatesttovi"))


# 20. izracunaj
def izracunaj(l, f):
    return [f(*l1) for l1 in [l[x:x+3] for x in range(len(l)-2)]]


print("20. izracunaj", izracunaj([2, 5, 1, 6, 7], lambda x, y, z: x + y * z))
