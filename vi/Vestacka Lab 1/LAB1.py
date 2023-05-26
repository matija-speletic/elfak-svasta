# 1. parni, koja određuje broj parnih elemenata zadate liste
from functools import reduce


def parni(l: list) -> int:
    nums = {"Parni": [], "Neparni": []}
    for x in l:
        if x % 2 == 0:
            nums["Parni"].append(x)
        else:
            nums["Neparni"].append(x)
    return nums


print(parni([1, 7, 2, 4, 5]))

# 2. 


def numlista(l):
    res={}
    for x in l:
        if type(x).__name__ not in res:
            res[type(x).__name__]=[]
        res[type(x).__name__].append(x)
    return res


print(numlista(["Prvi", "Drugi", 2, 4, [3, 5]]))

# 3. uredi, koja svaki od prvih n elemenata uvećava za definisanu vrednost a preostale umanjuje za
# definisanu vrednost. Funkciji se prosleđuje lista koja sadrži samo numeričke vrednosti i vrednost
# koja treba da se uvećava, odnosno umanjuje. Zabranjeno je korišćenje patlji.


def uredi(l, num, val):
    res = []
    for i in range(len(l)):
        if i < num:
            res.append(l[i]+val)
        else:
            res.append(l[i]-val)
    return res


print("3", uredi([1, 2, 3, 4, 5], 3, 1))

# 4. zbir, koja kreira novu listu čiji su elementi zbirovi susednih elementa liste.


def zbir(l):
    n = []
    for i in range(len(l)-1):
        n.append(l[i]+l[i+1])
    return n


print(zbir([1, 2, 3, 4, 5]))


# 5. brojel, koja broji koliko elemenata ima svaka podlista liste koja joj je prosleđena. Ukoliko
# elemenat liste nije podlista funkcija vraća -1.
def brojel(*args):
    # return [len(x) if type(x) == list else -1 for x in list(args)]
    res = []
    for x in args:
        if type(x) == list:
            res.append(len(x))
        else:
            res.append(-1)
    return res


print(brojel([1, 2], [3, 4, 5], 'el', ['1', 1]))


# 6. razlika, koja prihvata dve liste (bilo kog tipa podataka), a ima povratnu vrednost koja je lista
# sastavljena od svih elemenata iz prve liste, koji se ne nalaze u drugoj listi.
def razlika(l1, l2):
    l = []
    for x in l1:
        if x not in l2:
            l.append(x)
    return l


print(razlika([1, 4, 6, "2", "6"], [4, 5, "2"]))


# 7. operacija, koja listu tuple vrednosti transformiše u listu brojeva, koji se dobijaju primenom
# operacije prosleđene putem argumenta.
def operacija(l, f):
    res = []
    for nums in l:
        if len(nums) > 1:
            acc = nums[0]
            for i in range(1, len(nums)):
                acc = f(acc, nums[i])
            res.append(acc)
    return res


print(operacija([(1, 4, 6), (2, 4), (4, 1)], lambda x, y: x + y))

# 8. izmeni, koja svaki n-ti element liste zamenjuje brojem koji predstavlja sumu svih elemenata
# originalne liste, od prvog, do n-tog elementa.


def izmeni(l):  # jedna je opcija da menja postojecu, a moze i da napravi novu (isto se radi)
    s = 0
    for i in range(len(l)):
        s += l[i]
        l[i] = s
    return l


print(izmeni([1, 2, 4, 7, 9]))

# 9. prosek, koja za svaki element prosleđene liste, koja se sastoji isključivo od podlisti, vraća
# aritmetičku sredinu svih njenih vrednosti.


def prosek(l):
    # return [sum(nums)/len(nums) for nums in l]
    res = []
    for nums in l:
        s = 0
        for x in nums:
            s += x
        res.append(s/len(nums))
    return res


print(prosek([[1, 4, 6, 2], [4, 6, 2, 7], [3, 5], [5, 6, 2, 7]]))


