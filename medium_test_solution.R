# Title: Medium Test Solution
# Evaluating Mentor: Marlon Cobos
# Contributor: Mariana Castaneda Guzman
# Date last updated: 03/05/2026


# Test Prompt and Level ---------------------------------------------------

# Test Level: Medium

# Test Prompt: 
# 1. Install and load shiny along with terra and geodata.
# 2. Build a Shiny interface that performs the workflow from the Easy test.
# 3. Include:
#   - A button that runs the workflow
#   - A plot panel displaying BIO1 after each step:
#     - Downloaded global raster
#     - Extracted BIO1 layer
#     - Cropped extent
#     - Masked final result

# Test Solution -----------------------------------------------------------

# 1. Install and load shiny along with terra and geodata. + sf for South America
# shapefile
if(!require("terra")) install.packages("terra")
if(!require("geodata")) install.packages("geodata")
if(!require("shiny")) install.packages("shiny")
if(!require("sf")) install.packages("sf")
if(!require("rnaturalearthdata")) install.packages("rnaturalearthdata")


# 2. Build a Shiny interface that performs the workflow from the Easy test.
ui <- pageWithSidebar(
  headerPanel("Medium Test Solution"),
  
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
                     duration = 3, 
                     type = "message") 

    # 2. Download WorldClim bioclimatic variables at 10 arc minute resolution.
    bio_data <- geodata::worldclim_global(var = "bio", res = 10, path = tempdir())
    bio <- 1
    
    # 3. Extract BIO1 (Annual Mean Temperature) from the dataset.
    selected_bio <- bio_data[[bio]]
    
    # 4. Crop or mask BIO1 to an extent covering South America (polygon or bounding box acceptable).
    world <- rnaturalearthdata::sovereignty50
    unique(world$continent)
    continent_selection <- "South America"
    
    # Cropping and masking
    continent_vect <-   sf::st_as_sf(world[world$continent == continent_selection, ])
    
    bio_cropped <- terra::crop(x = selected_bio, y = continent_vect)
    bio_cropped_masked <- terra::mask(x = bio_cropped, mask = continent_vect)
    
    
    # Plots
    output$step1 <- renderPlot({
      plot(bio_data)
    })
    
    output$step2 <- renderPlot({
      plot(selected_bio, main = "Step 2. Extract BIO1 (Annual Mean Temperature)")
    })
    
    output$step3 <- renderPlot({
      plot(bio_cropped, main = "Step 3. BIO1 cropped to South America")
    })
    
    output$step4 <- renderPlot({
      plot(bio_cropped_masked, main = "Step 4. BIO1 cropped and masked to South America")
    })
    
  })
}

# Run the app
shinyApp(ui = ui, server = server)


