library(xml2)
library(rvest)
library(stringr)

#爬取外交部部长活动信息，首页
wjb <- "https://www.fmprc.gov.cn/wjbzhd"
web <- read_html(wjb,encoding="UTF-8") #读取页面
news <- web %>% html_nodes('div.newsBd li a') #读取当页新闻
title <- news %>% html_text() #读取标题
link <- news %>% html_attrs() #读取链接
link1 <- c(1:length(link))
for (i in c(1:length(link1))) {
  link1[i] <-  link[[i]][1]
}
link2 <- paste("https://www.mfa.gov.cn/web/wjbzhd", link1, sep = "") 
link2 <- str_replace_all(link2,"hd./","hd/") 
news_content<-c(1:length(link2))
date<-c(1:length(link2))
for(i in 1:length(link2)){
  news_content[i] <- read_html(link2[i]) %>% html_nodes('div.news-main')%>% html_text() #读取正文
  date[i] <- read_html(link2[i]) %>% html_nodes('div.news-title p') %>% html_text() #读取日期
}
final <- data.frame(标题=title,日期=date,链接=link2,正文=news_content)
View(final)