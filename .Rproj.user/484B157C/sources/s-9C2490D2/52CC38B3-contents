LyDat = read.csv("./Lythrum2013Data.csv")

View(LyDat)

str(LyDat) #Structure of the data
library(ggplot2)

# Scatterplot of infructescence biomass by number of fruits 
qplot(x=InfMass07,y=Fruits07, data=LyDat, colour=Site)
LyDat$Site[136:285] #subset only KSR sites in the Site column

#Subset only KSR sites in the LyDat dataframe object
KSR = LyDat[136:285,]

qplot(x=InfMass07,y=Fruits07, data=KSR, colour=Site) + theme_classic() + geom_smooth(method=lm)

#Estimate the equation for the line of Fruits ~ InfMass07 
mod1 = lm(Fruits07~InfMass07, data=KSR)
View(mod1)
summary(mod1)

#Add a new column to LyDat containing Total Infructescence for 
LyDat$InfMassTot = LyDat$InfMass07 +LyDat$InfMass08 + LyDat$InfMass09 +LyDat$InfMass10

#Problem: Adding columns with NA returns NA

#New DataFrame replacing NAs with zero
LyDat0 = LyDat
LyDat0[is.na(LyDat0)]=0

#Use LyDat0 as an index for LyDat
LyDat$InfMassTot = LyDat0$InfMass07 +LyDat0$InfMass08 + LyDat0$InfMass09 +LyDat0$InfMass10

#Add column for total Fruit number
LyDat$TotFruit = LyDat$InfMassTot*26.6-53.986

#Add a column for raltive fitness
LyDat$RelFit = LyDat$TotFruit/mean(LyDat$TotFruit, na.rm=T) #na.rm removes NAs when calculating the mean Otherwise it will return NA

#Vizualize relative fitness for Flowering Date in 2010

qplot(x=Flwr10, y=RelFit, data=LyDat) + geom_smooth()

qplot(x=Flwr10, y=RelFit, data=LyDat) + geom_smooth(method="lm")
#Test for directional selection
# IMPORTANT: must use relative fitness (divided by mean fitness)

#Test for Stabalizing selection using a quadratic equation
mod2 =lm(RelFit~Flwr10+I(Flwr10^2), data=LyDat)
summary(mod2)

Origin = gsub('[AC].+', '1_North', LyDat$Mat)
Origin = gsub('[EJ].+', '2_Mid', Origin)
Origin = gsub('[TS].+','3_South',Origin)
LyDat$Origin = Origin
View(LyDat)
#Test for local adaptation
mod3 =lm(log(RelFit+1)~Site+Origin+Site:Origin, data=LyDat)
#Shorthand 
mod3 = lm(RelFit~Site*Origin)

summary(mod3)
qplot(x=Origin, y=RelFit, data=LyDat, geom="boxplot", colour=Origin) 
# Inspect didtribution of Relfit
qplot(x=RelFit,data=LyDat, facets=Origin~.)

# Aproximate Local adaptation figure
qplot(x=Site, y=RelFit, data=LyDat, facets=Origin~., geom='boxplot', fill = Site) +theme_classic()

# Mixed effects
library(lme4)
# Mixed effects models include random effects
# Random effects are added with +()
LMM1 = lmer(log(RelFit+1)~Site*Origin+(1|Mat),data=LyDat)
summary(LMM1)

# Compare to a simple model 
LMM0 = lmer(log(RelFit+1)~1+(1|Mat),data = LyDat)
summary(LMM0)

#Different among-family variances for each Origin
LMM2 = lmer(log(RelFit+1)~Site*Origin+(Origin|Mat),data = LyDat)
summary(LMM2)

#Do the Origins differ in the among-family variance?
# Use a likelihood ratio test
anova(LMM2,LMM1)










