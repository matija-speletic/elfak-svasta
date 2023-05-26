from itertools import zip_longest


def spoji(lista1,lista2):
    dopuna=[1 for _ in range(abs(len(lista1)-len(lista2)))]
    if len(lista1)<len(lista2):
        lista1+=dopuna
    elif len(lista2)<len(lista1):
        lista2+=dopuna

    return [(lista1[i],lista2[i],lista1[i]*lista2[i]) for i in range(len(lista1))]

def spoji_iq700(l1,l2):
    return list(map(lambda x:(x[0],x[1],x[0]*x[1]),zip_longest(l1,l2,fillvalue=1)))


l1=[2,6,3,2,4]
l2=[9,3,4,1,6,7,3,2]
print(spoji(l1,l2))
print(spoji_iq700(l1,l2))


# kako drugi