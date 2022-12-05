from collections import defaultdict
import random
import csv
import time

def nakljucni_graf(dolzina_max=10, utez_min=0, utez_max=6):
    dolzina = random.randint(0, dolzina_max)
    graf = {}
    for vozlisce in range(0, dolzina):
        povezave = {}
        povezave[vozlisce + 1] = random.randint(utez_min, utez_max)
        for y in range(vozlisce + 2, dolzina):
            povezava = random.randint(0,1)
            if povezava == 1:
                utez = random.randint(utez_min, utez_max)
                povezave[y] = utez
        graf[vozlisce] = povezave
    return graf

def nakljucni_graf_neutezen(dolzina_max=10):
    dolzina = dolzina_max
    graf = {}
    for vozlisce in range(0, dolzina):
        povezave = []
        for sosed in range(0, vozlisce):
            povezava = random.randint(0,1)
            if povezava == 1:
                povezave.append(sosed)
        for sosed in range(vozlisce+1, dolzina):
            povezava = random.randint(0,1)
            if povezava == 1:
                povezave.append(sosed)
        graf[vozlisce] = povezave
    return graf

def nasprotni_graf(graf):
    novi_graf = {}
    for vozlisce in graf:
        novi_sosedi = {}
        for sosed in graf[vozlisce]:
            novi_sosedi[sosed] = - graf[vozlisce][sosed]
        novi_graf[vozlisce] = novi_sosedi
    return novi_graf
        

def najkrajsa_pot(graf):
    oce = {}
    d = {}
    for vozlisce in graf:
        d[vozlisce] = float('inf')
        oce[vozlisce] = None
    d[0] = 0
    for vozlisce in range(1, len(graf)):
        for predhodnik in range(0, vozlisce):
            if vozlisce in graf[predhodnik].keys():
                kandidat = graf[predhodnik][vozlisce]
                if d[predhodnik] + kandidat < d[vozlisce]:
                    d[vozlisce] = d[predhodnik] + kandidat
                    oce[vozlisce] = predhodnik
    return d

def najdaljsa_pot(graf):
    dolzine = najkrajsa_pot(nasprotni_graf(graf))
    pozicija = list(dolzine.keys())[-1]
    najkrajsa = dolzine[pozicija]
    najdaljsa = - najkrajsa
    return najdaljsa

def dodaj_povezavo(G,u,v):
    G[u].append(v)

def DFS(G,v,obiskana=None, pot=None):
    if obiskana == None:
        obiskana = []
    if pot == None:
        pot = [v]
    obiskana.append(v)
    poti = []
    for vozlisce in G[v]:
        if vozlisce not in obiskana:
            vozlisce_poti = pot + [vozlisce]
            poti.append(tuple(vozlisce_poti))
            poti.extend(DFS(G, vozlisce, obiskana[:], vozlisce_poti))
    return poti

robovi = [['1', '2'], ['2', '4'], ['1', '11'], ['4', '11'],['11',"5"], ["5","7"], ["7", "4"], ["11","1"]]

G = defaultdict(list)
for (s,t) in robovi:
    G[s].append(t)
    G[t].append(s)

#vse_poti = [p for ps in [DFS(G, n) for n in set(G)] for p in ps]
#max_dolzina   = max(len(p) for p in vse_poti)
#max_poti = [p for p in vse_poti if len(p) == max_dolzina]

#print("Vse poti:")
#print(vse_poti)
#print("Najdaljše poti:")
#for p in max_poti: print("  ", p)
#print("Dolžina najdaljše poti:")
#print(max_dolzina)

def color_coding(G,K,n = 100): 
    ### G graf, n število ponovitev barvanj pri vsakem K, K največje število barv
    odgovor = 0
    for k in range(2,K+1): ###stevilo barv, ki jih preverjamo
        j = 0
        while j < n: ###da imamo n ponovitev za vsako število barv
            j +=1  
            barvanje = {}
            for v in G:
                barvanje[v] = random.randint(1,k) ###vsakemu vozlišču priredimo barvo (tukaj vsaka številka 1,...,k predstavlja vsako barvo)
            x = {}
            mnozice = [frozenset({j for j in range(1, k+1) if (i >> (j-1)) & 1 == 1}) for i in range(2**k)]
            mnozice = sorted([s for s in mnozice if len(s) > 1], key=len)

            for v in G:
                for i in range(1,k+1):
                    x[v,frozenset({i})] = barvanje[v] == i
            for C in mnozice:
                for v in G:
                    b = barvanje[v]
                    x[v, C] = b in C and any(x[u, C - {b}] for u in G[v])
                    #y |= x[v,C]
            if any(x[v,mnozice[-1]] for v in G):
                odgovor = k
    return odgovor

def stevilo_povezav(G):
    c = 0
    for el in G:
        c += len(G[el])
    return c

def simulacija(st_vozlisc,st_barv,st_grafov = 15, st_ponovitev = 20):
    datoteka = f"simulacija_{st_vozlisc}_{st_barv}_{st_ponovitev}.csv"
    with open(datoteka, "w") as f:
        writer = csv.writer(f)
        writer.writerow(["Število povezav", "Graf", "Dolžina najdaljše poti - Color coding", "Čas", "Dolžina najdaljše poti - DFS", "Čas"])
        for i in range(1, st_grafov+1):
            G = nakljucni_graf_neutezen(st_vozlisc)
            st_pov = stevilo_povezav(G)
            start1= time.time()
            dolzina1 = color_coding(G, st_barv, st_ponovitev)
            end1 = time.time()
            cas1 = end1 - start1
            start2 = time.time()
            vse_poti = [p for ps in [DFS(G, n) for n in set(G)] for p in ps]
            dolzina2   = max(len(p) for p in vse_poti)
            end2 = time.time()
            cas2 = end2 - start2
            writer.writerow([st_pov, G, dolzina1, cas1, dolzina2, cas2 ])
            f.flush()
 

#simulacija(5,9)
#simulacija(6,10)
#simulacija(7,10)
#simulacija(8,11)
#simulacija(9,12)
#simulacija(10,13)
#simulacija(11,14)
#simulacija(12,15)
#simulacija(13,16) 