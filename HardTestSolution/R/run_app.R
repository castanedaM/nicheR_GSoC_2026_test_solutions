#' Run the Easy/Medium test Workflow Shiny App
#'
#' Launches a Shiny app that demonstrates a simple workflow.
#' The app downloads WorldClim bio-climatic variables, extracts BIO1 (Annual Mean
#' Temperature), crops the raster to South America, masks it to the
#' continent, and plots each step of the process.
#'
#' @details
#' The workflow is executed when the user presses the **Run** button.
#' Each processing step is shown in the main panel as a raster plot.
#'
#' @return Launches an interactive Shiny application.
#'
#' @import shiny
#' @import terra
#'
#' @export
run_app <- function(){
  # 2. Build a Shiny interface that performs the workflow from the Easy test.
  ui <- pageWithSidebar(
    headerPanel("Hard Test Solution"),

    sidebarPanel(

      selectInput(
        inputId = "bio",
        label = "1. Select which BIO variable to extract from the dataset:",
        choices = 1:19,
        selected = 1
      ),

      selectInput(
        inputId = "region",
        label = "2. Select the region you wish to crop and mask by:",
        choices = c("South America",
                    "North America",
                    "Europe",
                    "Africa",
                    "Asia",
                    "Oceania"),
        selected = "South America"
      ),

      tags$b("3. Press the button to run the workflow with your selected BIO and region:"),
      tags$br(),

      actionButton(
        inputId = "run",
        label = "Run",
        icon = icon("play")
      ),

      tags$br(),
      tags$br(),

      tags$b("Summary workflow:"),
      tags$br(),

      tags$ul(
        tags$li("1. Download WorldClim bioclimatic variables at 10 arc minute resolution"),
        tags$li("2. Extract the selected BIO variable from the dataset"),
        tags$li("3. Crop the raster to the selected region"),
        tags$li("4. Mask the raster to the selected region"),
        tags$li("5. Plot the processed raster at each step")
      )

    ),

    mainPanel(
      plotOutput(outputId = "step1"),
      plotOutput(outputId = "step2"),
      plotOutput(outputId = "step3"),
      plotOutput(outputId = "step4")
    )
  )

  server <- function(input, output, session) {

    observeEvent(input$run, {

      showNotification("The workflow has begun computing!",
                       duration = 5,
                       type = "message")

      out <- helper_bio(bio = input$bio,
                        region = input$region)

      output$step1 <- renderPlot({
        plot(out$bio_stack)
      })

      output$step2 <- renderPlot({
        plot(out$bio,
             main = paste0("BIO", input$bio))
      })

      output$step3 <- renderPlot({
        plot(out$bio_cropped,
             main = paste0("BIO", input$bio, " cropped"))
      })

      output$step4 <- renderPlot({
        plot(out$bio_masked,
             main = paste0("BIO", input$bio, " cropped + masked to ", input$region))
      })

    })

  }

  # Run the app
  shinyApp(ui = ui, server = server)

}



