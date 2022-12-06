library(readr)
library(glue)

#tuki mors pot spremenit valda 

tabela <- read.csv('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_st_ponovitev_8_11_1000_20.csv')
st_povezav <- tabela[1,1]
tabela <- tabela[c(3,4,5)]
sedmice <- tabela[(tabela[, 2] == 7), ]
osmice <- tabela[(tabela[, 2] == 8), ]
sestice <- tabela[(tabela[, 2] == 6), ]
plot(osmice[, 1], osmice[, 3],
     xlab = 'Število ponovitev',
     ylab = 'Čas v sekundah',
     xlim = c(0, 1000),
     ylim = c(0, 75),
     col = 'red',
     pch = 16,
     main = "Čas izvajanja algoritma color coding v odvisnosti od ponovitev")
points(sedmice[, 1], sedmice[, 3], col = 'blue', pch = 16)
points(tabela[1, 1], tabela[1, 3], col = 'green', pch = 16)
points(sestice[, 1], sestice[, 3], col = 'yellow', pch = 16)

legend(x = "topleft",
       title="Dolžina najdaljše poti",
       legend=c("3", "6", '7', '8'), 
       fill = c("green", "yellow", 'blue', 'red'),
       cex = 0.8)

length(tabela[,1]) == 1+ length(osmice[, 1]) + length(sedmice[, 1]) + length(sestice[, 1])


#______drugi del______

povprecje <- c()
povprecje_DFS <- c()
for (x in 5:13){
  if (x < 7){
    tabela1 <- read.csv(glue('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_{x}_{x+4}_20.csv'))
    delcek <- c(mean(tabela1[, 4] / tabela1[, 1]), x)
    povprecje <- rbind(povprecje, delcek)
    delcek_DFS <- c(mean(tabela1[, 6] / tabela1[, 1]), x)
    povprecje_DFS <- rbind(povprecje_DFS, delcek_DFS) 
  } else{
    tabela1 <- read.csv(glue('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_{x}_{x+3}_20.csv'))
    delcek <- c(mean(tabela1[, 4] / tabela1[, 1]), x)
    povprecje <- rbind(povprecje, delcek)
    delcek_DFS <- c(mean(tabela1[, 6] / tabela1[, 1]), x)
    povprecje_DFS <- rbind(povprecje_DFS, delcek_DFS) 
  }
}

plot(povprecje[, 2], povprecje[, 1],
     main = 'Povprečen čas izvajanja algoritma na povezavo glede na število vozlišč',
     xlab = 'Število vozlišč',
     ylab = 'Čas v sekundah',
     type = 'b',
     col = "blue",
     pch = 16)
lines(povprecje[,2], povprecje_DFS[,1],
     type = "b",
     col="orange")
legend("topleft",
       title= "Algoritem",
       legend = c("Color coding", "DFS"),
       fill=c("blue","orange")
)

povprecje2 <- c()
povprecje_DFS2 <- c()
povprecje3 <- c()
povprecje_DFS3 <- c()
for (x in 5:13){
  if (x < 7){
    tabela2 <- read.csv(glue('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_{x}_{x+4}_20.csv'))
    delcek2 <- c(mean(tabela2[, 4]), x)
    delcek3 <- c(mean(tabela2[,3]),x)
    povprecje2 <- rbind(povprecje2, delcek2)
    povprecje3 <- rbind(povprecje3,delcek3)
    delcek_DFS2 <- c(mean(tabela2[, 6]), x)
    delcek_DFS3 <- c(mean(tabela2[,5]),x)
    povprecje_DFS2 <- rbind(povprecje_DFS2, delcek_DFS2) 
    povprecje_DFS3 <- rbind(povprecje_DFS3, delcek_DFS3)
  } else{
    tabela2 <- read.csv(glue('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_{x}_{x+3}_20.csv'))
    delcek2 <- c(mean(tabela2[, 4]), x)
    delcek3 <- c(mean(tabela2[,3]),x)
    povprecje2 <- rbind(povprecje2, delcek2)
    povprecje3 <- rbind(povprecje3,delcek3)
    delcek_DFS2 <- c(mean(tabela2[, 6]), x)
    delcek_DFS3 <- c(mean(tabela2[,5]),x)
    povprecje_DFS2 <- rbind(povprecje_DFS2, delcek_DFS2) 
    povprecje_DFS3 <- rbind(povprecje_DFS3, delcek_DFS3)
  }
}

plot(povprecje2[, 2], povprecje2[, 1],
     main = 'Povprečen čas izvajanja algoritma glede na število vozlišč',
     xlab = 'Število vozlišč',
     ylab = 'Čas v sekundah',
     type = 'b',
     col = "blue",
     pch = 16)
lines(povprecje2[,2], povprecje_DFS2[,1],
      type = "b",
      col = "orange")
legend(x = "topleft",
       title ="Algoritem",
       legend = c("Color coding", "DFS"),
       fill= c("blue","orange"))

plot(povprecje3[, 2], povprecje3[, 1],
     main = 'Povprečen rezultat algoritma glede na število vozlišč',
     xlab = 'Število vozlišč',
     ylab = 'Čas v sekundah',
     type = 'b',
     col = "blue",
     ylim = c(4,13.5),
     pch = 16)
lines(povprecje3[,2], povprecje_DFS3[,1],
      type = "b",
      col = "orange")
legend(x = "topleft",
       title ="Algoritem",
       legend = c("Color coding", "DFS"),
       fill= c("blue","orange"))

#______tretji del______



tabela5 <- read.csv('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_30_-2_2.csv')
tabela5 <- tabela5[,c(1,2,3,6)]
tabela6 <- read.csv('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_30_1_1.csv')
tabela6 <- tabela6[,c(1,2,3,6)]
tabela7 <- read.csv('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_100_-7_7.csv')
tabela7 <- tabela7[,c(1,2,3,6)]


povprecje_utezi <- c()
for (x in c(7,14,21,28,35,42)){
  tabela1 <- read.csv(glue('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_100_1_{x}.csv'))
  delcek <- c(mean(tabela1[, 6] / tabela1[, 1]), x)
  povprecje_utezi <- rbind(povprecje_utezi, delcek)
}
povprecje_utezi


plot(povprecje_utezi[, 2], povprecje_utezi[, 1],
     main = 'Povp. čas za eno povezavo glede na razpon uteži',
     xlab = 'razpon utezi',
     ylab = 'cas v sekundah',
     type = 'b',
     pch = 16)


povprecje_vozlisc <- c()
for (x in c(100,200,300,400)){
  tabela1 <- read.csv(glue('~/Desktop/financna_matematika/3. letnik/financni praktikum/projekt/longest_path/simulacija_{x}_1_7.csv'))
  delcek <- c(mean(tabela1[, 6] / tabela1[, 1]), x)
  povprecje_vozlisc <- rbind(povprecje_vozlisc, delcek)
}
povprecje_vozlisc

plot(povprecje_vozlisc[, 2], povprecje_vozlisc[, 1],
     main = 'Povp. čas za eno povezavo glede na stevilo vozlisc',
     xlab = 'stevilo vozlisc',
     ylab = 'cas v sekundah',
     type = 'b',
     pch = 16)
read






