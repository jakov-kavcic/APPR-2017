# Analiza Evropske proizvodnje in porabe energije

Repozitorij z gradivi pri predmetu APPR v \UTF{0161}tudijskem letu 2016/17

## Tematika

Energija je ena od najpomembnej\UTF{0161}ih surovin za vsako dr\UTF{017E}avo ali dru\UTF{017E}bo. V zadnjih letih lahko opazimo ve\UTF{010D}jo valitilnost na energetskih trgih zaradi \UTF{0161}tevilnih ekonomskih, tehnolo\UTF{0161}kih in geopoliti\UTF{010D}nih razlogov. Zaradi tega je zelo pomembno, da analiziramo pretekle spremembe v potro\UTF{0161}nji in porabi energije, saj le tako lahko predvidimo kak\UTF{0161}na bo na\UTF{0161}a potreba po energiji v prihodnosti. Med pripravo svojega projekta se bom osredoto\UTF{010D}il na energetsko neodvisnost Evrope, saj je to zelo dober pokazatelj situacije. Vendar pred tem bom povzel dinamiko energetske porabe v Evropi in v dolo\UTF{010D}enih dr\UTF{017E}avah, v katerih je produkcija ali uvoz energije vi\UTF{0161}ja od povpre\UTF{010D}ja. Ve\UTF{010D}je skoke ali upade v porabi bom poskusil povezati z svetovnimi dogodki, saj le to nam bo dalo najbolj\UTF{0161}e orodje za napoved dinamike v prihodnje. Zaradi pomanjkanja podatkov se bom osredoto\UTF{010D}il na obdobje med 1990 in 2015. 

## Podatki

Podatke, ki jih bom uporabil pri ustvarjanju svojega projekta bom pridobil s spletne strani EUROSTAT. Poleg tega bom po potrebi poiskal bolj specifi\UTF{010D}ne podatke na energetskem portalu Wikipedije. Oba vira mi bosta omogo\UTF{010D}ila, da \UTF{010D}rpam neobdelane podatke ali v csv obliki ali v HTML obliki. 

Podatke bom pridobil na spletnih stranieh:
 - \href{http://appsso.eurostat.ec.europa.eu/nui/show.do?query=BOOKMARK_DS-053524_QID_4739B558_UID_-3F171EB0&layout=GEO,L,X,0;TIME,C,Y,0;UNIT,L,Z,0;PRODUCT,L,Z,1;INDIC_NRG,L,Z,2;INDICATORS,C,Z,3;&zSelection=DS-053524INDIC_NRG,B_100900;DS-053524INDICATORS,OBS_FLAG;DS-053524PRODUCT,0000;DS-053524UNIT,TJ;&rankName1=UNIT_1_2_-1_2&rankName2=INDICATORS_1_2_-1_2&rankName3=PRODUCT_1_2_-1_2&rankName4=INDIC-NRG_1_2_-1_2&rankName5=GEO_1_2_0_0&rankName6=TIME_1_0_0_1&sortR=ASC_-1_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=false&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%23}{Poenostavljena letna bilanca}
 - \href{http://appsso.eurostat.ec.europa.eu/nui/show.do?query=BOOKMARK_DS-053542_QID_15722ADD_UID_-3F171EB0&layout=TIME,C,X,0;GEO,L,Y,0;UNIT,L,Z,0;PRODUCT,L,Z,1;PARTNER,L,Z,2;INDICATORS,C,Z,3;&zSelection=DS-053542INDICATORS,OBS_FLAG;DS-053542UNIT,KTOE;DS-053542PARTNER,BE;DS-053542PRODUCT,0000;&rankName1=PARTNER_1_2_-1_2&rankName2=TIME_1_0_0_0&rankName3=UNIT_1_2_-1_2&rankName4=GEO_1_2_0_1&rankName5=INDICATORS_1_2_-1_2&rankName6=PRODUCT_1_2_-1_2&sortC=ASC_-1_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=false&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%23}{Uvoz energetskih produktov na letni ravni}
 - \href{http://appsso.eurostat.ec.europa.eu/nui/show.do?query=BOOKMARK_DS-053546_QID_-366C96A2_UID_-3F171EB0&layout=TIME,C,X,0;GEO,L,Y,0;UNIT,L,Z,0;PRODUCT,L,Z,1;PARTNER,L,Z,2;INDICATORS,C,Z,3;&zSelection=DS-053546INDICATORS,OBS_FLAG;DS-053546UNIT,KTOE;DS-053546PARTNER,BE;DS-053546PRODUCT,0000;&rankName1=PARTNER_1_2_-1_2&rankName2=TIME_1_0_0_0&rankName3=UNIT_1_2_-1_2&rankName4=GEO_1_2_0_1&rankName5=INDICATORS_1_2_-1_2&rankName6=PRODUCT_1_2_-1_2&sortC=ASC_-1_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=false&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%23}{Izvoz energetskih produktov na letni ravni}
 - \href{https://en.wikipedia.org/wiki/Portal:Energy/Explore}{Energetski portal Wikipedije}

## Program

Glavni program in poro\UTF{010D}ilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in \UTF{010D}etrti fazi projekta:

* obdelava, uvoz in \UTF{010D}i\UTF{0161}\UTF{010D}enje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti slede\UTF{010D}e pakete za R:

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
