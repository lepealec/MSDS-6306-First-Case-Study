---
title: "MSDS 6363 First Coure Project"
author: "Alec Lepe, Che Cobb, and Andrew Wilkins"
date: "10/08/2018"
output: 
  html_document:
    keep_md: true
---


### URL
https://github.com/lepealec/MSDS-6306-First-Case-Study.git

### Data description.


```r
library("data.table")
library("tidyverse")
```

```
## Warning: package 'dplyr' was built under R version 3.5.1
```

```r
library('ggplot2')
sessionInfo()
```

```
## R version 3.5.0 (2018-04-23)
## Platform: x86_64-apple-darwin15.6.0 (64-bit)
## Running under: macOS High Sierra 10.13.6
## 
## Matrix products: default
## BLAS: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRblas.0.dylib
## LAPACK: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRlapack.dylib
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] forcats_0.3.0     stringr_1.3.0     dplyr_0.7.6      
##  [4] purrr_0.2.5       readr_1.1.1       tidyr_0.8.1      
##  [7] tibble_1.4.2      ggplot2_2.2.1     tidyverse_1.2.1  
## [10] data.table_1.11.4
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.16     cellranger_1.1.0 pillar_1.2.2     compiler_3.5.0  
##  [5] plyr_1.8.4       bindr_0.1.1      tools_3.5.0      digest_0.6.15   
##  [9] lubridate_1.7.4  jsonlite_1.5     evaluate_0.11    nlme_3.1-137    
## [13] gtable_0.2.0     lattice_0.20-35  pkgconfig_2.0.2  rlang_0.2.0     
## [17] cli_1.0.0        rstudioapi_0.7   yaml_2.2.0       haven_1.1.2     
## [21] bindrcpp_0.2.2   xml2_1.2.0       httr_1.3.1       knitr_1.20      
## [25] hms_0.4.2        rprojroot_1.3-2  grid_3.5.0       tidyselect_0.2.4
## [29] glue_1.2.0       R6_2.2.2         readxl_1.1.0     rmarkdown_1.10  
## [33] modelr_0.1.2     magrittr_1.5     backports_1.1.2  scales_0.5.0    
## [37] htmltools_0.3.6  rvest_0.3.2      assertthat_0.2.0 colorspace_1.3-2
## [41] stringi_1.2.2    lazyeval_0.2.1   munsell_0.4.3    broom_0.5.0     
## [45] crayon_1.3.4
```

### Load and preview data

```r
setwd("~/MSDS-6306-First-Case-Study/Guidlines")
beers=fread("beers.csv")
beers
```

```
##                       Name Beer_ID   ABV IBU Brewery_id
##    1:             Pub Beer    1436 0.050  NA        409
##    2:          Devil's Cup    2265 0.066  NA        178
##    3:  Rise of the Phoenix    2264 0.071  NA        178
##    4:             Sinister    2263 0.090  NA        178
##    5:        Sex and Candy    2262 0.075  NA        178
##   ---                                                  
## 2406:            Belgorado     928 0.067  45        425
## 2407:        Rail Yard Ale     807 0.052  NA        425
## 2408:      B3K Black Lager     620 0.055  NA        425
## 2409:  Silverback Pale Ale     145 0.055  40        425
## 2410: Rail Yard Ale (2009)      84 0.052  NA        425
##                                Style Ounces
##    1:            American Pale Lager     12
##    2:        American Pale Ale (APA)     12
##    3:                   American IPA     12
##    4: American Double / Imperial IPA     12
##    5:                   American IPA     12
##   ---                                      
## 2406:                    Belgian IPA     12
## 2407:       American Amber / Red Ale     12
## 2408:                    Schwarzbier     12
## 2409:        American Pale Ale (APA)     12
## 2410:       American Amber / Red Ale     12
```

```r
str(beers)
```

