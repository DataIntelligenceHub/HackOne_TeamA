library(corrplot)
library(caret)
library(xgboost)
library(stats)
library(knitr)
library(ggplot2)
library(Matrix)
#library(plotly)
#library(htmlwidgets)
#library(readr)
library(randomForest)
#library(data.table)
#library(h2o)
library(dplyr)
library(tidyr)




#df <- read.table("C:/Users/ammar.aamir/Documents/Hackone/CleanData.csv", header=TRUE)
df <- read.csv("C:/Users/ammar.aamir/Documents/Hackone/CleanData.csv", header=TRUE)
tdf <- read.csv("C:/Users/ammar.aamir/Documents/Hackone/test.csv", header=TRUE)



df
summary(df)


num.class = length(levels(factor(unlist(df[,"Response"]))))
y = as.matrix(as.integer(unlist(df[,"Response"]))-1)



cols.without.na = colSums(is.na(df)) == 0
df = df[, cols.without.na]
cols.without.na = colSums(is.na(tdf)) == 0
tdf = tdf[, cols.without.na]


x<-as.data.frame(head(df[,c("BMI")],100))
y1<-factor(unlist(head(df[,"Response"],100)))
trellis.par.set(theme = col.whitebg(), warn = FALSE)
featurePlot(x, y1, "box",auto.key = list(columns = 3))


x<-as.data.frame(head(df[,c("Medical_Keyword_3")],100))
y1<-factor(unlist(head(df[,"Response"],100)))
trellis.par.set(theme = col.whitebg(), warn = FALSE)
featurePlot(x, y1, "box",auto.key = list(columns = 3))


x<-as.data.frame(head(df[,c("Medical_Keyword_15")],100))
y1<-factor(unlist(head(df[,"Response"],100)))
trellis.par.set(theme = col.whitebg(), warn = FALSE)
featurePlot(x, y1, "box",auto.key = list(columns = 3))


x<-as.data.frame(head(df[,c("Medical_History_4")],100))
y1<-factor(unlist(head(df[,"Response"],100)))
trellis.par.set(theme = col.whitebg(), warn = FALSE)
featurePlot(x, y1, "box",auto.key = list(columns = 3))

x<-as.data.frame(head(df[,c("Employment_Info_3")],100))
y1<-factor(unlist(head(df[,"Response"],100)))
trellis.par.set(theme = col.whitebg(), warn = FALSE)
featurePlot(x, y1, "box",auto.key = list(columns = 3))


x<-as.data.frame(head(df[,c("Ins_Age")],100))
y1<-factor(unlist(head(df[,"Response"],100)))
trellis.par.set(theme = col.whitebg(), warn = FALSE)
featurePlot(x, y1, "box",auto.key = list(columns = 3))

x<-as.data.frame(head(df[,c("Employment_Info_2")],100))
y1<-factor(unlist(head(df[,"Response"],100)))
trellis.par.set(theme = col.whitebg(), warn = FALSE)
featurePlot(x, y1, "box",auto.key = list(columns = 3))


x<-as.data.frame(head(df[,c("Medical_History_28")],100))
y1<-factor(unlist(head(df[,"Response"],100)))
trellis.par.set(theme = col.whitebg(), warn = FALSE)
featurePlot(x, y1, "box",auto.key = list(columns = 3))



x<-as.data.frame(head(df[,c("Product_Info_2")],100))
y1<-factor(unlist(head(df[,"Response"],100)))
trellis.par.set(theme = col.whitebg(), warn = FALSE)
featurePlot(x, y1, "box",auto.key = list(columns = 3))












corrplot.mixed(cor(df[,c("Response", "Medical_Keyword_3" , "Medical_Keyword_15", "Medical_History_4", "BMI",
                         "Medical_History_28","Ins_Age", "Employment_Info_3", "Medical_History_28", "Product_Info_3")]), lower="circle", upper="number", 
               tl.pos="lt", tl.cex=0.6, diag="n", order="hclust", hclust.method="complete")


qplot(data = df,Product_Info_2,Ins_Age / 100, colour="color", aes(x=Product_Info_2,y = Ins_Age/100)) +geom_bar(stat = "identity")



plot(df$Response, df$Ins_Age, col=c("red"), na.rm="True")
plot(df$Response, df$BMI, col=c("red"), na.rm="True")
plot(df$Response, df$Medical_History_4, col=c("red"), na.rm="True")



hist(df$Response)