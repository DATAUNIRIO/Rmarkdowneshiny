library(shiny)

# Step 1: Building the UI framework
ui <- fluidPage (
  titlePanel(title="Meu primeiro app, . . . " ) ,
  sidebarLayout(position="right" ,
  sidebarPanel("Painel lateral , . . . " ) ,
  mainPanel ( "Painel principal, aqui posso escrever o que quiser. . . " ))
)
server<- function(input,output){}

shinyApp(ui = ui,server=server)

#################################################################################
#Step 2: Build the input structure in the sidebar panel

ui <- fluidPage (
  titlePanel(title="Meu segundo app, . . . " ) ,
  sidebarLayout(position="right" ,
  sidebarPanel("Painel lateral", 
  numericInput (inputId="n" , "Sample s i z e " , value=10)) ,
  mainPanel ( "Painel principal, aqui posso escrever o que quiser. . . " ))
)
server<- function(input,output){}

shinyApp(ui = ui,server=server)

#################################################################################
# Step 3: Link the user inputs with server and Output the boxplot in the UI main panel 
ui <- fluidPage (
  titlePanel(title="Meu terceiro app, . . . " ) ,
  sidebarLayout(position="right" ,
                sidebarPanel("Painel lateral", 
                             numericInput (inputId="n" , "Tamanho da Amostra" , value=10)) ,
                mainPanel("Painel principal, aqui posso escrever o que quiser. . . ",
                          plotOutput(outputId="box"))))

server<- function(input,output){
  output$box<-renderPlot({boxplot(rnorm(input$n), 
  col="blue", main="Boxplot de uma distribuicao normal",
  xlab="Dados da amostra")})}

shinyApp(ui = ui,server=server)


#################################################################################
# Step 4: Extend slider panel layout and Link the extra user inputs with R
ui <- fluidPage (
  titlePanel(title="Meu quarto APP, . . . " ) ,
  sidebarLayout(position="right" ,
                sidebarPanel("Painel lateral", 
                   numericInput(inputId="n" , "Tamanho da Amostra" , value=10),
                   textInput(inputId="title", "Titulo do Grafico" , "Boxplot Bonito"),
                   radioButtons(inputId="color" ,"Choose", list("Blue","Green"),"Green"),
                   submitButton("Apply changes")),
                mainPanel("Painel principal, aqui posso escrever o que quiser. . . ",
                plotOutput(outputId="box"))))

server<- function(input,output){
  output$box<-renderPlot({boxplot(rnorm(input$n), 
                col=input$color, main=input$title,xlab="Dados da amostra")})}

shinyApp(ui = ui,server=server)

#################################################################################
#################################################################################
#################################################################################
# Step 1: Create basic layout structure
ui <- fluidPage (
  titlePanel(title="Meu primeiro app, . . . " ) ,
  sidebarLayout(position="right" ,
                sidebarPanel("Painel lateral , . . . " ) ,
                mainPanel ( "Painel principal, aqui posso escrever o que quiser. . . " ))
)
server<- function(input,output){}

shinyApp(ui = ui,server=server)

#################################################################################
# Step 2: Build the input structure in the sidebar panel
ui <- fluidPage (
  titlePanel(title="Meu primeiro app, . . . " ) ,
  sidebarLayout(position="right" ,
                sidebarPanel(
                  selectInput(inputId="var", " 1 .
                  Selecione. . . " , choices=c(
  "Sepal.Length"=1,"Sepal.Width"=2 , "Petal.Length"=3,"Petal.Width"=4),selected=3, selectize=FALSE) ,
                  sliderInput(inputId="bin", "2. Selecione. . . " , min=5, max=25, value=15) ,
  radioButtons(inputId="colour", label="3.Selecione. . . " , choices=c ("black" , " yellow" , "red"), selected="yellow")
                             ) ,
                mainPanel ( "Painel principal, aqui posso escrever o que quiser. . . " ))
)
server<- function(input,output){}

shinyApp(ui = ui,server=server)

#################################################################################
#Step 3: Link the user inputs with R and Create tabsets with outputs in the UI main panel
ui <- fluidPage(
  titlePanel(title="Meu App com TabsetPanel, . . . " ) ,
  sidebarLayout(
    sidebarPanel(selectInput(inputId="var", " 1.Selecione. " ,
                   choices=c("Sepal.Length"=1,"Sepal.Width"=2 , "Petal.Length"=3,"Petal.Width"=4),selected=3, selectize=FALSE),
                  sliderInput(inputId="bin", "2. Selecione. " , min=5, max=25, value=15),
                  radioButtons(inputId="colour", label="3.Selecione." , choices=c ("black" , " yellow" , "red"), selected="yellow")),
  mainPanel(
    tabsetPanel(type="tab",
      tabPanel("Panel 1",
          textOutput(outputId="text1"),
          plotOutput(outputId="myhist")),
      tabPanel ("Panel 2" ,
          tableOutput(outputId="summary"))))))

server<- function(input,output){
  output$text1<- renderText({
    colm = as.numeric(input$var)
    paste ("Tipo " , names(iris[colm]))})
  
  output$myhist<- renderPlot({
    colm = as.numeric(input$var)
    hist(iris[,colm],col=input$colour,
         xlim = c(0, max(iris[,colm])),
         main = " Histograma" , breaks=seq(0,max(iris[ ,colm]), l=input$bin+1),
         xlab = names(iris[colm]))})
  output$summary <- renderTable({summary(iris)})
}
shinyApp(ui = ui,server=server)

#################################################################################
################ DESAFIO  - colocar mais uma cor 
################ DESAFIO2 - colocar mais um tabPainel com um boxplot
#################################################################################



ui <- fluidPage(
  titlePanel(title="Meu App com TabsetPanel." ) ,
  sidebarLayout(
    sidebarPanel(selectInput(inputId="var", " 1.Selecione. " ,
                             choices=c("Sepal.Length"=1,"Sepal.Width"=2 , "Petal.Length"=3,"Petal.Width"=4),selected=3, selectize=FALSE),
                 sliderInput(inputId="bin", "2. Selecione. " , min=5, max=25, value=15),
                 radioButtons(inputId="colour", label="3.Selecione." , choices=c ("black" , " yellow" , "red"), selected="yellow")),
    mainPanel(
      tabsetPanel(type="tab",
                  tabPanel("Panel 1",
                           textOutput(outputId="text1"),
                           plotOutput(outputId="myhist")),
                  tabPanel("Panel 2",
                          tableOutput(outputId="summary")),
                  tabPanel("Panel 3",
                               plotOutput(outputId="box"))))))

server<- function(input,output){
  output$text1<- renderText({
    colm = as.numeric(input$var)
    paste ("Tipo " , names(iris[colm]))})
  
  output$myhist<- renderPlot({
    colm = as.numeric(input$var)
    hist(iris[,colm],col=input$colour,
         xlim = c(0, max(iris[,colm])),
         main = " Histograma" , breaks=seq(0,max(iris[ ,colm]), l=input$bin+1),
         xlab = names(iris[colm]))})
  
  output$summary <- renderTable({summary(iris)})
  
  output$box<-renderPlot({
    colm = as.numeric(input$var)
    boxplot(iris[,colm],col=input$colour,
            xlab = names(iris[colm]))})
}

shinyApp(ui = ui,server=server)

#################################################################################


