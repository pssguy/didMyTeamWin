library(shiny)
library(shinydashboard)

library(rvest)
library(dplyr)
library(readr)
library(tidyr)
library(stringr)

teams <- read_csv("data/teams.csv")

teamChoice <- teams$team


