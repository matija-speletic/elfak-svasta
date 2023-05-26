import math


def entropija(skup):
    ukupno = len(skup)
    klasa_da = len(list(filter(lambda x: x["Planeta"] == "Da", skup)))
    klasa_ne = ukupno-klasa_da
    if klasa_da == ukupno or klasa_ne == ukupno:
        return 0
    elif klasa_da == klasa_ne:
        return 1
    else:
        return -(klasa_da/ukupno)*math.log(klasa_da/ukupno, 2) \
            - (klasa_ne/ukupno)*math.log(klasa_ne/ukupno, 2)


def korist(skup, atribut):
    # set da bi bile jedinstvene
    vrednosti = set(map(lambda x: x[atribut], skup))
    print(vrednosti)
    suma = 0
    for vr in vrednosti:
        # velicina podskupa koji ima datu vrednost za dati atribut
        podskup = list(filter(lambda x: x[atribut] == vr, skup))
        print(podskup)
        suma += entropija(podskup)*len(podskup)/len(skup)
    return entropija(skup)-suma


skup = [
    {"Udaljenost": "Mala", "Velicina": "Mala", "Planeta": "Da"},
    {"Udaljenost": "Velika", "Velicina": "Mala", "Planeta": "Ne"},
    {"Udaljenost": "Velika", "Velicina": "Velika", "Planeta": "Da"}
]

print(entropija(skup))
print(korist(skup, "Udaljenost"), korist(
    skup, "Velicina"), korist(skup, "Planeta"))


def MRV(domains):
    # dict koji preslikava cvor -> heuristika
    # return {node:len(domains[node]) for node in domains}
    h = {node: len(domains[node]) for node in domains}
    # promenljivu koju treba odabrati sledecu
    return min(h, key=lambda x: h[x])


domains = {
    "A": ["red", "green", "blue"],
    "B": ["red"],
    "C": ["green", "blue"]
}

print(MRV(domains))
