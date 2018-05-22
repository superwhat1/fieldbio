library(tidyverse)
library(vegan)
library(lmtest)
library(car)

setwd("/home/superwhat/Documents/Field Genomics/Garlic Mustard")

FloristicSurvey = read.csv("/home/superwhat/Documents/Field Genomics/Garlic Mustard/Rob_summercourse/Rob_summercourse/May9_floristicsurvey.csv")

MyData = FloristicSurvey[,1:10]
MyData$Population = as.factor(MyData$Population)

SpeciesComp = FloristicSurvey[,11:length(FloristicSurvey)]
rownames(SpeciesComp) = MyData[,1]

#Species.alpha.diversity.model

MyData$Richness = rowSums(SpeciesComp !=0)
MyData$Diversity = diversity(SpeciesComp,index = "Diversity")

mod1 = lm(Richness~Population+Location+Rosettes+Bolting+Budding+Bud_Flw, data=MyData)

car::qqp(MyData$Richness, "norm")

plot(mod1)
bptest(mod1) #test to see if it fits/ is homoscedastic

mod1_mPopulation = lm(Richness ~ Location+Rosettes+Bolting+Budding+Bud_Flw, data=MyData)
anova(mod1, mod1_mPopulation)

mod1_Location= lm(Richness ~ Population+Rosettes+Bolting+Budding+Bud_Flw, data=MyData)
anova(mod1, mod1_Location)

mod1 = mod1_Location

mod1_mRosettes = lm(Richness ~ Population+Bolting+Budding+Bud_Flw, data=MyData)
anova(mod1, mod1_mRosettes)

mod1=mod1_mRosettes

mod1_mBudding = lm(Richness ~ Population+Bolting+Bud_Flw, data=MyData)
anova(mod1, mod1_mBudding)

mod1_mBolting = lm(Richness ~ Population+Bud_Flw, data=MyData)
anova(mod1, mod1_mBolting)

mod1_mBud_Flw = lm(Richness ~ Population, data=MyData)
anova(mod1, mod1_mBud_Flw)

mod1 = mod1_mBud_Flw

coefplot(mod1)
summary(mod1)

ggplot(MyData, aes(y=Richness, x=Location)) + geom_boxplot(aes(color=Location))


