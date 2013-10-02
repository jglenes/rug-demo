R: Not just for pirates (anymore)
========================================================
author: Joshua Guy Lenes
date: 1 October 2013
font-import: http://fonts.googleapis.com/css?family=PT+Sans
font-family: "PT Sans"
transition: rotate




Okay, but really. Why R?
========================================================
incremental: true

- It's **Free** (as in beer, and in speech)
- It has an incredible **package** repository
- It's a real, all-grown-up, modern, **object-oriented**, high-level computer language.

It's Free
========================================================
type: sub-section

## Really, actually, completely *free*.

- No license renewal periods (*Nighmares!*)
- No upgrade fees
- No cost for additional features (`install.packages`)
- Awesome and free ***development*** tools

Josh, your development environment is so slick
========================================================
incremental: true

**Thanks, Bro.**

You can have a slick development environment, too.

Sweetness. What do I do?
========================================================
incremental: true

* Download `R` (duh): [http://cran.r-project.org/](http://cran.r-project.org/), then:
* Download `RStudio` (duh): [http://www.rstudio.com/](http://www.rstudio.com/)

## What's the difference?

* **R** is just a library. It has all of the files your computer needs to *understand* and execute R code
* **RStudio** is an IDE (Integrated Development Environment) that helps you write code in R more easily

Packages Kick Ass
========================================================
incremental: true
type: sub-section

* There are over **5000** are available on `CRAN` (Comprehensive R Archive Network)
* Developed and maintained by super-smart people who are not me.  
* Some examples:
  * `lme4`: Multilevel modeling
  * `metafor`: Meta-analysis
  * `lavaan`: Latent variable analysis (SEM)

It's Object-Oriented
========================================================
transition: rotate
type: sub-section

## Wait, WTF does object-oriented mean?

Everything in R is an *object*, which is an instance of a *class*. Even variables are objects.

**Objects** have:
* Properties
* Methods  

Demo
========================================================

## Grab the demo files:
<span style="text-align: center">**[https://github.com/jglenes/rug-demo](https://github.com/jglenes/rug-demo)**</span>


Classroom Data
========================================================
incremental: true


```r
# Interpreting SPSS Files
install.packages("foreign")
library("foreign")
```



```r
# Reading the data to a data.frame R object
firstday.data <- read.spss(
  file="SOP4004.Questionnaire.sav",
  use.value.labels=T,
  to.data.frame=T # We want this
)
```


Classroom Data
========================================================
incremental: true

What are our variables called?


```r
names(firstday.data)
```

```
 [1] "Condition"           "Underwear"           "PercentageUnderwear"
 [4] "MRiver"              "MLength"             "GetAlong"           
 [7] "Cereal"              "Coin"                "Grade"              
[10] "PercGrade"           "Driving"             "Treatment"          
[13] "TV"                  "Gender"             
```


In *RStudio* you can use `View(firstday.data)`

Classroom Data
========================================================
incremental: true

1. If Josh were to give you $500 to stand in front of the class in your underwear, would you do it?
2. Estimate the percentage of your peers who would agree to stand in front of the class in their underwear


```r
head(firstday.data[2:3]) # That's our data.frame object, being called by head()
```

```
  Underwear PercentageUnderwear
1        No                  48
2        No                  30
3        No                  30
4        No                  30
5        No                   1
6        No                   1
```


Classroom Data
========================================================
incremental: true
type: prompt

Instead of calling it like this:

`head(firstday.data[2:3])`

I could have just as easily done this:

`head(firstday.data[,c("Underwear","PercentageUnderwear")])`

Or this:

`firstday.data[1:5,c("Underwear","PercentageUnderwear")]`

ANOV(ugh)
========================================================
incremental: true
type: sub-section


```r
underwear.aov <- aov(PercentageUnderwear ~ Underwear,data=firstday.data)
```



```r
summary(underwear.aov)
```

```
            Df Sum Sq Mean Sq F value  Pr(>F)    
Underwear    1   6009    6009    12.3 0.00081 ***
Residuals   64  31131     486                    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
1 observation deleted due to missingness
```


ANOV(ugh): Summary Table of Means
========================================================
incremental: true
type: sub-section


```r
library(plyr)

# Make a new dataframe with means
firstday.data.summary <- ddply(na.omit(firstday.data), .(Underwear), summarize,
      N = sum(!is.na(PercentageUnderwear)),
      mean = mean(PercentageUnderwear),
      sd = sd(PercentageUnderwear),
      se = sd/sqrt(N)
)
```


ANOV(ugh): Summary Table of Means
========================================================
incremental: true
type: sub-section


```r
head(firstday.data.summary)
```

```
  Underwear  N  mean    sd    se
1       Yes 32 50.38 21.06 3.722
2        No 25 30.32 22.91 4.581
```


ANOV(ugh): Plot
========================================================
incremental: false


```r
library(ggplot2)
```

------

![plot of chunk unnamed-chunk-11](Welcome_100113-figure/unnamed-chunk-11.png) 

