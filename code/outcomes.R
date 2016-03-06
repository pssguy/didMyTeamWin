

page <- read_html("http://www.soccerbase.com/results/home.sd")


away <-html_nodes(page, ".awayTeam a") %>%
  html_text() 

home <-html_nodes(page, ".homeTeam a") %>%
  html_text() 

date <- html_nodes(page, ".date a") %>%
  html_text()

time <- html_nodes(page, ".time") %>%
  html_text()
## First value is "List match in Time order"
time <- time[-1]

scoreLines <- html_nodes(page, ".vs") %>%
  html_text() %>% 
  unlist() 

# test <- "2Â -Â 2"
# 
# test %>% 
#   extract_numeric()
# 
# str_extract_all(test,"[0-9]")[[1]]

hS <- character()
aS <- character()

for (i in 1:length(scoreLines)) {
  hS[i] <- str_extract_all(scoreLines,"[0-9]")[[i]][1]
  aS[i] <- str_extract_all(scoreLines,"[0-9]")[[i]][2]
}

df <- data.frame(away,home,date,time,hS,aS, stringsAsFactors = F) 
#glimpse(df)
df$hS <- as.integer(df$hS)
df$aS <- as.integer(df$aS)

data <- reactive({
  
  req(input$team)
  print(input$team)
res <-df %>% 
  filter(away==input$team|home==input$team) %>% 
  head(1) 


res$outcome <- "Win"

res$outcome[which(res$away==input$team&res$hS==res$aS)] <- "Draw"
res$outcome[which(res$home==input$team&res$hS==res$aS)] <- "Draw"
res$outcome[which(res$away==input$team&res$hS>res$aS)] <- "Loss"
res$outcome[which(res$home==input$team&res$hS<res$aS)] <- "Loss"

if (res$away==input$team&res$hS==res$aS) res$outcome <- "Draw"
if (res$home==input$team&res$hS==res$aS) res$outcome <- "Draw"
if (res$away==input$team&res$hS>res$aS) res$outcome <- "Loss"
if (res$home==input$team&res$hS<res$aS) res$outcome <- "Loss"

print(res$outcome)
print(res)

info=list(scoreline =res,result=res$outcome)
return(info)

})

output$result <- renderText({
  
  res <- data()$result
  print("res")
  print(res)
 
  text <- "pending"
  
  # if(input$result=="Win") ifelse(res=="Win",text="Yes",text="No")
  # if(input$result=="Loss") ifelse(res=="Loss",text="Yes",text="No")
  # if(input$result=="Draw") ifelse(res=="Draw",text="Yes",text="No")
  # if(input$result=="Not Win") ifelse(res!="Win",text="Yes",text="No")
  # if(input$result=="Not Lose") ifelse(res!="Loss",text="Yes",text="No")
  # if(input$result=="Not tie") ifelse(res!="Draw",text="Yes",text="No")
  
  if(input$result=="Not Win") {
     if(res!="Win") {
      text <- "Yes they did not win"
    } else {
      text <- "No they won"
    }
  }
  if(input$result=="Not Lose") {
    if(res!="Loss") {
      text <- "Yes they did not lose"
    } else {
      text <- "No they lost"
    }
  }
  if(input$result=="Not Draw") {
    if(res!="Draw") {
      text <- "Yes they did not draw"
    } else {
      text <- "No they drew"
    }
  }
  
  if(input$result=="Win") {
    if(res!="Win") {
      text <- "No they did not win"
    } else {
      text <- "Yes they won"
    }
  }
  if(input$result=="Lose") {
    if(res!="Loss") {
      text <- "No they did not lose"
    } else {
      text <- "Yes they lost"
    }
  }
  if(input$result=="Draw") {
    if(res!="Draw") {
      text <- "No they did not draw"
    } else {
      text <- "Yes they drew"
    }
  }
  
  text
})