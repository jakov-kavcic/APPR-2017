# Analiza Evropske proizvodnje in porabe energije

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Tematika

Energija je ena od najpomembnejših surovin za vsako državo ali družbo. V zadnjih letih lahko opazimo več}jo valitilnost na energetskih trgih zaradi številnih ekonomskih, tehnoloških in geopolitičnih razlogov. Zaradi tega je zelo pomembno, da analiziramo pretekle spremembe v potroŠnji in porabi energije, saj le tako lahko predvidimo kakŠna bo naŠa potreba po energiji v prihodnosti. Med pripravo svojega projekta se bom osredotoČil na energetsko neodvisnost Evrope, saj je to zelo dober pokazatelj situacije. Vendar pred tem bom povzel dinamiko energetske porabe v Evropi in v določenih državah, v katerih je produkcija ali uvoz energije višja od povprečja. Večje skoke ali upade v porabi bom poskusil povezati z svetovnimi dogodki, saj le to nam bo dalo najboljše orodje za napoved dinamike v prihodnje. Zaradi pomanjkanja podatkov se bom osredotočil na obdobje med 1990 in 2015. 

## Podatki

Podatke, ki jih bom uporabil pri ustvarjanju svojega projekta bom pridobil s spletne strani EUROSTAT. Poleg tega bom po potrebi poiskal bolj specifične podatke na energetskem portalu Wikipedije. Oba vira mi bosta omogočila, da črpam neobdelane podatke ali v csv obliki ali v HTML obliki. 

Podatke bom pridobil na spletnih stranieh:

- [Poenostavljena letna bilanca](http://appsso.eurostat.ec.europa.eu/nui/show.do?query=BOOKMARK_DS-053524_QID_4739B558_UID_-3F171EB0&layout=GEO,L,X,0;TIME,C,Y,0;UNIT,L,Z,0;PRODUCT,L,Z,1;INDIC_NRG,L,Z,2;INDICATORS,C,Z,3;&zSelection=DS-053524INDIC_NRG,B_100900;DS-053524INDICATORS,OBS_FLAG;DS-053524PRODUCT,0000;DS-053524UNIT,TJ;&rankName1=UNIT_1_2_-1_2&rankName2=INDICATORS_1_2_-1_2&rankName3=PRODUCT_1_2_-1_2&rankName4=INDIC-NRG_1_2_-1_2&rankName5=GEO_1_2_0_0&rankName6=TIME_1_0_0_1&sortR=ASC_-1_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=false&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%23)

- [Uvoz energetskih produktov na letni ravni](http://appsso.eurostat.ec.europa.eu/nui/show.do?query=BOOKMARK_DS-053542_QID_15722ADD_UID_-3F171EB0&layout=TIME,C,X,0;GEO,L,Y,0;UNIT,L,Z,0;PRODUCT,L,Z,1;PARTNER,L,Z,2;INDICATORS,C,Z,3;&zSelection=DS-053542INDICATORS,OBS_FLAG;DS-053542UNIT,KTOE;DS-053542PARTNER,BE;DS-053542PRODUCT,0000;&rankName1=PARTNER_1_2_-1_2&rankName2=TIME_1_0_0_0&rankName3=UNIT_1_2_-1_2&rankName4=GEO_1_2_0_1&rankName5=INDICATORS_1_2_-1_2&rankName6=PRODUCT_1_2_-1_2&sortC=ASC_-1_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=false&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%23)
 
- [Izvoz energetskih produktov na letni ravni](http://appsso.eurostat.ec.europa.eu/nui/show.do?query=BOOKMARK_DS-053546_QID_-366C96A2_UID_-3F171EB0&layout=TIME,C,X,0;GEO,L,Y,0;UNIT,L,Z,0;PRODUCT,L,Z,1;PARTNER,L,Z,2;INDICATORS,C,Z,3;&zSelection=DS-053546INDICATORS,OBS_FLAG;DS-053546UNIT,KTOE;DS-053546PARTNER,BE;DS-053546PRODUCT,0000;&rankName1=PARTNER_1_2_-1_2&rankName2=TIME_1_0_0_0&rankName3=UNIT_1_2_-1_2&rankName4=GEO_1_2_0_1&rankName5=INDICATORS_1_2_-1_2&rankName6=PRODUCT_1_2_-1_2&sortC=ASC_-1_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=false&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%23)
 
- [Poraba glede na produkt](http://ec.europa.eu/eurostat/tgm/table.do?tab=table&tableSelection=1&labeling=labels&footnotes=yes&layout=cat,geo,time&language=en&pcode=ten00095&plugin=1
SVG or JavaScript disabled mode: http://ec.europa.eu/eurostat/tgm/table.do?tab=table&tableSelection=1&labeling=labels&footnotes=yes&layout=cat,geo,time&language=en&pcode=ten00095&plugin=0)

- [Energetski portal Wikipedije](https://en.wikipedia.org/wiki/Portal:Energy/Explore)

## Oblika tabel

Tabela "Poenostavljena letna bilanca" bo vsebovala naslednje stolpce:

- Država

- Leto

- Poraba v ekvivalentnii količini olja

Tabela "Izvoz in uvoz energetskih produktov na letni ravni" bo vsebovala naslednje stolpce:

- Država

- Leto

- Izvožena energija v ekvivalentnii količini olja

- Uvožena energija v ekvivalentnii količini olja

Tabela "Poraba glede na produkt" bo vsebovala naslednje stolpce:

- Država

- Leto

- Poraba trdih goriv

- Poraba Benzina in dizela 

- Poraba LPG

- Poraba letalskega benzina

- Poraba drugega kerosina

- Poraba kerosina za letala

- Poraba petroleja

- Poraba naravnega plina

- Poraba elektrike



## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in \UTF{010D}i\UTF{0161}\UTF{010D}enje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poro\UTF{010D}ila
* `rmarkdown` - za prevajanje poro\UTF{010D}ila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgo\UTF{0161}\UTF{010D}evalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (\UTF{010D}i\UTF{0161}\UTF{010D}enje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz \UTF{0161}umnikov (neobvezno)