```
## Classes 'data.table' and 'data.frame':	2410 obs. of  7 variables:
##  $ Name      : chr  "Pub Beer" "Devil's Cup" "Rise of the Phoenix" "Sinister" ...
##  $ Beer_ID   : int  1436 2265 2264 2263 2262 2261 2260 2259 2258 2131 ...
##  $ ABV       : num  0.05 0.066 0.071 0.09 0.075 0.077 0.045 0.065 0.055 0.086 ...
##  $ IBU       : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ Brewery_id: int  409 178 178 178 178 178 178 178 178 178 ...
##  $ Style     : chr  "American Pale Lager" "American Pale Ale (APA)" "American IPA" "American Double / Imperial IPA" ...
##  $ Ounces    : num  12 12 12 12 12 12 12 12 12 12 ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

```r
breweries=fread("breweries.csv")
breweries
```

```
##      Brew_ID                          Name          City State
##   1:       1             NorthGate Brewing   Minneapolis    MN
##   2:       2     Against the Grain Brewery    Louisville    KY
##   3:       3      Jack's Abby Craft Lagers    Framingham    MA
##   4:       4     Mike Hess Brewing Company     San Diego    CA
##   5:       5       Fort Point Beer Company San Francisco    CA
##  ---                                                          
## 554:     554           Covington Brewhouse     Covington    LA
## 555:     555               Dave's Brewfarm        Wilson    WI
## 556:     556         Ukiah Brewing Company         Ukiah    CA
## 557:     557       Butternuts Beer and Ale Garrattsville    NY
## 558:     558 Sleeping Lady Brewing Company     Anchorage    AK
```

```r
str(breweries)
```

```
## Classes 'data.table' and 'data.frame':	558 obs. of  4 variables:
##  $ Brew_ID: int  1 2 3 4 5 6 7 8 9 10 ...
##  $ Name   : chr  "NorthGate Brewing" "Against the Grain Brewery" "Jack's Abby Craft Lagers" "Mike Hess Brewing Company" ...
##  $ City   : chr  "Minneapolis" "Louisville" "Framingham" "San Diego" ...
##  $ State  : chr  "MN" "KY" "MA" "CA" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```


### How many breweries are the per state?
By state,

```r
ct_brew=table(breweries[["State"]])
ct_brew[sort(names(ct_brew))]
```

```
## 
## AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO 
##  7  3  2 11 39 47  8  1  2 15  7  4  5  5 18 22  3  4  5 23  7  9 32 12  9 
## MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV 
##  2  9 19  1  5  3  3  4  2 16 15  6 29 25  5  4  1  3 28  4 16 10 23 20  1 
## WY 
##  4
```



```r
breweries %>% ggplot(aes(x=State)) + geom_bar()+xlab("State")+ylab("Count") + 
  scale_y_continuous(name="Count", labels = scales::comma) +
  ggtitle("Brewery Count by State")+theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

![](Main_Project_files/figure-html/plot1-1.png)<!-- -->

```r
ct_brew[order(ct_brew)]
```

```
## 
## DC ND SD WV AR DE MS NV AL KS NH NJ TN HI KY NM SC UT WY IA ID LA NE RI OK 
##  1  1  1  1  2  2  2  2  3  3  3  3  3  4  4  4  4  4  4  5  5  5  5  5  6 
## AK GA MD CT ME MO MT VT AZ MN FL OH NY VA IL NC WI IN MA WA PA TX OR MI CA 
##  7  7  7  8  9  9  9 10 11 12 15 15 16 16 18 19 20 22 23 23 25 28 29 32 39 
## CO 
## 47
```

```r
breweries[order(breweries[["State"]]),]
```

```
##      Brew_ID                              Name      City State
##   1:     103       King Street Brewing Company Anchorage    AK
##   2:     224      Midnight Sun Brewing Company Anchorage    AK
##   3:     271           Alaskan Brewing Company    Juneau    AK
##   4:     454            Denali Brewing Company Talkeetna    AK
##   5:     459       Kenai River Brewing Company  Soldotna    AK
##  ---                                                          
## 554:     157 Greenbrier Valley Brewing Company Lewisburg    WV
## 555:      80       Black Tooth Brewing Company  Sheridan    WY
## 556:     192       Snake River Brewing Company   Jackson    WY
## 557:     458   The Black Tooth Brewing Company  Sheridan    WY
## 558:     551        Wind River Brewing Company  Pinedale    WY
```

```r
names(ct_brew[order(ct_brew)])
```

```
##  [1] "DC" "ND" "SD" "WV" "AR" "DE" "MS" "NV" "AL" "KS" "NH" "NJ" "TN" "HI"
## [15] "KY" "NM" "SC" "UT" "WY" "IA" "ID" "LA" "NE" "RI" "OK" "AK" "GA" "MD"
## [29] "CT" "ME" "MO" "MT" "VT" "AZ" "MN" "FL" "OH" "NY" "VA" "IL" "NC" "WI"
## [43] "IN" "MA" "WA" "PA" "TX" "OR" "MI" "CA" "CO"
```

```r
breweries %>% ggplot( aes(x=reorder(State,State,
                     function(x)-length(x)))) + geom_bar()+xlab("State")+ylab("Count") + 
  scale_y_continuous(name="Count", labels = scales::comma) +
  ggtitle("Brewery Count by State \nBy Rank")+theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

