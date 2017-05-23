# Analiza Evropske proizvodnje in porabe energije

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2016/17

## Obdelava, uvoz in čiščenje podatkov

Podatke, ki sem jih uporabil pri ustvarjanju svojega projekta sem pridobil s spletne strani EUROSTAT. Poleg tega sem določene podatke posikal na Wikipediji. Oba vira mi bosta omogočila, da črpam neobdelane podatke ali v csv obliki ali v HTML obliki. 

Podatke bom pridobil na spletnih stranieh:

- [Letna bilanca enrgije](http://appsso.eurostat.ec.europa.eu/nui/show.do?query=BOOKMARK_DS-465368_QID_-1E68FBF1_UID_-3F171EB0&layout=TIME,C,X,0;GEO,L,Y,0;UNIT,L,Z,0;PRODUCT,L,Z,1;INDIC_NRG,L,Z,2;INDICATORS,C,Z,3;&zSelection=DS-465368PRODUCT,0000;DS-465368UNIT,KTOE;DS-465368INDIC_NRG,B_100900;DS-465368INDICATORS,OBS_FLAG;&rankName1=UNIT_1_2_-1_2&rankName2=INDICATORS_1_2_-1_2&rankName3=PRODUCT_1_2_-1_2&rankName4=INDIC-NRG_1_2_-1_2&rankName5=TIME_1_0_0_0&rankName6=GEO_1_2_0_1&sortC=ASC_-1_FIRST&rStp=&cStp=&rDCh=&cDCh=&rDM=true&cDM=true&footnes=false&empty=false&wai=false&time_mode=ROLLING&time_most_recent=false&lang=EN&cfo=%23%23%23%2C%23%23%23.%23%23%23)

- [Populacija evropskih držav](https://en.wikipedia.org/wiki/Demographics_of_Europe)

- [Kode držav po standardu ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)

Uvozil sem podatke s EUROSTAT-a v obliki CSV ter v obliki HTML z Wikipedije. Poglejmo si začetke uvoženih razpredelnic.

## Oblika tabel

Tabela **all_products** vsebuje naslednje stolpce:

- **TIME** - leto *(Npr. 2000)*,

- **GEO** - država *(Npr. Slovenia)*,

- **PRODUCT** - vrsta energetske surovine *(Npr. Gas)*,

- **INDIC_NRG** - določa količino uvoza, izvoza in porabe *(Npr. Exports)* in

- **Value** - količina energije izražene v terajoulih.

Tabela **ak** vsebuje dva stolpca:

- **GEO** - država in

- **Koda** - kode držav po standardu ISO 3166-2.

Tabela **po** vsebuje dva stolpca:

- **GEO** - država in

- **Populacija** - populacija posamezne države.


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
