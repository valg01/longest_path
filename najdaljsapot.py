from collections import defaultdict

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

vse_poti = [p for ps in [DFS(G, n) for n in set(G)] for p in ps]
max_dolzina   = max(len(p) for p in vse_poti)
max_poti = [p for p in vse_poti if len(p) == max_dolzina]

print("Vse poti:")
print(vse_poti)
print("Najdaljše poti:")
for p in max_poti: print("  ", p)
print("Dolžina najdaljše poti:")
print(max_dolzina)