![](Main_Project_files/figure-html/breweries_per_state_by_rank-1.png)<!-- -->

Here we can see Colorado (CO), California (CA), and Michigan (MI) have the most breweries with 47, 39, and 32 breweries respectively.

Contrastly, Washington DC (DC), North Dakota (ND), South Dakota (SD), and West Virginia (WV) have the fewest breweries: 1 per state.


```r
nrow(breweries)
```

```
## [1] 558
```

There are a total of 558 breweries listed in the data set.


```r
colnames(breweries)[colnames(breweries)=="Brew_ID"]="Brewery_id"
colnames(breweries)[colnames(breweries)=="Name"]="Brewery_Name"
colnames(beers)[colnames(beers)=="Name"]="Beer_Name"
combined_data=merge(beers,breweries,by="Brewery_id")
nrow(breweries)
```

```
## [1] 558
```

```r
nrow(combined_data)==nrow(beers)
```

```
## [1] TRUE
```
First six observations

```r
head(combined_data)
```

```
##    Brewery_id     Beer_Name Beer_ID   ABV IBU
## 1:          1  Get Together    2692 0.045  50
## 2:          1 Maggie's Leap    2691 0.049  26
## 3:          1    Wall's End    2690 0.048  19
## 4:          1       Pumpion    2689 0.060  38
## 5:          1    Stronghold    2688 0.060  25
## 6:          1   Parapet ESB    2687 0.056  47
##                                  Style Ounces      Brewery_Name
## 1:                        American IPA     16 NorthGate Brewing
## 2:                  Milk / Sweet Stout     16 NorthGate Brewing
## 3:                   English Brown Ale     16 NorthGate Brewing
## 4:                         Pumpkin Ale     16 NorthGate Brewing
## 5:                     American Porter     16 NorthGate Brewing
## 6: Extra Special / Strong Bitter (ESB)     16 NorthGate Brewing
##           City State
## 1: Minneapolis    MN
## 2: Minneapolis    MN
## 3: Minneapolis    MN
## 4: Minneapolis    MN
## 5: Minneapolis    MN
## 6: Minneapolis    MN
```
Last six observations

```r
tail(combined_data)
```

```
##    Brewery_id                 Beer_Name Beer_ID   ABV IBU
## 1:        556             Pilsner Ukiah      98 0.055  NA
## 2:        557  Heinnieweisse Weissebier      52 0.049  NA
## 3:        557           Snapperhead IPA      51 0.068  NA
## 4:        557         Moo Thunder Stout      50 0.049  NA
## 5:        557         Porkslap Pale Ale      49 0.043  NA
## 6:        558 Urban Wilderness Pale Ale      30 0.049  NA
##                      Style Ounces                  Brewery_Name
## 1:         German Pilsener     12         Ukiah Brewing Company
## 2:              Hefeweizen     12       Butternuts Beer and Ale
## 3:            American IPA     12       Butternuts Beer and Ale
## 4:      Milk / Sweet Stout     12       Butternuts Beer and Ale
## 5: American Pale Ale (APA)     12       Butternuts Beer and Ale
## 6:        English Pale Ale     12 Sleeping Lady Brewing Company
##             City State
## 1:         Ukiah    CA
## 2: Garrattsville    NY
## 3: Garrattsville    NY
## 4: Garrattsville    NY
## 5: Garrattsville    NY
## 6:     Anchorage    AK
```
Sum of NA's per column

```r
apply(combined_data,2,function(x) sum(is.na(x)))
```

```
##   Brewery_id    Beer_Name      Beer_ID          ABV          IBU 
##            0            0            0           62         1005 
##        Style       Ounces Brewery_Name         City        State 
##            0            0            0            0            0
```


```r
abv=combined_data[,median(na.omit(as.numeric(ABV))),State]
ibu=combined_data[,median(na.omit(as.numeric(IBU))),State]
colnames(abv)[2]="ABV"
colnames(ibu)[2]="IBU"
meds=merge(ibu,abv,by="State")
meds
```

