#' Launch Shiny App for WorldClim Bioclim Workflow
#'
#' Launches an interactive Shiny application that demonstrates a
#' reproducible geospatial workflow using WorldClim bioclimatic data.
#'
#' The application performs the following steps after clicking the
#' **Run** button:
#' \enumerate{
#'   \item Downloads WorldClim bioclimatic variables (10 arc-minute resolution).
#'   \item Extracts a selected BIO variable (default = BIO1).
#'   \item Crops the raster to South America.
#'   \item Masks the raster using a South America boundary shapefile.
#'   \item Plots results at each processing step.
#' }
#'
#' The processing workflow is handled internally by \code{helper_bio()}.
#'
#' The South America shapefile must be available locally at:
#' \code{./data/south_america/vc965bq8111.shp}
#'
#' @details
#' WorldClim data are downloaded temporarily using
#' \code{geodata::worldclim_global()} and stored in \code{tempdir()}.
#' Reactive execution is triggered via \code{observeEvent()}.
#'
#' @return
#' A \code{shiny.appobj} that launches the interactive interface.
#'
#' @seealso
#' \code{\link{helper_bio}},
#' \code{\link[geodata]{worldclim_global}},
#' \code{\link[terra]{crop}},
#' \code{\link[terra]{mask}}
#'
#' @examples
#' \dontrun{
#' run_app()
#' }
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

      out <- helper_bio(selected_bio = 1)

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