# 10.

def izbroj(l):
    if type(l) == int:
        return 1
    res = 0
    for x in l:
        res += izbroj(x)
    return res


print(izbroj([1, 2, [3, 4, [50, 6, [7, 8, 9, [10, 11], 12, 13], 14], 15, 16], 17]))


# 11. razlika, koja kreira novu listu čiji su elementi razlika susednih elementa liste
def razlika2(l):
    n = []
    for i in range(len(l)-1):
        n.append(l[i]-l[i+1])
    return n


print(razlika2([8, 5, 3, 1, 1]))


# 12. presek, koja prihvata dve liste (bilo kog tipa podataka), a ima povratnu vrednost koja je lista
# sastavljena od svih elemenata koji se nalaze u obe liste.
def presek(l1, l2):
    l = []
    for x in l1:
        if x in l2:
            l.append(x)
    return l


print(presek([5, 4, "1", "8", 3, 7], [1, 9, "1"]))


# 13. izmeni, koja kreira novu listu tako da elemente na parnim pozicijama uvećava za jedan, dok
# elemente na neparnim pozicijama umanjuje za 1.
def izmeni2(l):
    # return [l[i]+1 if i % 2 == 0 else l[i]-1 for i in range(len(l))]
    res = []
    for x in l:
        if x % 2 == 0:
            res.append(x+1)
        else:
            res.append(x-1)
    return res


print(izmeni2([8, 5, 3, 1, 1]))


# 14. unija, koja prihvata dve liste (bilo kog tipa podataka), a ima povratnu vrednost koja je lista
# sastavljena od svih elemenata obe liste bez ponavljanja.
def unija(l1, l2):
    l = l1[:]
    for x in l2:
        if x not in l:
            l.append(x)
    return l


print(unija([5, 4, "1", "8", 3, 7], [1, 9, "1"]))


# 15. izdvoji, koja iz zadate liste čiji su elementi liste, izdvaja n-ti element i formira rezultujuću listu, pri
# čemu je n=0 za prvu podlistu i uvećava se sukcesivno za 1. Ukoliko ne postoji n-ti element u listi
# vraća se 0.

def izdvoji2(*args):
    i = 0
    res = []
    for l in args:
        if type(l) == list and len(l) > i:
            res.append(l[i])
        else:
            res.append(0)
        i += 1
    return res


print(izdvoji2([5, 4, 4], [1, 9, 1], [5, 6], [4, 6, 10, 12]))


# 16.
def brojanje2(d):
    res = []
    temp = {}
    for x in d.values():
        if type(x).__name__ in temp:
            temp[type(x).__name__] += 1
        else:
            temp[type(x).__name__] = 1
    for x in temp.keys():
        res.append((x, temp[x]))
    return res


print(brojanje2({1: 4, 2: [2, 3], 3: [5, 6], 4: "test", 5: 9, 6: 8}))


# 17.
def kreiraj(n):
    x = 0
    i = 0
    res = []
    while i <= n:
        x += i
        res.append((i, x**2))
        i += 1
    return res


print(kreiraj(4))


# 18.
def kreiraj2(l):
    res = []
    for i in range(len(l)-1):
        temp = []
        for x in l[i]:
            if x not in l[i+1]:
                temp.append(x)
        res.append(temp)
    return res


print(kreiraj2([[1, 2, 3], [2, 4, 5], [4, 5, 6, 7], [1, 5]]))


# 19.
def stepenuj(l):
    res = []
    for nums in l:
        deg = nums[0]
        for x in nums[1:]:
            deg **= x
        res.append(deg)
    return res


print(stepenuj([(1, 2, 4), (2, 5, 1), (2, 2, 2, 2), (5,)]))


# 20.
def boje(c):
    r = int(c[1:3], 16)
    g = int(c[3:5], 16)
    b = int(c[5:], 16)
    res = {"Red": r, "Green": g, "Blue": b}
    return res


print(boje("#FA1AA0"))
