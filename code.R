# 		-----------------Code repository for Assignment 1--------------- 

library(cluster)
library(factoextra)
data<-read.csv("market.csv",header=TRUE)
head(data)
summary(data)
df<-data[-c(1,2)]			# Avoid the categories Channel,Region (first two)
df<-na.omit(df)
df<-scale(df)
set.seed(100)
fviz_nbclust(df,kmeans,method="wss")
fviz_nbclust(df,kmeans,method="silhouette")
fviz_nbclust(df,kmeans,nstart=25,K.max=10,B=50)
k2<-kmeans(df,2,nstart=30)
k3<-kmeans(df,3,nstart=30) 
library(gridExtra)
p1<-fviz_cluster(k2,df)
p2<-fviz_cluster(k3,df)
grid.arrange(p1,p2,nrow=2)
boxplot(df)
library(tidyverse)
m<-c("average","single","complete","ward")
names(m)<-c("average","single","complete","ward")
ac<-function(x){
+ agnes(df,method=x)$ac}
map_dbl(m,ac)
  
d<-dist(df,method="euclidean")
hc1<-hclust(d,method="ward.D2")
plot(hc1,cex=0.6,hang=-1,main="Dendrogram of hclust")
hc3<-agnes(df,method="ward")
pltree(hc3,cex=0.6,hang=-1,main="Dendrogram of agnes")
hc4<-diana(df)
pltree(hc4,cex=0.6,hang=-1)
fviz_nbclust(df,hcut,"silhouette")
hc5<-hclust(d,method="ward.D2")
sub_group<-cutree(hc5,k=2)
fviz_cluster(list(data=df,cluster=sub_group))
library("mclust")
mc<-Mclust(df)
summary(mc)
fviz_mclust(mc,"BIC",palette="jco")
fviz_cluster(mc,df)
k7<-kmeans(df,7,nstart=30)
fviz_cluster(k7,df,nstart=30)
sub_group<-cutree(hc5,k=7)
fviz_cluster(list(data=df,cluster=sub_group))
data<-na.omit(data)
data<-scale(data)
k2<-kmeans(data,2,nstart=30)
fviz_cluster(k2,data,nstart=30)
d<-dist(data,method="euclidean")
hc1<-hclust(d,method="ward.D2")
sub_group<-cutree(hc1,k=2)
fviz_cluster(list(data=data,cluster=sub_group))
mc<-Mclust(data)
summary(mc)
library(dplyr)
data[1:2]%>%
+mutate(Cluster=k2$cluster)%>%
+filter(Cluster==1)%>% ungroup() %>% count(Channel,Region)
data[1:2]%>%
+mutate(Cluster=k2$cluster)%>%
+filter(Cluster==2)%>% ungroup() %>% count(Channel,Region)
data[1:2]%>%
+mutate(Cluster=sub_group)%>%
+filter(Cluster==1)%>% ungroup() %>% count(Channel,Region)
data[1:2]%>%
+mutate(Cluster=sub_group)%>%
+filter(Cluster==2)%>% ungroup() %>% count(Channel,Region)

