#Add libraries
library("ggplot2")
library("doBy")

#Read in data
nyt <- read.table("nyt1.csv",header=TRUE, ",")
class(data)

#Catagorize by age
bins <- c(-Inf,18,24,34,44,54,64,Inf)
nyt$AgeGroup = cut(nyt$Age,bins)
levels(nyt$AgeGroup) <- c("<18", "18-24", "25-34", "35-44", "45-54", "55-64", "65+")

#Confirm changes
summary(nyt)
head(nyt)
str(nyt)

#Subset data where Impressions > 0
ImpSub = subset(nyt, Impressions > 0)

#Confirm subset changes
summary(ImpSub)
head(ImpSub, 100)
str(ImpSub)

#Create click through rate variable
ImpSub$CTR = ImpSub$Clicks/ImpSub$Impressions
head(ImpSub, 100)

#plot distribution of impressions 
ggplot(data=ImpSub, aes(x=Impressions, fill=AgeGroup)) +
  geom_histogram(binwidth = 1)

#plot distribution of CTR
ggplot(subset(ImpSub,CTR>0), aes(x=CTR, fill=AgeGroup)) +
  geom_histogram(binwidth = .05)

ctrbins <- c(-Inf,0.2,0.4,0.6,0.8,Inf)
ImpSub$CTRGroup = cut(ImpSub$CTR,ctrbins,right=FALSE)
levels(ImpSub$CTRGroup) <- c("CTR< 0.2", "0.2<=CTR<0.4", "0.4<=CTR<0.6", "0.6<=CTR<0.8", "CTR>0.8")



#Get mean of age
mean(ImpSub$Age)

#Get mean of Impressions
mean(ImpSub$Impressions)

#Get mean of CTR
mean(ImpSub$CTR)

#Percentage of Males and Femals
cbind( Freq=table(ImpSub$Gender), relative=100*prop.table(table(ImpSub$Gender)))

#Percentage of Signed in
cbind( Freq=table(ImpSub$Signed_In), relative=100*prop.table(table(ImpSub$Signed_In)))

#Get means of Impressions by Age group
summaryBy(Impressions~AgeGroup,data=ImpSub,FUN=c(mean))

#Get means of CTR by Age group
summaryBy(CTR~AgeGroup,data=ImpSub,FUN=c(mean))

#Get means of Gender by Age group
summaryBy(Gender~,data=ImpSub,FUN=c(mean))

#Get means of Signed_In by Age group
summaryBy(Signed_In~AgeGroup,data=ImpSub,FUN=c(mean))

CTRAgeGroup <- table(ImpSub$CTRGroup,ImpSub$AgeGroup)

ggplot(subset(ImpSub,CTR>0), aes(x=CTR, fill=AgeGroup)) +
  geom_histogram(binwidth = .025)

ggplot(subset(ImpSub,CTR>0), aes(x=CTR, fill=AgeGroup)) +
  geom_density()




