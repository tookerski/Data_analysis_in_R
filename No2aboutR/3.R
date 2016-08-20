#*********************************************************************************************/
#2.3.1 SQL语句介绍
library(sqldf)
#?sqldf
setwd('D:\\R_edu\\data')
sale <- read.csv("sale.csv")
#*********************************************************************************************/
#选择表中指定列*/
sqldf("select year,market,sale,profit from sale")
newtable<-sqldf("select year,market,sale,profit from sale")
#选择表中所有列*/
sqldf("select * from sale")

#选择满足条件的行*/
sqldf("select * from sale where year !=2010")
sqldf("select * from sale where year in (2010,2011)")

sqldf("select * from sale where (profit+0.0)/sale < 0.08")

sqldf("select * from sale where year =2010 and market='东'")
sqldf("select * from sale where year =2010 or market='东'")
sqldf("select * from sale where year =2010 and not market='东'")

#对行进行排序*/
sqldf("select year,market,sale,profit
      from sale
      order by 2")

#创建新列*/
sqldf("select (profit+0.0)/sale as rate from sale")
sqldf("select a.*,(profit+0.0)/sale as rate from sale as a")

sqldf("select a.*,(profit+0.0)/sale as rate from sale as a where rate<0.08")
sqldf("select a.*,(profit+0.0)/sale as rate from sale as a where rate<0.08")
#删除重复的行*/
sqldf("select DISTINCT  year,market from sale")



#2.3.2纵向连接表
?rbind
#library(sqldf)

one <- read.csv("one.csv")
two <- read.csv("two.csv")
two1 <- read.csv("two1.csv")
#UNION
UNION1<- rbind(one, two) #What is wrong?
names(two)<-c("x","a")
UNION2<- rbind(one, two1)  
UNION3<-sqldf("select * from one union select * from two")
UNION_all<-sqldf("select * from one union all select * from two")
#EXCEPT
EXCEPT<-sqldf("select * from one EXCEPT select * from two")
#INTERSECT
INTERSECT<-sqldf("select * from one INTERSECT select * from two")

#2.3.3横向连接表
?merge
library(dplyr)
?inner_join
?left_join
?full_join
?right_join
library(sqldf)
?sqldf

table1 <- read.csv("table1.csv")
table2 <- read.csv("table2.csv")
#cross join
cross<-sqldf("select * from table1,table2")
#inner join
inner1<- merge(table1, table2, by = "id", all = FALSE)
inner2<-inner_join(table1, table2, by = "id")
inner3<-sqldf("select * 
              from table1 as a 
              inner join table2 as b on a.id=b.id")
inner4<-sqldf("select * from table1 as a,table2 as b where a.id=b.id")

#left join
left1<- merge(table1, table2, by = "id", all.x = TRUE)
left2<-left_join(table1, table2, by = "id")
left3<-sqldf("select * from table1 as a left join table2 as b on a.id=b.id")
  
#right join
right1<- merge(table1, table2, by = "id", all.y = TRUE)
right2<-right_join(table1, table2, by = "id")
right3<-sqldf("select * from table1 as a right join table2 as b on a.id=b.id")

#full join
full1<- merge(table1, table2, by = "id", all = TRUE)
full2<-full_join(table1, table2, by = "id")
full3<-sqldf("select * from table1 as a full join table2 as b on a.id=b.id")

