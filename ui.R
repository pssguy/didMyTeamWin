

dashboardPage(title = "Did my team Win?",
  skin = "blue",
  dashboardHeader(title = "Did my team Win?", titleWidth=400),
  
  dashboardSidebar(
     includeCSS("custom.css"),
    includeMarkdown("about.md"),
    selectInput("team","Choose Team",teamChoice,selected="C Palace"),
    radioButtons("result","Did My Team",
                 c("Win","Lose","Draw","Not Win","Not Lose","Not Draw"),
                 selected="Not Lose"
                 ),
    radioButtons("score","Show Scoreline", c("No","Yes")),
                
                 
    
    
    sidebarMenu(
      id = "sbMenu",
      
      menuItem(
        "Results",tabName= "results"
     
      ),
      
  #    menuItem("Info", tabName = "info", icon = icon("info")),
      

tags$hr(),
menuItem(text="",href="https://mytinyshinys.shinyapps.io/dashboard",badgeLabel = "All Dashboards and Trelliscopes (14)"),
tags$hr(),

tags$body(
     a(class="addpad",href="https://twitter.com/pssGuy", target="_blank",img(src="images/twitterImage25pc.jpg")),
     a(class="addpad2",href="mailto:agcur@rogers.com", img(src="images/email25pc.jpg")),
     a(class="addpad2",href="https://github.com/pssguy",target="_blank",img(src="images/GitHub-Mark30px.png")),
     a(href="https://rpubs.com/pssguy",target="_blank",img(src="images/RPubs25px.png"))
)

      
    
  )),
  dashboardBody(
    tabItems(
    tabItem("results",
            textOutput("result"))
  
    
    
    
  ) # tabItems
  ) # body
  ) # page
  