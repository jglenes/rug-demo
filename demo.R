# Interpreting SPSS Files
install.packages("foreign")
library("foreign")

# Reading the data to a data.frame R object
firstday.data <- read.spss(
  file="SOP4004.Questionnaire.sav",
  use.value.labels=T,
  use.missings=F,
  to.data.frame=T # We want this
)

# What are our variables called?
names(firstday.data)

# What does the data look like?
head(firstday.data[2:3]) # That's our data.frame object, being called by head()
head(firstday.data[,c("Underwear","PercentageUnderwear")]) # Same as above
firstday.data[1:5,c("Underwear","PercentageUnderwear")] # Same as above

# In RStudio
View(firstday.data)

# Let's run an ANOVA
underwear.aov <- aov(PercentageUnderwear ~ Underwear,data=firstday.data)

# What do the results look like?
summary(underwear.aov) # Hallelujah, p < .05

# In order to make some pretty graphs, we need to "melt" the data how the ggplot family likes.

install.packages(c("reshape2","ggplot2","plyr"),dependencies=T)
library(reshape2)
library(ggplot2)
library(plyr)

# Make a new dataframe with means
firstday.data.summary <- ddply(na.omit(firstday.data), .(Underwear), summarize,
      N = sum(!is.na(PercentageUnderwear)),
      mean = mean(PercentageUnderwear),
      sd = sd(PercentageUnderwear),
      se = sd/sqrt(N)
)

# Let's make a really nice plot in ggplot. Don't worry about all of this syntax for now.

ggplot(firstday.data.summary, aes(x=factor(firstday.data.summary$Underwear), y=mean, fill=factor(firstday.data.summary$Underwear))) +
  geom_bar(stat="identity") +
  geom_errorbar(
    aes(ymin=mean-se, ymax=mean+se),
    width=.1,                    # Width of the error bars
    position=position_dodge(.9)
  ) +
  labs(
    title="Estimate the percentage of your peers who would\n agree to stand in front of the class in their underwear\n"
  ) +
  guides(fill=F) +
  scale_x_discrete(name="\nIf Josh were to give you $500 to stand in front of\n the class in your underwear, would you do it?",breaks=c("Yes","No"),labels=c("Yes","No")) +
  scale_y_continuous(name="Mean percentage of peers who would stand in their underwear\n") +
  scale_fill_hue()