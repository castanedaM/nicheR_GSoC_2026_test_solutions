#' Launch Shiny App for WorldClim Bioclim Workflow
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

      tags$p("Press the button to run the workflow below:"),
      tags$ul(
        tags$li("1. Download WorldClim bioclimatic variables at 10 arc minute resolution"),
        tags$li("2. Extract BIO1 (Annual Mean Temperature) from the dataset"),
        tags$li("3. Crop BIO1 to an extent covering South America"),
        tags$li("4. Mask BIO1 to South America"),
        tags$li("5. Plot the processed raster at each step")
      ),

      actionButton(
        inputId = "run",
        label = "Run",
        icon = icon("play")
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

      out <- helper_bio(bio = 1)

      output$step1 <- renderPlot({
        plot(out$bio_stack)
      })

      output$step2 <- renderPlot({
        plot(out$bio, main = "Step 2. BIO1 (Annual Mean Temperature)")
      })

      output$step3 <- renderPlot({
        plot(out$bio_cropped, main = "Step 3. BIO1 cropped to South America")
      })

      output$step4 <- renderPlot({
        plot(out$bio_masked, main = "Step 4. BIO1 cropped and masked to South America")
      })
    })

  }
  # Run the app
  shinyApp(ui = ui, server = server)

}