```
##     State  IBU    ABV
##  1:    AK 46.0 0.0560
##  2:    AL 43.0 0.0600
##  3:    AR 39.0 0.0520
##  4:    AZ 20.5 0.0550
##  5:    CA 42.0 0.0580
##  6:    CO 40.0 0.0605
##  7:    CT 29.0 0.0600
##  8:    DC 47.5 0.0625
##  9:    DE 52.0 0.0550
## 10:    FL 55.0 0.0570
## 11:    GA 55.0 0.0550
## 12:    HI 22.5 0.0540
## 13:    IA 26.0 0.0555
## 14:    ID 39.0 0.0565
## 15:    IL 30.0 0.0580
## 16:    IN 33.0 0.0580
## 17:    KS 20.0 0.0500
## 18:    KY 31.5 0.0625
## 19:    LA 31.5 0.0520
## 20:    MA 35.0 0.0540
## 21:    MD 29.0 0.0580
## 22:    ME 61.0 0.0510
## 23:    MI 35.0 0.0620
## 24:    MN 44.5 0.0560
## 25:    MO 24.0 0.0520
## 26:    MS 45.0 0.0580
## 27:    MT 40.0 0.0550
## 28:    NC 33.5 0.0570
## 29:    ND 32.0 0.0500
## 30:    NE 35.0 0.0560
## 31:    NH 48.5 0.0550
## 32:    NJ 34.5 0.0460
## 33:    NM 51.0 0.0620
## 34:    NV 41.0 0.0600
## 35:    NY 47.0 0.0550
## 36:    OH 40.0 0.0580
## 37:    OK 35.0 0.0600
## 38:    OR 40.0 0.0560
## 39:    PA 30.0 0.0570
## 40:    RI 24.0 0.0550
## 41:    SC 30.0 0.0550
## 42:    SD   NA 0.0600
## 43:    TN 37.0 0.0570
## 44:    TX 33.0 0.0550
## 45:    UT 34.0 0.0400
## 46:    VA 42.0 0.0565
## 47:    VT 30.0 0.0550
## 48:    WA 38.0 0.0555
## 49:    WI 19.0 0.0520
## 50:    WV 57.5 0.0620
## 51:    WY 21.0 0.0500
##     State  IBU    ABV
```

```r
str(meds)
```

```
## Classes 'data.table' and 'data.frame':	51 obs. of  3 variables:
##  $ State: chr  "AK" "AL" "AR" "AZ" ...
##  $ IBU  : num  46 43 39 20.5 42 40 29 47.5 52 55 ...
##  $ ABV  : num  0.056 0.06 0.052 0.055 0.058 0.0605 0.06 0.0625 0.055 0.057 ...
##  - attr(*, ".internal.selfref")=<externalptr> 
##  - attr(*, "sorted")= chr "State"
```

Median IBU per State Plot

```r
ggplot(meds,aes(reorder(meds$State,-meds$IBU), y = meds$IBU))+geom_bar(stat = "identity")+labs(x = "State" , y = "IBU") + 
  ggtitle("Median IBU per State")+theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

```
## Warning: Removed 1 rows containing missing values (position_stack).
```

![](Main_Project_files/figure-html/IBU_Plot-1.png)<!-- -->
Median ABV per State Plot

```r
ggplot(meds,aes(reorder(meds$State,-meds$ABV), y = meds$ABV))+geom_bar(stat = "identity")+labs(x = "State" , y = "IBU") + 
  ggtitle("Median ABV per State")+theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

![](Main_Project_files/figure-html/ABV_plot-1.png)<!-- -->


MAX ABV

```r
combined_data[which.max(ABV),]
```

```
##    Brewery_id                                            Beer_Name Beer_ID
## 1:         52 Lee Hill Series Vol. 5 - Belgian Style Quadrupel Ale    2565
##      ABV IBU            Style Ounces            Brewery_Name    City State
## 1: 0.128  NA Quadrupel (Quad)   19.2 Upslope Brewing Company Boulder    CO
```

Max IBU

```r
combined_data[which.max(IBU),]
```

```
##    Brewery_id                 Beer_Name Beer_ID   ABV IBU
## 1:        375 Bitter Bitch Imperial IPA     980 0.082 138
##                             Style Ounces            Brewery_Name    City
## 1: American Double / Imperial IPA     12 Astoria Brewing Company Astoria
##    State
## 1:    OR
```


```r
sum_abv=summary(combined_data[["ABV"]])
sum_abv
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
## 0.00100 0.05000 0.05600 0.05977 0.06700 0.12800      62
```

```r
boxplot(combined_data[["ABV"]],main='ABV Barplot',ylab="ABV")
```

![](Main_Project_files/figure-html/summary ABV-1.png)<!-- -->


```r
ggplot(combined_data,aes(x = ABV,y = IBU ))+geom_point(na.rm=TRUE)+geom_smooth(method=lm,se=FALSE, na.rm=TRUE)+
  ggtitle("IBU vs ABV content per Alcohol")
```

![](Main_Project_files/figure-html/correl_graph-1.png)<!-- -->

```r
cor(na.omit(combined_data)[["ABV"]],na.omit(combined_data)[["IBU"]])
```

```
## [1] 0.6706215
```


